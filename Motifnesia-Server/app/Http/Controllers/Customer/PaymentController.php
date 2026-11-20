<?php

namespace App\Http\Controllers\Customer;

use App\Http\Controllers\Controller;
use App\Models\Order;
use App\Services\OrderService;
use App\Services\ProofMedia;
use App\Support\WebApi\FrontendUrl;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\Validator;

class PaymentController extends Controller
{
    /**
     * Tampilkan halaman payment/transaksi
     * Menampilkan ringkasan dari session checkout_data
     */ 
    public function index()
    {
        if (!Auth::check()) {
            return redirect(FrontendUrl::path('auth.login'))->with('error', 'Silakan login terlebih dahulu.');
        }

        // Ambil data checkout dari session
        $checkoutData = session('checkout_data');
        
        if (!$checkoutData) {
            return redirect(FrontendUrl::path('customer.cart.index'))->with('error', 'Data checkout tidak ditemukan. Silakan checkout ulang.');
        }

        // Deadline dibuat saat checkout, supaya tidak berubah tiap halaman payment di-refresh.
        $paymentDeadline = ! empty($checkoutData['payment_deadline_at'])
            ? \Carbon\Carbon::parse($checkoutData['payment_deadline_at'])
            : now()->addHours(config('order.payment_deadline_hours', 24));

        return $this->page('customer.pages.payment', compact('checkoutData', 'paymentDeadline'));
    }

    /**
     * Proses pembayaran dan simpan transaksi ke database
     */
    public function store(Request $request, OrderService $orderService, ProofMedia $media)
    {
        if (!Auth::check()) {
            return redirect(FrontendUrl::path('auth.login'))->with('error', 'Silakan login terlebih dahulu.');
        }

        // Validasi nomor pembayaran dan bukti transfer
        $validator = Validator::make($request->all(), [
            'payment_number' => 'required|string|min:10',
            'payment_proof' => 'required|image|mimes:jpeg,png,jpg,gif|max:5120'
        ]);

        if ($validator->fails()) {
            return redirect()->back()
                ->withErrors($validator)
                ->withInput()
                ->with('error', 'Validasi gagal: ' . $validator->errors()->first());
        }

        // Ambil data checkout dari session
        $checkoutData = session('checkout_data');
        
        if (!$checkoutData) {
            return redirect(FrontendUrl::path('customer.cart.index'))->with('error', 'Data checkout tidak ditemukan.');
        }

        $gambarPath = null;
        try {
            $gambarPath = $media->store($request->file('payment_proof'), 'payment');
            $order = $orderService->createOrder($checkoutData, $request->payment_number, $gambarPath);

            // Hapus session checkout
            session()->forget(['checkout_items', 'checkout_data']);
 
            // Redirect ke success page dengan order id
            return redirect(FrontendUrl::path('customer.transaction.success', $order->id))
                ->with('success', 'Transaksi berhasil! Menunggu konfirmasi pembayaran.');

        } catch (\Exception $exception) {
            if ($gambarPath) {
                Storage::disk('local')->delete($gambarPath);
            }
            report($exception);

            return redirect()->back()
                ->with('error', $exception instanceof \DomainException
                    ? $exception->getMessage()
                    : 'Gagal memproses pembayaran. Silakan periksa checkout dan coba kembali.')
                ->withInput();
        }
    }

    /**
     * Halaman sukses setelah transaksi
     */
    public function success($orderId)
    {
        if (!Auth::check()) {
            return redirect(FrontendUrl::path('auth.login'));
        }

        // Ambil detail order dengan items
        $order = Order::with(['orderItems', 'metodePengiriman', 'metodePembayaran', 'deliveryStatus'])
            ->where('id', $orderId)
            ->where('user_id', Auth::id())
            ->first();

        if (!$order) {
            return redirect(FrontendUrl::path('customer.home'))->with('error', 'Transaksi tidak ditemukan.');
        }

        return $this->page('customer.pages.transactionSuccess', compact('order'));
    }
}
