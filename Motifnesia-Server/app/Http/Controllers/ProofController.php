<?php

namespace App\Http\Controllers;

use App\Models\Order;
use App\Models\ProductReturn;
use App\Services\ProofMedia;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Gate;
use Symfony\Component\HttpFoundation\StreamedResponse;

class ProofController extends Controller
{
    public function payment(Order $order, ProofMedia $media): StreamedResponse
    {
        Gate::authorize('is-finance');

        return $media->response($order->payment_proof, 'payment');
    }

    public function customerReturn(ProductReturn $return, string $kind, ProofMedia $media): StreamedResponse
    {
        abort_unless((int) $return->user_id === (int) Auth::id(), 403);

        return $this->returnProof($return, $kind, $media);
    }

    public function adminReturn(ProductReturn $return, string $kind, ProofMedia $media): StreamedResponse
    {
        Gate::authorize('is-kasir');

        return $this->returnProof($return, $kind, $media);
    }

    private function returnProof(ProductReturn $return, string $kind, ProofMedia $media): StreamedResponse
    {
        return match ($kind) {
            'return' => $media->response($return->photo_proof, $kind),
            'courier' => $media->response($return->courier_photo, $kind),
            default => abort(404),
        };
    }
}
