<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Services\WebCredentials;
use App\Support\WebApi\Viewer;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Cache;

class WebAuthController extends Controller
{
    public function login(Request $request, WebCredentials $credentials): JsonResponse
    {
        $data = $request->validate([
            'username' => 'required|string|max:255',
            'password' => 'required|string|max:1024',
        ]);

        $user = $credentials->find($data['username'], $data['password']);
        if (! $user) {
            return response()->json(['message' => 'Username atau password salah!'], 422);
        }
        if ($user->role !== 'admin' && $user->account_status !== 'active') {
            return response()->json(['message' => 'Akun Anda sedang dinonaktifkan. Silakan hubungi admin Motifnesia.'], 403);
        }

        $token = $user->createToken('motifnesia-web', ['motifnesia:v1'], now()->addHours(12));

        $message = match ($user->role) {
            'admin' => match ($user->admin_role) {
                'finance' => 'Berhasil login sebagai Admin Finance!',
                'gudang' => 'Berhasil login sebagai Admin Gudang!',
                default => 'Berhasil login sebagai Admin!',
            },
            'supplier' => 'Berhasil login sebagai Supplier!',
            default => 'Berhasil login!',
        };

        return response()->json([
            'token' => $token->plainTextToken,
            'message' => $message,
            'viewer' => Viewer::data($user),
        ])->header('Cache-Control', 'no-store');
    }

    public function viewer(): JsonResponse
    {
        return response()->json(['viewer' => Viewer::data(Auth::user())])
            ->header('Cache-Control', 'no-store');
    }

    public function logout(Request $request): JsonResponse
    {
        $token = $request->user()?->currentAccessToken();
        if ($token) {
            Cache::store(config('motifnesia.workflow_store'))->forget('motifnesia-workflow:'.$token->getKey());
            $token->delete();
        }

        return response()->json(['success' => true]);
    }
}
