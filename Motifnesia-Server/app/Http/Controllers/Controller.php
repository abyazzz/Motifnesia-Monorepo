<?php

namespace App\Http\Controllers;

use App\Support\WebApi\Page;
use Illuminate\Http\JsonResponse;

abstract class Controller
{
    protected function page(string $view, array $data = []): JsonResponse
    {
        return Page::response($view, $data);
    }
}
