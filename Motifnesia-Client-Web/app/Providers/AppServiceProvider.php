<?php

namespace App\Providers;

use App\Support\Viewer;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Gate;
use Illuminate\Support\ServiceProvider;

class AppServiceProvider extends ServiceProvider
{
    public function boot(): void
    {
        Auth::viaRequest('motifnesia-viewer', fn () => null);

        foreach (['is-owner', 'is-finance', 'is-kasir', 'is-gudang', 'is-supplier'] as $ability) {
            Gate::define($ability, fn (Viewer $user) => in_array($ability, $user->abilities, true));
        }
    }
}
