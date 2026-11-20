<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use App\Models\User;
use App\Support\WebApi\FrontendUrl;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;

class UserController extends Controller
{
    // Proses register (POST)
    public function doRegister(Request $request)
    {
        // Validasi form sesuai fields di view
        $request->validate([
            'username' => 'required|min:3|unique:users,name',
            'full_name' => 'nullable|string|max:255',
            'email' => 'required|email|unique:users,email',
            'password' => 'required|min:6|confirmed',
            'secret_question' => 'required',
            'secret_answer' => 'required'
        ]);

        // Buat user baru di database, role default 'customer'.
        $user = User::create([
            'name' => $request->username,
            'full_name' => $request->full_name ?? null,
            'email' => $request->email,
            'password' => Hash::make($request->password),
            'role' => 'customer',
            'secret_question' => $request->secret_question,
            'secret_answer' => $request->secret_answer,
        ]);

        if ($user) {
            return redirect(FrontendUrl::path('auth.login'))->with('success', 'Registrasi berhasil! Silakan login.');
        }

        return back()->with('error', 'Gagal mendaftar, silakan coba lagi.')->withInput();
    }

    // Proses reset password
    public function doForgot(Request $request)
    {
        $request->validate([
            'username' => 'required',
            'secret_question' => 'required',
            'secret_answer' => 'required',
            'new_password' => 'required|min:6',
            'new_password_confirmation' => 'required|same:new_password'
        ]);

        // Cari user berdasarkan username atau email
        $user = User::where('email', $request->username)
                    ->orWhere('name', $request->username)
                    ->first();

        if (!$user) {
            return back()->with('error', 'Username tidak ditemukan!')->withInput();
        }

        // Verifikasi pertanyaan dan jawaban rahasia
        if ($user->secret_question !== $request->secret_question) {
            return back()->with('error', 'Pertanyaan rahasia tidak cocok!')->withInput();
        }

        if (strtolower(trim($user->secret_answer)) !== strtolower(trim($request->secret_answer))) {
            return back()->with('error', 'Jawaban rahasia tidak cocok!')->withInput();
        }

        // Update password
        $user->password = Hash::make($request->new_password);
        $user->save();
        $user->tokens()->delete();

        return redirect(FrontendUrl::path('auth.login'))->with('success', 'Password berhasil direset! Silakan login dengan password baru.');
    }
}
