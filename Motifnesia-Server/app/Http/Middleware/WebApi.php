<?php

namespace App\Http\Middleware;

use App\Support\WebApi\Viewer;
use Closure;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Session\ArraySessionHandler;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Cache;
use Illuminate\Support\ViewErrorBag;
use Laravel\Sanctum\PersonalAccessToken;
use Symfony\Component\HttpFoundation\RedirectResponse;
use Symfony\Component\HttpFoundation\Response;

class WebApi
{
    public function handle(Request $request, Closure $next): Response
    {
        $request->headers->set('Accept', 'application/json');
        $previousGuard = Auth::getDefaultDriver();
        $guard = Auth::guard('sanctum');
        $guard->forgetUser();
        Auth::shouldUse('sanctum');

        try {
            return $this->authorizeAndRun($request, $next);
        } finally {
            $guard->forgetUser();
            Auth::shouldUse($previousGuard);
        }
    }

    private function authorizeAndRun(Request $request, Closure $next): Response
    {
        $user = $request->bearerToken() ? $request->user() : null;
        $token = $user?->currentAccessToken();

        if ($request->bearerToken() && (! $token instanceof PersonalAccessToken || ! $token->can('motifnesia:v1'))) {
            return response()->json(['message' => 'Sesi Anda sudah berakhir. Silakan login kembali.'], 401);
        }
        if ($user && $user->role !== 'admin' && $user->account_status !== 'active'
            && ! $request->routeIs('v1.auth.logout')) {
            return response()->json(['message' => 'Akun Anda sedang dinonaktifkan.'], 401);
        }

        $name = $request->route()->getName();
        $role = explode('.', $name)[1];
        $public = in_array($name, ['v1.viewer', 'v1.auth.logout', 'v1.customer.home', 'v1.customer.product.detail', 'v1.customer.search.live'], true);
        if (! $public && $role !== 'auth' && ! $user) {
            return response()->json(['message' => 'Silakan login terlebih dahulu.'], 401);
        }
        if ((! $public && $role !== 'auth' && $user->role !== $role)
            || ($name === 'v1.customer.home' && $user?->role === 'admin')) {
            return response()->json([
                'message' => 'Halaman ini tidak tersedia untuk peran Anda.',
                'redirect' => Viewer::home($user),
            ], 403);
        }
        if ($user && $role === 'auth' && $name !== 'v1.auth.logout') {
            return response()->json(['redirect' => Viewer::home($user)], 409);
        }

        $workflow = $token && $request->routeIs(
            'v1.customer.cart.checkout', 'v1.customer.checkout.*', 'v1.customer.payment.*',
            'v1.admin.membership-broadcast.*',
        );

        if ($workflow) {
            $cache = Cache::store(config('motifnesia.workflow_store'));
            $key = 'motifnesia-workflow:'.$token->getKey();

            return $cache->lock($key.':lock', 120)->block(5, function () use ($request, $next, $cache, $key) {
                return $this->run($request, $next, $cache->get($key, []), function (array $state) use ($cache, $key) {
                    $state === [] ? $cache->forget($key) : $cache->put($key, $state, now()->addHours(12));
                });
            });
        }

        return $this->run($request, $next);
    }

    private function run(Request $request, Closure $next, array $state = [], ?Closure $persist = null): Response
    {
        $sessions = session();
        $driver = $sessions->getDefaultDriver();
        $sessions->extend('motifnesia_request', fn () => new ArraySessionHandler(1));
        $sessions->setDefaultDriver('motifnesia_request');
        $session = $sessions->driver();
        $session->replace($state);
        $request->setLaravelSession($session);
        $redirector = redirect();
        $redirector->setSession($session);

        try {
            $response = $next($request);
            if ($persist && $response->getStatusCode() < 500) {
                if ($request->routeIs('v1.admin.membership-broadcast.index')) {
                    $session->forget(['broadcast_message', 'broadcast_caption']);
                }
                $persist($session->only(['checkout_items', 'checkout_data', 'broadcast_message', 'broadcast_caption']));
            }

            if ($response instanceof RedirectResponse) {
                $flash = $session->only(['success', 'error', 'warning', 'info']);
                $bag = $session->get('errors');
                $errors = $bag instanceof ViewErrorBag ? $bag->getBag('default')->getMessages() : [];

                $response = response()->json([
                    'redirect' => $this->localPath($response->getTargetUrl(), $request),
                    'flash' => $flash,
                    'errors' => $errors,
                    'message' => $flash['error'] ?? $flash['success'] ?? null,
                ], $errors || isset($flash['error']) ? 422 : 200);
            } elseif ($response instanceof JsonResponse) {
                $data = $response->getData(true);
                if (is_array($data) && isset($data['redirect_url'])) {
                    $data['redirect_url'] = $this->localPath($data['redirect_url'], $request);
                    $response->setData($data);
                }
            }

            $response->headers->set('Cache-Control', 'no-store');

            return $response;
        } finally {
            $session->flush();
            $sessions->setDefaultDriver($driver);
            $redirector->setSession($sessions->driver());
        }
    }

    private function localPath(string $url, Request $request): string
    {
        $parts = parse_url($url);
        $path = $parts['path'] ?? '/';
        $allowedHosts = [$request->getHost(), parse_url(config('motifnesia.client_url'), PHP_URL_HOST)];
        if ($parts === false || (isset($parts['host']) && ! in_array($parts['host'], $allowedHosts, true))
            || ! str_starts_with($path, '/') || str_starts_with($path, '//') || str_contains($path, '\\')) {
            return '/';
        }

        return $path.(isset($parts['query']) ? '?'.$parts['query'] : '');
    }
}
