<?php

use App\Models\Produk;
use App\Models\ProductSizeStock;
use App\Models\Supplier;
use App\Models\User;
use App\Models\UserAddress;
use App\Models\WarehouseStock;
use Illuminate\Contracts\Console\Kernel;

require 'vendor/autoload.php';
$app = require 'bootstrap/app.php';
$app->make(Kernel::class)->bootstrap();
$connection = $app->make('db')->connection();

if ($connection->getDriverName() !== 'sqlite'
    || $connection->getDatabaseName() !== getenv('DB_DATABASE')
    || basename($connection->getDatabaseName()) !== 'browser-test.sqlite'
    || ! str_starts_with(basename(dirname($connection->getDatabaseName())), 'motifnesia-browser-')) {
    throw new RuntimeException('Gunakan database SQLite sementara untuk pengujian browser.');
}

if (in_array('--check', $argv, true)) {
    exit;
}

foreach (['customer', 'finance', 'kasir', 'gudang', 'owner', 'supplier', 'supplier-lain'] as $name) {
    $role = match (true) {
        $name === 'customer' => 'customer',
        str_starts_with($name, 'supplier') => 'supplier',
        default => 'admin',
    };
    $user = User::create([
        'name' => $name,
        'full_name' => ucfirst($name).' Browser Test',
        'email' => $name.'@browser-test.example',
        'password' => 'motifnesia-browser-test',
        'role' => $role,
        'admin_role' => $role === 'admin' ? $name : null,
        'account_status' => 'active',
    ]);

    if ($role === 'supplier') {
        Supplier::create(['user_id' => $user->id, 'name' => ucfirst($name).' Browser Test', 'status' => 'active']);
    }
    if ($role === 'customer') {
        UserAddress::create([
            'user_id' => $user->id, 'recipient_name' => 'Browser Test', 'phone_number' => '081234567891',
            'label' => 'Alamat uji', 'address_line' => 'Jalan Batik Nomor 10', 'province' => 'DIY',
            'city' => 'Yogyakarta', 'postal_code' => '55111', 'is_primary' => true,
        ]);
    }
}

$product = Produk::create([
    'nama_produk' => 'Batik Browser Test', 'harga' => 150000, 'stok' => 10, 'kategori' => 'Pria',
    'ukuran' => 'M', 'is_active' => true,
]);

ProductSizeStock::create(['produk_id' => $product->id, 'ukuran' => 'M', 'stok' => 10]);
WarehouseStock::create(['produk_id' => $product->id, 'ukuran' => 'M', 'stok' => 10]);

$app->make(Kernel::class)->call('db:seed', [
    '--class' => 'MetodePengirimanSeeder', '--force' => true,
]);
$app->make(Kernel::class)->call('db:seed', [
    '--class' => 'MetodePembayaranSeeder', '--force' => true,
]);
$app->make(Kernel::class)->call('db:seed', [
    '--class' => 'DeliveryStatusSeeder', '--force' => true,
]);
