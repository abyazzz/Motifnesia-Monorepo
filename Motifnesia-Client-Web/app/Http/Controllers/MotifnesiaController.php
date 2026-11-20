<?php

namespace App\Http\Controllers;

use App\Support\MotifnesiaApi;
use App\Support\PageData;
use App\Support\Viewer;
use Illuminate\Http\Client\ConnectionException;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class MotifnesiaController
{
    private const AUTH_VIEWS = [
        'auth.login' => 'auth.login',
        'auth.register' => 'auth.register',
        'auth.forgot' => 'auth.forgot',
    ];

    public function __invoke(Request $request, MotifnesiaApi $api)
    {
        try {
            return $this->handle($request, $api);
        } catch (ConnectionException $exception) {
            report($exception);
            abort(503, 'Server Motifnesia sedang tidak dapat dihubungi.');
        }
    }

    private function handle(Request $request, MotifnesiaApi $api)
    {
        Auth::guard()->forgetUser();
        $session = $request->session();
        $token = $session->get('motifnesia_token');
        $name = $request->route()->getName();
        $path = $request->path();

        if ($name === 'home' || isset(self::AUTH_VIEWS[$name])) {
            if ($token) {
                $response = $api->send($request, 'viewer', $token);
                if ($response->unauthorized()) {
                    $session->forget('motifnesia_token');
                } else {
                    abort_unless($response->successful(), 503, 'Sesi Motifnesia tidak dapat diperiksa.');

                    return redirect(MotifnesiaApi::localPath($response->json('viewer.home')) ?? '/homePage');
                }
            }

            return $name === 'home' ? redirect()->route('customer.home') : view(self::AUTH_VIEWS[$name]);
        }

        $response = $api->send($request, $path, $token);
        if ($response->unauthorized() && $token) {
            $session->forget('motifnesia_token');
            if (in_array($name, ['customer.home', 'customer.search.live', 'customer.product.detail'], true)) {
                $response = $api->send($request, $path);
            }
        }

        if ($name === 'auth.logout' && ($response->successful() || $response->unauthorized())) {
            $session->invalidate();
            $session->regenerateToken();

            return redirect()->route('auth.login')->with('success', 'Berhasil logout.');
        }

        $contentType = $response->header('Content-Type');
        if (! str_contains($contentType, 'json')) {
            $isDownload = $name === 'admin.reports.export';
            $isProof = in_array($name, ['admin.orders.payment.proof', 'admin.returns.proof', 'customer.returns.proof'], true)
                && in_array($contentType, ['image/jpeg', 'image/png', 'image/gif', 'image/webp'], true);
            abort_unless($response->successful() && ($isDownload || $isProof), 502);

            return response($response->body(), $response->status(), [
                'Content-Type' => $contentType,
                'Content-Disposition' => $response->header('Content-Disposition'),
                'Cache-Control' => 'no-store, private',
                'X-Content-Type-Options' => 'nosniff',
            ]);
        }

        $payload = $response->json();
        if ($response->successful() && $name === 'auth.doLogin') {
            $session->regenerate();
            $session->put('motifnesia_token', $payload['token']);

            return redirect(MotifnesiaApi::localPath($payload['viewer']['home']) ?? '/homePage')
                ->with('success', $payload['message'] ?? 'Berhasil login!');
        }

        if ($response->successful() && isset($payload['page'])) {
            if (isset($payload['viewer'])) {
                Auth::guard()->setUser(new Viewer($payload['viewer']));
            }

            return response()->view($payload['page'], PageData::decode($payload['data']))
                ->header('Cache-Control', 'no-store');
        }

        if ($request->expectsJson()) {
            return response()->json($payload, $response->status())->header('Cache-Control', 'no-store');
        }

        if ($response->unauthorized()) {
            return redirect()->route('auth.login')->with('error', $payload['message']);
        }

        $target = MotifnesiaApi::localPath($payload['redirect'] ?? null);
        if ($target || $response->unprocessableEntity() || ($name === 'auth.doLogin' && $response->forbidden())) {
            $redirect = redirect($target ?? $api->previousPath($request))->with($payload['flash'] ?? []);
            if (! $response->successful()) {
                $redirect->withErrors(($payload['errors'] ?? []) ?: ['form' => $payload['message'] ?? 'Periksa kembali formulir.'])
                    ->withInput($request->except([
                        '_token', '_method', 'password', 'password_confirmation', 'secret_answer',
                        'new_password', 'new_password_confirmation', 'payment_number',
                    ]));
                if (isset($payload['message'])) {
                    $redirect->with('error', $payload['message']);
                }
            }

            return $redirect;
        }

        if ($response->successful()) {
            return response()->json($payload, $response->status());
        }

        abort($response->serverError() ? 502 : $response->status());
    }
}
