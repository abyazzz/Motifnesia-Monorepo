<?php

namespace App\Services;

use App\Models\User;
use Illuminate\Support\Facades\Hash;

class WebCredentials
{
    public function find(string $username, string $password): ?User
    {
        $user = User::where('email', $username)->orWhere('name', $username)->first();

        return $user && Hash::check($password, $user->password) ? $user : null;
    }
}
