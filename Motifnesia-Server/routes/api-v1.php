<?php

use App\Http\Controllers\Api\WebAuthController;
use App\Http\Middleware\WebApi;
use Illuminate\Support\Facades\Route;

Route::prefix('v1')->middleware(WebApi::class)->name('v1.')->group(function () {
    Route::get('viewer', [WebAuthController::class, 'viewer'])->name('viewer');

    foreach (require __DIR__.'/motifnesia.php' as [$name, $methods, $uri, $action]) {
        $route = Route::match(explode('|', $methods), $uri, $action)->name($name);

        if (in_array($name, ['auth.doLogin', 'auth.doRegister', 'auth.doForgot'], true)) {
            $route->middleware('throttle:motifnesia-auth');
        }
    }
});
