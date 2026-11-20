<?php

namespace App\Services;

use Illuminate\Http\UploadedFile;
use Illuminate\Support\Facades\Storage;
use RuntimeException;
use Symfony\Component\HttpFoundation\StreamedResponse;

class ProofMedia
{
    public function store(UploadedFile $file, string $kind): string
    {
        $path = $file->store('order-proofs/'.$kind, 'local');
        if (! $path) {
            throw new RuntimeException('Bukti unggahan tidak dapat disimpan.');
        }

        return $path;
    }

    public function response(?string $path, string $kind): StreamedResponse
    {
        abort_unless($path, 404);
        $prefix = 'order-proofs/'.$kind.'/';
        $legacyPrefix = match ($kind) {
            'payment' => 'assets/paymentProof/',
            'return' => 'returns/',
            'courier' => 'returns/courier/',
        };

        if (str_starts_with($path, $legacyPrefix)) {
            $path = 'order-proofs/legacy/'.$path;
            $prefix = 'order-proofs/legacy/'.$legacyPrefix;
        }

        abort_unless(str_starts_with($path, $prefix), 404);
        $name = substr($path, strlen($prefix));
        abort_if($name === '' || $name !== basename($name) || str_contains($name, '\\') || $name === '..', 404);
        $disk = Storage::disk('local');
        abort_unless($disk->exists($path), 404);
        $type = $disk->mimeType($path);
        abort_unless(in_array($type, ['image/jpeg', 'image/png', 'image/gif', 'image/webp'], true), 404);

        return $disk->response($path, $name, [
            'Content-Type' => $type,
            'Cache-Control' => 'no-store, private',
            'X-Content-Type-Options' => 'nosniff',
        ], 'inline');
    }
}
