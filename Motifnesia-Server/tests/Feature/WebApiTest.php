<?php

namespace Tests\Feature;

use App\Models\DeliveryStatus;
use App\Models\Notification;
use App\Models\Order;
use App\Models\Produk;
use App\Models\ProductSizeStock;
use App\Models\ShoppingCard;
use App\Models\Supplier;
use App\Models\User;
use App\Models\UserAddress;
use Database\Seeders\DeliveryStatusSeeder;
use Database\Seeders\MetodePembayaranSeeder;
use Database\Seeders\MetodePengirimanSeeder;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Http\UploadedFile;
use Illuminate\Support\Facades\Storage;
use Tests\TestCase;

class WebApiTest extends TestCase
{
    use RefreshDatabase;

    protected function setUp(): void
    {
        parent::setUp();

        $this->assertSame('sqlite', config('database.default'));
        $this->assertSame(':memory:', config('database.connections.sqlite.database'));
        config(['motifnesia.workflow_store' => 'array']);
    }

    public function test_web_sessions_use_server_roles_and_revoke_the_token_at_logout(): void
    {
        $this->getJson('/api/v1/cart')->assertUnauthorized();

        $user = User::factory()->create([
            'role' => 'customer',
            'account_status' => 'active',
            'secret_question' => 'hobi',
            'secret_answer' => 'synthetic-secret',
        ]);

        $login = $this->postJson('/api/v1/login', ['username' => $user->name, 'password' => 'password'])
            ->assertOk()->assertJsonPath('viewer.home', '/homePage')
            ->assertJsonMissingPath('viewer.secret_answer');

        $this->withToken($login->json('token'))->getJson('/api/v1/cart')
            ->assertOk()->assertJsonPath('page', 'customer.pages.shoppingCard');
        $this->getJson('/api/v1/admin/warehouse')->assertForbidden();
        $this->getJson('/api/profile')->assertForbidden();

        $this->postJson('/api/v1/logout')->assertOk();
        $this->getJson('/api/v1/cart')->assertUnauthorized();
    }

    public function test_checkout_uses_the_authenticated_cart_and_stores_only_one_order(): void
    {
        Storage::fake('local');
        $this->seed([MetodePengirimanSeeder::class, MetodePembayaranSeeder::class, DeliveryStatusSeeder::class]);
        $user = User::factory()->create(['role' => 'customer', 'account_status' => 'active']);
        $other = User::factory()->create(['role' => 'customer', 'account_status' => 'active']);
        UserAddress::create([
            'user_id' => $user->id, 'recipient_name' => 'Fixture', 'phone_number' => '081234567891',
            'address_line' => 'Jalan Batik Nomor 10', 'province' => 'DIY',
            'city' => 'Yogyakarta', 'postal_code' => '55111', 'is_primary' => true,
        ]);
        $product = Produk::create([
            'nama_produk' => 'Batik Fixture', 'stok' => 4, 'kategori' => 'Pria', 'harga' => 150000,
            'is_active' => true,
        ]);
        $variant = ProductSizeStock::create(['produk_id' => $product->id, 'ukuran' => 'M', 'stok' => 4]);
        $cart = ShoppingCard::create([
            'user_id' => $user->id, 'product_id' => $product->id, 'ukuran' => 'M', 'qty' => 1,
        ]);

        $token = $user->createToken('web-test', ['motifnesia:v1'])->plainTextToken;
        $secondToken = $user->createToken('second-web-test', ['motifnesia:v1'])->plainTextToken;
        foreach ([$token, $secondToken] as $draftToken) {
            $this->withToken($draftToken)->postJson('/api/v1/cart/checkout', ['selected_items' => [$cart->id]])
                ->assertOk()->assertJsonPath('redirect', '/checkout');
            $this->postJson('/api/v1/checkout/store', [
                'alamat' => 'Jalan Batik Nomor 10',
                'metode_pengiriman_id' => 1,
                'metode_pembayaran_id' => 1,
            ])->assertOk()->assertJsonPath('redirect_url', '/payment');
        }
        $this->withToken($other->createToken('web-test')->plainTextToken)
            ->getJson('/api/v1/payment')->assertUnprocessable()->assertJsonPath('redirect', '/cart');

        $this->withToken($token)->post('/api/v1/payment/store', [
            'payment_number' => '081234567891',
            'payment_proof' => UploadedFile::fake()->image('proof.png'),
        ])->assertOk();
        $this->withToken($secondToken)->post('/api/v1/payment/store', [
            'payment_number' => '081234567891',
            'payment_proof' => UploadedFile::fake()->image('proof.png'),
        ])->assertUnprocessable();

        $this->assertDatabaseCount('orders', 1);
        $this->assertDatabaseHas('orders', ['user_id' => $user->id, 'payment_status' => 'waiting_verification']);
        $this->assertDatabaseCount('order_items', 1);
        $this->assertDatabaseCount('shopping_card', 0);
        $this->assertSame(3, $variant->refresh()->stok);

        $finance = User::factory()->create(['role' => 'admin', 'admin_role' => 'finance']);
        $this->withToken($finance->createToken('web-test')->plainTextToken)
            ->get('/api/v1/admin/order-status/1/payment-proof')->assertOk()
            ->assertHeader('Content-Type', 'image/png');
        $this->withToken($token)->get('/api/v1/admin/order-status/1/payment-proof')->assertForbidden();
    }

