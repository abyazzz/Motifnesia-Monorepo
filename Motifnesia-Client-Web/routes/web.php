<?php

use App\Http\Controllers\MotifnesiaController;
use Illuminate\Support\Facades\Route;

Route::get('/', MotifnesiaController::class)->name('home');

foreach (require __DIR__.'/motifnesia.php' as [$name, $methods, $uri]) {
    Route::match(explode('|', $methods), $uri, MotifnesiaController::class)->name($name);
}
