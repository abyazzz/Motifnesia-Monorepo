<?php

namespace App\Support\WebApi;

use Illuminate\Support\Str;

class FrontendUrl
{
    public static function path(string $routeName, mixed $parameters = []): string
    {
        if ($routeName === 'auth.login') {
            return '/login';
        }

        return Str::after(route('v1.'.$routeName, $parameters, absolute: false), '/api/v1');
    }

    public static function to(string $routeName, mixed $parameters = []): string
    {
        return rtrim(config('motifnesia.client_url'), '/').self::path($routeName, $parameters);
    }
}