    public function test_kasir_can_save_each_shipping_status_after_finance_verifies_payment(): void
    {
        config(['motifnesia.client_url' => 'https://shop.motifnesia.test']);
        $this->seed([MetodePengirimanSeeder::class, MetodePembayaranSeeder::class, DeliveryStatusSeeder::class]);
        $buyer = User::factory()->create(['role' => 'customer', 'account_status' => 'active']);
        $finance = User::factory()->create(['role' => 'admin', 'admin_role' => 'finance']);
        $cashier = User::factory()->create(['role' => 'admin', 'admin_role' => 'kasir']);
        $order = Order::create([
            'user_id' => $buyer->id,
            'order_number' => 'FIXTURE-SHIPPING',
            'alamat' => 'Jalan Batik Nomor 10',
            'metode_pengiriman_id' => 1,
            'metode_pembayaran_id' => 1,
            'delivery_status_id' => 1,
            'total_ongkir' => 10000,
            'total_bayar' => 160000,
            'payment_status' => 'waiting_verification',
        ]);
        $endpoint = '/api/v1/admin/order-status/'.$order->id;
        $cashierToken = $cashier->createToken('web-test')->plainTextToken;

        $this->withToken($cashierToken)->getJson('/api/v1/admin/order-status')
            ->assertOk()->assertJsonPath('data.pendingDeliveryStatusId', 1);
        $this->postJson($endpoint.'/update', ['delivery_status_id' => 2])
            ->assertUnprocessable()
            ->assertJsonPath('message', 'Verifikasi pembayaran dulu sebelum status pengiriman dilanjutkan.');
        $this->assertDatabaseHas('orders', ['id' => $order->id, 'delivery_status_id' => 1]);
        $this->postJson($endpoint.'/payment', ['payment_status' => 'verified'])->assertForbidden();

        $this->withToken($finance->createToken('web-test')->plainTextToken)
            ->postJson($endpoint.'/payment', ['payment_status' => 'verified'])->assertOk();
        $this->assertDatabaseHas('orders', ['id' => $order->id, 'payment_status' => 'verified']);
        $this->postJson($endpoint.'/update', ['delivery_status_id' => 2])->assertForbidden();

        $notification = Notification::where('user_id', $buyer->id)->latest('id')->firstOrFail();
        $this->assertSame('https://shop.motifnesia.test/profile', $notification->link);
        $this->withToken($buyer->createToken('web-test')->plainTextToken)
            ->postJson('/api/v1/notifications/'.$notification->id.'/read')
            ->assertOk()->assertJsonPath('redirect', '/profile');

        $this->withToken($cashierToken);
        foreach (DeliveryStatus::orderBy('id')->pluck('id') as $statusId) {
            $this->postJson($endpoint.'/update', ['delivery_status_id' => $statusId])
                ->assertOk()->assertJsonPath('success', true);
            $this->assertDatabaseHas('orders', ['id' => $order->id, 'delivery_status_id' => $statusId]);
            $this->assertDatabaseHas('order_status_history', ['order_id' => $order->id, 'delivery_status_id' => $statusId]);
        }
    }

    public function test_supplier_can_only_access_its_own_procurement(): void
    {
        $gudang = User::factory()->create(['role' => 'admin', 'admin_role' => 'gudang']);
        $supplier = User::factory()->create(['role' => 'supplier', 'account_status' => 'active']);
        $other = User::factory()->create(['role' => 'supplier', 'account_status' => 'active']);
        $supplierId = Supplier::create(['user_id' => $supplier->id, 'name' => 'Fixture Supplier', 'status' => 'active'])->id;
        Supplier::create(['user_id' => $other->id, 'name' => 'Other Fixture Supplier', 'status' => 'active']);
        $product = Produk::create([
            'nama_produk' => 'Batik Fixture', 'stok' => 0, 'kategori' => 'Pria',
            'harga' => 150000, 'is_active' => true,
        ]);

        $this->withToken($gudang->createToken('web-test')->plainTextToken)
            ->postJson('/api/v1/admin/stock-procurements', [
                'supplier_id' => $supplierId, 'items' => [$product->id => ['qty_m' => 5]],
            ])->assertOk()->assertJsonPath('redirect', '/admin/stock-procurements/1');
        $this->withToken($other->createToken('web-test')->plainTextToken)
            ->getJson('/api/v1/supplier/procurements/1')->assertForbidden();
        $this->withToken($supplier->createToken('web-test')->plainTextToken)
            ->getJson('/api/v1/supplier/procurements/1')->assertOk();
        $this->postJson('/api/v1/supplier/procurements/1/status', ['status' => 'approved'])->assertOk();
        $this->assertDatabaseHas('stock_procurements', ['id' => 1, 'status' => 'approved']);
    }
}
