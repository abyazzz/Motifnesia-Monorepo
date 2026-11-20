<?php

namespace App\Support;

use Illuminate\Http\Client\Response;
use Illuminate\Http\Request;
use Illuminate\Http\UploadedFile;
use Illuminate\Support\Facades\Http;

class MotifnesiaApi
{
    public function send(Request $request, string $path, ?string $token = null): Response
    {
        $base = rtrim(config('motifnesia.api_url'), '/');
        $origin = parse_url($base, PHP_URL_SCHEME).'://'.parse_url($base, PHP_URL_HOST);
        $port = parse_url($base, PHP_URL_PORT);
        $origin .= $port ? ':'.$port : '';

        $client = Http::acceptJson()->connectTimeout(3)->timeout(30)->withoutRedirecting()
            ->withHeaders(['Referer' => $origin.$this->previousPath($request)]);
        if ($token) {
            $client->withToken($token);
        }

        $options = ['query' => $request->query()];
        if ($request->allFiles()) {
            $options['multipart'] = $this->multipart($request->except('_token', '_method'));
        } elseif (! $request->isMethodSafe()) {
            $options['json'] = array_diff_key(
                ($request->isJson() ? $request->json()->all() : $request->request->all()),
                ['_token' => true, '_method' => true],
            );
        }

        $method = $request->method();
        // PHP parses multipart uploads as POST. Use a fixed method override for uploads using another verb.
        if (isset($options['multipart']) && $method !== 'POST') {
            $options['multipart'][] = ['name' => '_method', 'contents' => $method];
            $method = 'POST';
        }

        return $client->send($method, $base.'/'.ltrim($path, '/'), $options);
    }

    public function previousPath(Request $request): string
    {
        $previous = url()->previous();
        if (! str_starts_with($previous, $request->getSchemeAndHttpHost().'/')) {
            return '/';
        }

        return self::localPath(substr($previous, strlen($request->getSchemeAndHttpHost()))) ?? '/';
    }

    public static function localPath(?string $path): ?string
    {
        if (! $path || ! str_starts_with($path, '/') || str_starts_with($path, '//')
            || preg_match('/[\\x00-\\x20\\x7f\\\\\\\\]/', $path)) {
            return null;
        }

        return $path;
    }

    private function multipart(array $fields, string $prefix = ''): array
    {
        $parts = [];
        foreach ($fields as $key => $value) {
            $name = $prefix === '' ? (string) $key : $prefix.'['.$key.']';
            if (is_array($value)) {
                array_push($parts, ...$this->multipart($value, $name));
            } elseif ($value instanceof UploadedFile && $value->isValid()) {
                $parts[] = [
                    'name' => $name,
                    'contents' => fopen($value->getRealPath(), 'rb'),
                    'filename' => $value->getClientOriginalName(),
                ];
            } elseif (is_scalar($value) || $value === null) {
                $parts[] = ['name' => $name, 'contents' => (string) $value];
            }
        }

        return $parts;
    }
}
