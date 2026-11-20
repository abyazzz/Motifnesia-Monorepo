# Skema database AS-IMPLEMENTED

42 tabel berasal dari operasi `Schema::create` dalam 52 migration. Kolom perubahan diambil dari `up()`. Tipe di bawah memakai definisi Laravel Blueprint agar semantik, panjang dan presisi bisa ditelusuri. Skema database aktif dan hasil migration historis belum diinspeksi.

Kunci FK dalam ERD berarti constraint fisik yang ditemukan. Relasi model dapat lebih luas, termasuk morfisme. Indeks sesi `user_id`, token polimorfik, dan foreign key relasi `reviews.product_id` perlu dibaca dari asal masing-masing. [ERD](../ERD/README.md)

`notifications.type` memakai `VARCHAR(50) NOT NULL DEFAULT system` melalui SQL pada MySQL/MariaDB. Driver lain memakai perubahan string dengan default yang sama pada Blueprint. [Cabang SQL dan Blueprint](../../../../Motifnesia-Server/database/migrations/2026_05_21_000001_normalize_notifications_type_and_data.php#L19)

## Akun dan katalog

### users

Model. [User](../../../../Motifnesia-Server/app/Models/User.php#L15)

| Kolom | Blueprint | Null | Kunci | Definisi dan bukti |
| --- | --- | --- | --- | --- |
| `id` | `id` | tidak | PK | `$table->id()` · [0001_01_01_000000_create_users_table.php](../../../../Motifnesia-Server/database/migrations/0001_01_01_000000_create_users_table.php#L15) |
| `name` | `string` | tidak | — | `$table->string('name')` · [0001_01_01_000000_create_users_table.php](../../../../Motifnesia-Server/database/migrations/0001_01_01_000000_create_users_table.php#L16) |
| `email` | `string` | tidak | UK | `$table->string('email')->unique()` · [0001_01_01_000000_create_users_table.php](../../../../Motifnesia-Server/database/migrations/0001_01_01_000000_create_users_table.php#L17) |
| `email_verified_at` | `timestamp` | ya | — | `$table->timestamp('email_verified_at')->nullable()` · [0001_01_01_000000_create_users_table.php](../../../../Motifnesia-Server/database/migrations/0001_01_01_000000_create_users_table.php#L18) |
| `password` | `string` | tidak | — | `$table->string('password')` · [0001_01_01_000000_create_users_table.php](../../../../Motifnesia-Server/database/migrations/0001_01_01_000000_create_users_table.php#L19) |
| `remember_token` | `string(100)` | ya | — | `$table->rememberToken()` · [0001_01_01_000000_create_users_table.php](../../../../Motifnesia-Server/database/migrations/0001_01_01_000000_create_users_table.php#L20) |
| `created_at` | `timestamp` | ya | — | `$table->timestamps()` · [0001_01_01_000000_create_users_table.php](../../../../Motifnesia-Server/database/migrations/0001_01_01_000000_create_users_table.php#L21) |
| `updated_at` | `timestamp` | ya | — | `$table->timestamps()` · [0001_01_01_000000_create_users_table.php](../../../../Motifnesia-Server/database/migrations/0001_01_01_000000_create_users_table.php#L21) |
| `profile_pic` | `string` | ya | — | `$table->string('profile_pic')->nullable()->after('password')` · [2025_11_24_000010_add_profile_fields_to_users.php](../../../../Motifnesia-Server/database/migrations/2025_11_24_000010_add_profile_fields_to_users.php#L15) |
| `phone_number` | `string` | ya | — | `$table->string('phone_number')->nullable()->after('profile_pic')` · [2025_11_24_000010_add_profile_fields_to_users.php](../../../../Motifnesia-Server/database/migrations/2025_11_24_000010_add_profile_fields_to_users.php#L16) |
| `birth_date` | `date` | ya | — | `$table->date('birth_date')->nullable()->after('phone_number')` · [2025_11_24_000010_add_profile_fields_to_users.php](../../../../Motifnesia-Server/database/migrations/2025_11_24_000010_add_profile_fields_to_users.php#L17) |
| `gender` | `string(1)` | ya | — | `$table->string('gender', 1)->nullable()->after('birth_date')` · [2025_11_24_000010_add_profile_fields_to_users.php](../../../../Motifnesia-Server/database/migrations/2025_11_24_000010_add_profile_fields_to_users.php#L18) |
| `address_line` | `text` | ya | — | `$table->text('address_line')->nullable()->after('gender')` · [2025_11_24_000011_add_address_to_users.php](../../../../Motifnesia-Server/database/migrations/2025_11_24_000011_add_address_to_users.php#L15) |
| `city` | `string` | ya | — | `$table->string('city')->nullable()->after('address_line')` · [2025_11_24_000011_add_address_to_users.php](../../../../Motifnesia-Server/database/migrations/2025_11_24_000011_add_address_to_users.php#L16) |
| `province` | `string` | ya | — | `$table->string('province')->nullable()->after('city')` · [2025_11_24_000011_add_address_to_users.php](../../../../Motifnesia-Server/database/migrations/2025_11_24_000011_add_address_to_users.php#L17) |
| `postal_code` | `string` | ya | — | `$table->string('postal_code')->nullable()->after('province')` · [2025_11_24_000011_add_address_to_users.php](../../../../Motifnesia-Server/database/migrations/2025_11_24_000011_add_address_to_users.php#L18) |
| `full_name` | `string` | ya | — | `$table->string('full_name')->nullable()` · [2025_11_24_000013_add_full_name_to_users_table.php](../../../../Motifnesia-Server/database/migrations/2025_11_24_000013_add_full_name_to_users_table.php#L20) |
| `role` | `string` | tidak | — | `$table->string('role')->default('customer')->after('email')` · [2025_12_06_000014_add_role_to_users_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_06_000014_add_role_to_users_table.php#L11) |
| `secret_question` | `string` | ya | — | `$table->string('secret_question')->nullable()->after('password')` · [2025_12_27_024822_add_secret_fields_to_users_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_27_024822_add_secret_fields_to_users_table.php#L15) |
| `secret_answer` | `string` | ya | — | `$table->string('secret_answer')->nullable()->after('secret_question')` · [2025_12_27_024822_add_secret_fields_to_users_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_27_024822_add_secret_fields_to_users_table.php#L16) |
| `is_member` | `boolean` | tidak | — | `$table->boolean('is_member')->default(false)` · [2026_05_22_000001_create_membership_feature_tables.php](../../../../Motifnesia-Server/database/migrations/2026_05_22_000001_create_membership_feature_tables.php#L14) |
| `membership_status` | `string(20)` | ya | — | `$table->string('membership_status', 20)->nullable()` · [2026_05_22_000001_create_membership_feature_tables.php](../../../../Motifnesia-Server/database/migrations/2026_05_22_000001_create_membership_feature_tables.php#L18) |
| `membership_joined_at` | `timestamp` | ya | — | `$table->timestamp('membership_joined_at')->nullable()` · [2026_05_22_000001_create_membership_feature_tables.php](../../../../Motifnesia-Server/database/migrations/2026_05_22_000001_create_membership_feature_tables.php#L22) |
| `reward_points` | `integer` | tidak | — | `$table->integer('reward_points')->default(0)` · [2026_05_22_000001_create_membership_feature_tables.php](../../../../Motifnesia-Server/database/migrations/2026_05_22_000001_create_membership_feature_tables.php#L26) |
| `account_status` | `string(30)` | tidak | — | `$table->string('account_status', 30)->default('active')->after('role')` · [2026_06_08_000001_add_ecommerce_flow_fields.php](../../../../Motifnesia-Server/database/migrations/2026_06_08_000001_add_ecommerce_flow_fields.php#L47) |
| `account_status_reason` | `text` | ya | — | `$table->text('account_status_reason')->nullable()->after('account_status')` · [2026_06_08_000001_add_ecommerce_flow_fields.php](../../../../Motifnesia-Server/database/migrations/2026_06_08_000001_add_ecommerce_flow_fields.php#L51) |
| `account_status_changed_at` | `timestamp` | ya | — | `$table->timestamp('account_status_changed_at')->nullable()->after('account_status_reason')` · [2026_06_08_000001_add_ecommerce_flow_fields.php](../../../../Motifnesia-Server/database/migrations/2026_06_08_000001_add_ecommerce_flow_fields.php#L55) |
| `account_status_changed_by` | `foreignId` | ya | FK | `$table->foreignId('account_status_changed_by')->nullable()->after('account_status_changed_at')->constrained('users')->nullOnDelete()` · [2026_06_08_000001_add_ecommerce_flow_fields.php](../../../../Motifnesia-Server/database/migrations/2026_06_08_000001_add_ecommerce_flow_fields.php#L59) |
| `admin_role` | `string` | ya | — | `$table->string('admin_role')->nullable()->after('role')` · [2026_06_09_043741_add_admin_role_to_users_table.php](../../../../Motifnesia-Server/database/migrations/2026_06_09_043741_add_admin_role_to_users_table.php#L15) |
| `membership_tier` | `string` | tidak | — | `$table->string('membership_tier')->default('bronze')->after('reward_points')` · [2026_06_09_050047_add_membership_tier_fields_to_users_table.php](../../../../Motifnesia-Server/database/migrations/2026_06_09_050047_add_membership_tier_fields_to_users_table.php#L15) |
| `total_spending` | `decimal(12, 2)` | tidak | — | `$table->decimal('total_spending', 12, 2)->default(0.0)->after('membership_tier')` · [2026_06_09_050047_add_membership_tier_fields_to_users_table.php](../../../../Motifnesia-Server/database/migrations/2026_06_09_050047_add_membership_tier_fields_to_users_table.php#L16) |

Indeks/constraint tambahan. `unique('name')` [migration](../../../../Motifnesia-Server/database/migrations/2025_12_27_040134_add_unique_to_name_in_users_table.php#L15)

### password_reset_tokens

| Kolom | Blueprint | Null | Kunci | Definisi dan bukti |
| --- | --- | --- | --- | --- |
| `email` | `string` | tidak | PK | `$table->string('email')->primary()` · [0001_01_01_000000_create_users_table.php](../../../../Motifnesia-Server/database/migrations/0001_01_01_000000_create_users_table.php#L25) |
| `token` | `string` | tidak | — | `$table->string('token')` · [0001_01_01_000000_create_users_table.php](../../../../Motifnesia-Server/database/migrations/0001_01_01_000000_create_users_table.php#L26) |
| `created_at` | `timestamp` | ya | — | `$table->timestamp('created_at')->nullable()` · [0001_01_01_000000_create_users_table.php](../../../../Motifnesia-Server/database/migrations/0001_01_01_000000_create_users_table.php#L27) |

### personal_access_tokens

| Kolom | Blueprint | Null | Kunci | Definisi dan bukti |
| --- | --- | --- | --- | --- |
| `id` | `id` | tidak | PK | `$table->id()` · [2026_06_08_082433_create_personal_access_tokens_table.php](../../../../Motifnesia-Server/database/migrations/2026_06_08_082433_create_personal_access_tokens_table.php#L15) |
| `tokenable_type` | `string` | tidak | — | `$table->morphs('tokenable')` · [2026_06_08_082433_create_personal_access_tokens_table.php](../../../../Motifnesia-Server/database/migrations/2026_06_08_082433_create_personal_access_tokens_table.php#L16) |
| `tokenable_id` | `morph-key` | tidak | — | `$table->morphs('tokenable')` · [2026_06_08_082433_create_personal_access_tokens_table.php](../../../../Motifnesia-Server/database/migrations/2026_06_08_082433_create_personal_access_tokens_table.php#L16) |
| `name` | `text` | tidak | — | `$table->text('name')` · [2026_06_08_082433_create_personal_access_tokens_table.php](../../../../Motifnesia-Server/database/migrations/2026_06_08_082433_create_personal_access_tokens_table.php#L17) |
| `token` | `string(64)` | tidak | UK | `$table->string('token', 64)->unique()` · [2026_06_08_082433_create_personal_access_tokens_table.php](../../../../Motifnesia-Server/database/migrations/2026_06_08_082433_create_personal_access_tokens_table.php#L18) |
| `abilities` | `text` | ya | — | `$table->text('abilities')->nullable()` · [2026_06_08_082433_create_personal_access_tokens_table.php](../../../../Motifnesia-Server/database/migrations/2026_06_08_082433_create_personal_access_tokens_table.php#L19) |
| `last_used_at` | `timestamp` | ya | — | `$table->timestamp('last_used_at')->nullable()` · [2026_06_08_082433_create_personal_access_tokens_table.php](../../../../Motifnesia-Server/database/migrations/2026_06_08_082433_create_personal_access_tokens_table.php#L20) |
| `expires_at` | `timestamp` | ya | — | `$table->timestamp('expires_at')->nullable()->index()` · [2026_06_08_082433_create_personal_access_tokens_table.php](../../../../Motifnesia-Server/database/migrations/2026_06_08_082433_create_personal_access_tokens_table.php#L21) |
| `created_at` | `timestamp` | ya | — | `$table->timestamps()` · [2026_06_08_082433_create_personal_access_tokens_table.php](../../../../Motifnesia-Server/database/migrations/2026_06_08_082433_create_personal_access_tokens_table.php#L22) |
| `updated_at` | `timestamp` | ya | — | `$table->timestamps()` · [2026_06_08_082433_create_personal_access_tokens_table.php](../../../../Motifnesia-Server/database/migrations/2026_06_08_082433_create_personal_access_tokens_table.php#L22) |

Indeks/constraint tambahan. `index(tokenable_type, tokenable_id)` [migration](../../../../Motifnesia-Server/database/migrations/2026_06_08_082433_create_personal_access_tokens_table.php#L16)

### user_addresses

Model. [UserAddress](../../../../Motifnesia-Server/app/Models/UserAddress.php#L8)

| Kolom | Blueprint | Null | Kunci | Definisi dan bukti |
| --- | --- | --- | --- | --- |
| `id` | `id` | tidak | PK | `$table->id()` · [2026_01_04_175218_create_user_addresses_table.php](../../../../Motifnesia-Server/database/migrations/2026_01_04_175218_create_user_addresses_table.php#L15) |
| `user_id` | `foreignId` | tidak | FK | `$table->foreignId('user_id')->constrained('users')->onDelete('cascade')` · [2026_01_04_175218_create_user_addresses_table.php](../../../../Motifnesia-Server/database/migrations/2026_01_04_175218_create_user_addresses_table.php#L16) |
| `label` | `string` | ya | — | `$table->string('label')->nullable()` · [2026_01_04_175218_create_user_addresses_table.php](../../../../Motifnesia-Server/database/migrations/2026_01_04_175218_create_user_addresses_table.php#L17) |
| `recipient_name` | `string` | tidak | — | `$table->string('recipient_name')` · [2026_01_04_175218_create_user_addresses_table.php](../../../../Motifnesia-Server/database/migrations/2026_01_04_175218_create_user_addresses_table.php#L18) |
| `phone_number` | `string` | tidak | — | `$table->string('phone_number')` · [2026_01_04_175218_create_user_addresses_table.php](../../../../Motifnesia-Server/database/migrations/2026_01_04_175218_create_user_addresses_table.php#L19) |
| `address_line` | `text` | tidak | — | `$table->text('address_line')` · [2026_01_04_175218_create_user_addresses_table.php](../../../../Motifnesia-Server/database/migrations/2026_01_04_175218_create_user_addresses_table.php#L20) |
| `city` | `string` | tidak | — | `$table->string('city')` · [2026_01_04_175218_create_user_addresses_table.php](../../../../Motifnesia-Server/database/migrations/2026_01_04_175218_create_user_addresses_table.php#L21) |
| `province` | `string` | tidak | — | `$table->string('province')` · [2026_01_04_175218_create_user_addresses_table.php](../../../../Motifnesia-Server/database/migrations/2026_01_04_175218_create_user_addresses_table.php#L22) |
| `postal_code` | `string(10)` | tidak | — | `$table->string('postal_code', 10)` · [2026_01_04_175218_create_user_addresses_table.php](../../../../Motifnesia-Server/database/migrations/2026_01_04_175218_create_user_addresses_table.php#L23) |
| `notes` | `text` | ya | — | `$table->text('notes')->nullable()` · [2026_01_04_175218_create_user_addresses_table.php](../../../../Motifnesia-Server/database/migrations/2026_01_04_175218_create_user_addresses_table.php#L24) |
| `is_primary` | `boolean` | tidak | — | `$table->boolean('is_primary')->default(false)` · [2026_01_04_175218_create_user_addresses_table.php](../../../../Motifnesia-Server/database/migrations/2026_01_04_175218_create_user_addresses_table.php#L25) |
| `created_at` | `timestamp` | ya | — | `$table->timestamps()` · [2026_01_04_175218_create_user_addresses_table.php](../../../../Motifnesia-Server/database/migrations/2026_01_04_175218_create_user_addresses_table.php#L26) |
| `updated_at` | `timestamp` | ya | — | `$table->timestamps()` · [2026_01_04_175218_create_user_addresses_table.php](../../../../Motifnesia-Server/database/migrations/2026_01_04_175218_create_user_addresses_table.php#L26) |

### produk

Model. [Produk](../../../../Motifnesia-Server/app/Models/Produk.php#L9)

| Kolom | Blueprint | Null | Kunci | Definisi dan bukti |
| --- | --- | --- | --- | --- |
| `id` | `increments` | tidak | PK | `$table->increments('id')` · [2025_11_23_000001_create_produk_table.php](../../../../Motifnesia-Server/database/migrations/2025_11_23_000001_create_produk_table.php#L17) |
| `gambar` | `string(255)` | ya | — | `$table->string('gambar', 255)->nullable()` · [2025_11_23_000001_create_produk_table.php](../../../../Motifnesia-Server/database/migrations/2025_11_23_000001_create_produk_table.php#L18) |
| `nama_produk` | `string(100)` | ya | — | `$table->string('nama_produk', 100)->nullable()` · [2025_11_23_000001_create_produk_table.php](../../../../Motifnesia-Server/database/migrations/2025_11_23_000001_create_produk_table.php#L19) |
| `harga` | `decimal(10, 2)` | ya | — | `$table->decimal('harga', 10, 2)->nullable()` · [2025_11_23_000001_create_produk_table.php](../../../../Motifnesia-Server/database/migrations/2025_11_23_000001_create_produk_table.php#L20) |
| `material` | `string(100)` | ya | — | `$table->string('material', 100)->nullable()` · [2025_11_23_000001_create_produk_table.php](../../../../Motifnesia-Server/database/migrations/2025_11_23_000001_create_produk_table.php#L21) |
| `proses` | `string(100)` | ya | — | `$table->string('proses', 100)->nullable()` · [2025_11_23_000001_create_produk_table.php](../../../../Motifnesia-Server/database/migrations/2025_11_23_000001_create_produk_table.php#L22) |
| `sku` | `string(50)` | ya | — | `$table->string('sku', 50)->nullable()` · [2025_11_23_000001_create_produk_table.php](../../../../Motifnesia-Server/database/migrations/2025_11_23_000001_create_produk_table.php#L23) |
| `tags` | `string(255)` | ya | — | `$table->string('tags', 255)->nullable()` · [2025_11_23_000001_create_produk_table.php](../../../../Motifnesia-Server/database/migrations/2025_11_23_000001_create_produk_table.php#L24) |
| `stok` | `integer` | tidak | — | `$table->integer('stok')->default(0)` · [2025_11_23_000001_create_produk_table.php](../../../../Motifnesia-Server/database/migrations/2025_11_23_000001_create_produk_table.php#L25) |
| `kategori` | `string(50)` | ya | — | `$table->string('kategori', 50)->nullable()` · [2025_11_23_000001_create_produk_table.php](../../../../Motifnesia-Server/database/migrations/2025_11_23_000001_create_produk_table.php#L26) |
| `jenis_lengan` | `string(50)` | ya | — | `$table->string('jenis_lengan', 50)->nullable()` · [2025_11_23_000001_create_produk_table.php](../../../../Motifnesia-Server/database/migrations/2025_11_23_000001_create_produk_table.php#L27) |
| `terjual` | `integer` | tidak | — | `$table->integer('terjual')->default(0)->change()` · [2025_12_14_144811_change_terjual_to_integer_in_produk_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_14_144811_change_terjual_to_integer_in_produk_table.php#L28) |
| `deskripsi` | `text` | ya | — | `$table->text('deskripsi')->nullable()` · [2025_11_23_000001_create_produk_table.php](../../../../Motifnesia-Server/database/migrations/2025_11_23_000001_create_produk_table.php#L29) |
| `diskon_persen` | `integer` | tidak | — | `$table->integer('diskon_persen')->default(0)` · [2025_11_23_000001_create_produk_table.php](../../../../Motifnesia-Server/database/migrations/2025_11_23_000001_create_produk_table.php#L30) |
| `harga_diskon` | `decimal(10, 2)` | ya | — | `$table->decimal('harga_diskon', 10, 2)->nullable()` · [2025_11_23_000001_create_produk_table.php](../../../../Motifnesia-Server/database/migrations/2025_11_23_000001_create_produk_table.php#L31) |
| `created_at` | `timestamp` | ya | — | `$table->timestamps()` · [2025_11_23_000001_create_produk_table.php](../../../../Motifnesia-Server/database/migrations/2025_11_23_000001_create_produk_table.php#L32) |
| `updated_at` | `timestamp` | ya | — | `$table->timestamps()` · [2025_11_23_000001_create_produk_table.php](../../../../Motifnesia-Server/database/migrations/2025_11_23_000001_create_produk_table.php#L32) |
| `ukuran` | `string(50)` | ya | — | `$table->string('ukuran', 50)->nullable()->change()` · [2025_12_27_051934_increase_ukuran_length_in_produk_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_27_051934_increase_ukuran_length_in_produk_table.php#L15) |
| `rating` | `decimal(3, 2)` | tidak | — | `$table->decimal('rating', 3, 2)->default(0)->after('harga_diskon')->comment('Average rating 0-5.00')` · [2025_12_11_150001_add_rating_to_produk_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_11_150001_add_rating_to_produk_table.php#L15) |
| `gender` | `enum(['Pria', 'Wanita', 'Anak-anak'])` | ya | — | `$table->enum('gender', ['Pria', 'Wanita', 'Anak-anak'])->nullable()->after('kategori')` · [2025_12_13_061923_add_gender_to_produk_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_13_061923_add_gender_to_produk_table.php#L15) |
| `is_active` | `boolean` | tidak | — | `$table->boolean('is_active')->default(true)->after('terjual')` · [2026_06_08_000001_add_ecommerce_flow_fields.php](../../../../Motifnesia-Server/database/migrations/2026_06_08_000001_add_ecommerce_flow_fields.php#L69) |
| `archived_at` | `timestamp` | ya | — | `$table->timestamp('archived_at')->nullable()->after('is_active')` · [2026_06_08_000001_add_ecommerce_flow_fields.php](../../../../Motifnesia-Server/database/migrations/2026_06_08_000001_add_ecommerce_flow_fields.php#L73) |
| `filosofi_motif` | `text` | ya | — | `$table->text('filosofi_motif')->nullable()->after('deskripsi')` · [2026_06_09_050041_add_filosofi_motif_to_produk_table.php](../../../../Motifnesia-Server/database/migrations/2026_06_09_050041_add_filosofi_motif_to_produk_table.php#L15) |

### product_size_stocks

Model. [ProductSizeStock](../../../../Motifnesia-Server/app/Models/ProductSizeStock.php#L8)

| Kolom | Blueprint | Null | Kunci | Definisi dan bukti |
| --- | --- | --- | --- | --- |
| `id` | `id` | tidak | PK | `$table->id()` · [2026_06_08_000001_add_ecommerce_flow_fields.php](../../../../Motifnesia-Server/database/migrations/2026_06_08_000001_add_ecommerce_flow_fields.php#L79) |
| `produk_id` | `unsignedInteger` | tidak | FK | `$table->unsignedInteger('produk_id')` · [2026_06_08_000001_add_ecommerce_flow_fields.php](../../../../Motifnesia-Server/database/migrations/2026_06_08_000001_add_ecommerce_flow_fields.php#L80) |
| `ukuran` | `string(20)` | tidak | — | `$table->string('ukuran', 20)` · [2026_06_08_000001_add_ecommerce_flow_fields.php](../../../../Motifnesia-Server/database/migrations/2026_06_08_000001_add_ecommerce_flow_fields.php#L81) |
| `sku` | `string` | ya | — | `$table->string('sku')->nullable()` · [2026_06_08_000001_add_ecommerce_flow_fields.php](../../../../Motifnesia-Server/database/migrations/2026_06_08_000001_add_ecommerce_flow_fields.php#L82) |
| `stok` | `unsignedInteger` | tidak | — | `$table->unsignedInteger('stok')->default(0)` · [2026_06_08_000001_add_ecommerce_flow_fields.php](../../../../Motifnesia-Server/database/migrations/2026_06_08_000001_add_ecommerce_flow_fields.php#L83) |
| `low_stock_threshold` | `unsignedInteger` | tidak | — | `$table->unsignedInteger('low_stock_threshold')->default(5)` · [2026_06_08_000001_add_ecommerce_flow_fields.php](../../../../Motifnesia-Server/database/migrations/2026_06_08_000001_add_ecommerce_flow_fields.php#L84) |
| `created_at` | `timestamp` | ya | — | `$table->timestamps()` · [2026_06_08_000001_add_ecommerce_flow_fields.php](../../../../Motifnesia-Server/database/migrations/2026_06_08_000001_add_ecommerce_flow_fields.php#L85) |
| `updated_at` | `timestamp` | ya | — | `$table->timestamps()` · [2026_06_08_000001_add_ecommerce_flow_fields.php](../../../../Motifnesia-Server/database/migrations/2026_06_08_000001_add_ecommerce_flow_fields.php#L85) |

Indeks/constraint tambahan. `unique(['produk_id', 'ukuran'])` [migration](../../../../Motifnesia-Server/database/migrations/2026_06_08_000001_add_ecommerce_flow_fields.php#L88), `index(['produk_id', 'stok'])` [migration](../../../../Motifnesia-Server/database/migrations/2026_06_08_000001_add_ecommerce_flow_fields.php#L89)

### reviews

Model. [Review](../../../../Motifnesia-Server/app/Models/Review.php#L9)

| Kolom | Blueprint | Null | Kunci | Definisi dan bukti |
| --- | --- | --- | --- | --- |
| `id` | `id` | tidak | PK | `$table->id()` · [2025_11_24_000012_create_reviews_table.php](../../../../Motifnesia-Server/database/migrations/2025_11_24_000012_create_reviews_table.php#L15) |
| `user_id` | `foreignId` | tidak | FK | `$table->foreignId('user_id')->constrained('users')->onDelete('cascade')` · [2025_11_24_000012_create_reviews_table.php](../../../../Motifnesia-Server/database/migrations/2025_11_24_000012_create_reviews_table.php#L16) |
| `product_id` | `unsignedBigInteger` | tidak | — | `$table->unsignedBigInteger('product_id')->index()` · [2025_11_24_000012_create_reviews_table.php](../../../../Motifnesia-Server/database/migrations/2025_11_24_000012_create_reviews_table.php#L17) |
| `rating` | `tinyInteger` | tidak | — | `$table->tinyInteger('rating')->unsigned()` · [2025_11_24_000012_create_reviews_table.php](../../../../Motifnesia-Server/database/migrations/2025_11_24_000012_create_reviews_table.php#L18) |
| `comment` | `text` | ya | — | `$table->text('comment')->nullable()` · [2025_11_24_000012_create_reviews_table.php](../../../../Motifnesia-Server/database/migrations/2025_11_24_000012_create_reviews_table.php#L19) |
| `created_at` | `timestamp` | ya | — | `$table->timestamps()` · [2025_11_24_000012_create_reviews_table.php](../../../../Motifnesia-Server/database/migrations/2025_11_24_000012_create_reviews_table.php#L20) |
| `updated_at` | `timestamp` | ya | — | `$table->timestamps()` · [2025_11_24_000012_create_reviews_table.php](../../../../Motifnesia-Server/database/migrations/2025_11_24_000012_create_reviews_table.php#L20) |

### product_favorite

Model. [ProductFavorite](../../../../Motifnesia-Server/app/Models/ProductFavorite.php#L8)

| Kolom | Blueprint | Null | Kunci | Definisi dan bukti |
| --- | --- | --- | --- | --- |
| `id` | `id` | tidak | PK | `$table->id()` · [2025_12_11_130000_create_product_favorite_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_11_130000_create_product_favorite_table.php#L12) |
| `user_id` | `foreignId` | tidak | FK | `$table->foreignId('user_id')->constrained('users')->onDelete('cascade')` · [2025_12_11_130000_create_product_favorite_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_11_130000_create_product_favorite_table.php#L13) |
| `produk_id` | `unsignedInteger` | tidak | FK | `$table->unsignedInteger('produk_id')` · [2025_12_11_130000_create_product_favorite_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_11_130000_create_product_favorite_table.php#L14) |
| `created_at` | `timestamp` | ya | — | `$table->timestamps()` · [2025_12_11_130000_create_product_favorite_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_11_130000_create_product_favorite_table.php#L16) |
| `updated_at` | `timestamp` | ya | — | `$table->timestamps()` · [2025_12_11_130000_create_product_favorite_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_11_130000_create_product_favorite_table.php#L16) |

Indeks/constraint tambahan. `unique(['user_id', 'produk_id'])` [migration](../../../../Motifnesia-Server/database/migrations/2025_12_11_130000_create_product_favorite_table.php#L19)

### shopping_card

Model. [ShoppingCard](../../../../Motifnesia-Server/app/Models/ShoppingCard.php#L8)

| Kolom | Blueprint | Null | Kunci | Definisi dan bukti |
| --- | --- | --- | --- | --- |
| `id` | `increments` | tidak | PK | `$table->increments('id')` · [2025_12_06_000015_create_shopping_card_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_06_000015_create_shopping_card_table.php#L11) |
| `user_id` | `unsignedBigInteger` | ya | FK | `$table->unsignedBigInteger('user_id')->nullable()` · [2025_12_06_000015_create_shopping_card_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_06_000015_create_shopping_card_table.php#L12) |
| `product_id` | `unsignedInteger` | ya | FK | `$table->unsignedInteger('product_id')->nullable()` · [2025_12_06_000015_create_shopping_card_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_06_000015_create_shopping_card_table.php#L13) |
| `ukuran` | `string(10)` | ya | — | `$table->string('ukuran', 10)->nullable()` · [2025_12_06_000015_create_shopping_card_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_06_000015_create_shopping_card_table.php#L14) |
| `qty` | `integer` | tidak | — | `$table->integer('qty')->default(1)` · [2025_12_06_000015_create_shopping_card_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_06_000015_create_shopping_card_table.php#L15) |
| `created_at` | `timestamp` | ya | — | `$table->timestamps()` · [2025_12_06_000015_create_shopping_card_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_06_000015_create_shopping_card_table.php#L16) |
| `updated_at` | `timestamp` | ya | — | `$table->timestamps()` · [2025_12_06_000015_create_shopping_card_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_06_000015_create_shopping_card_table.php#L16) |

### konten_about_us

Model. [KontenAboutUs](../../../../Motifnesia-Server/app/Models/KontenAboutUs.php#L8)

| Kolom | Blueprint | Null | Kunci | Definisi dan bukti |
| --- | --- | --- | --- | --- |
| `id` | `id` | tidak | PK | `$table->id()` · [2025_11_23_000005_create_konten_about_us_table.php](../../../../Motifnesia-Server/database/migrations/2025_11_23_000005_create_konten_about_us_table.php#L12) |
| `judul` | `string` | ya | — | `$table->string('judul')->nullable()` · [2025_11_23_000005_create_konten_about_us_table.php](../../../../Motifnesia-Server/database/migrations/2025_11_23_000005_create_konten_about_us_table.php#L13) |
| `isi` | `text` | ya | — | `$table->text('isi')->nullable()` · [2025_11_23_000005_create_konten_about_us_table.php](../../../../Motifnesia-Server/database/migrations/2025_11_23_000005_create_konten_about_us_table.php#L14) |
| `gambar` | `string` | ya | — | `$table->string('gambar')->nullable()` · [2025_11_23_000005_create_konten_about_us_table.php](../../../../Motifnesia-Server/database/migrations/2025_11_23_000005_create_konten_about_us_table.php#L15) |
| `created_at` | `timestamp` | ya | — | `$table->timestamps()` · [2025_11_23_000005_create_konten_about_us_table.php](../../../../Motifnesia-Server/database/migrations/2025_11_23_000005_create_konten_about_us_table.php#L16) |
| `updated_at` | `timestamp` | ya | — | `$table->timestamps()` · [2025_11_23_000005_create_konten_about_us_table.php](../../../../Motifnesia-Server/database/migrations/2025_11_23_000005_create_konten_about_us_table.php#L16) |
| `background_gambar` | `string` | ya | — | `$table->string('background_gambar')->nullable()` · [2025_11_24_000007_add_fields_to_konten_about_us.php](../../../../Motifnesia-Server/database/migrations/2025_11_24_000007_add_fields_to_konten_about_us.php#L12) |
| `tentang_gambar` | `string` | ya | — | `$table->string('tentang_gambar')->nullable()` · [2025_11_24_000007_add_fields_to_konten_about_us.php](../../../../Motifnesia-Server/database/migrations/2025_11_24_000007_add_fields_to_konten_about_us.php#L13) |
| `tentang_isi` | `text` | ya | — | `$table->text('tentang_isi')->nullable()` · [2025_11_24_000007_add_fields_to_konten_about_us.php](../../../../Motifnesia-Server/database/migrations/2025_11_24_000007_add_fields_to_konten_about_us.php#L14) |
| `visi_gambar` | `string` | ya | — | `$table->string('visi_gambar')->nullable()` · [2025_11_24_000007_add_fields_to_konten_about_us.php](../../../../Motifnesia-Server/database/migrations/2025_11_24_000007_add_fields_to_konten_about_us.php#L15) |
| `visi_isi` | `text` | ya | — | `$table->text('visi_isi')->nullable()` · [2025_11_24_000007_add_fields_to_konten_about_us.php](../../../../Motifnesia-Server/database/migrations/2025_11_24_000007_add_fields_to_konten_about_us.php#L16) |
| `nilai_gambar` | `string` | ya | — | `$table->string('nilai_gambar')->nullable()` · [2025_11_24_000007_add_fields_to_konten_about_us.php](../../../../Motifnesia-Server/database/migrations/2025_11_24_000007_add_fields_to_konten_about_us.php#L17) |
| `nilai_isi` | `text` | ya | — | `$table->text('nilai_isi')->nullable()` · [2025_11_24_000007_add_fields_to_konten_about_us.php](../../../../Motifnesia-Server/database/migrations/2025_11_24_000007_add_fields_to_konten_about_us.php#L18) |

### konten_icon

Model. [KontenIcon](../../../../Motifnesia-Server/app/Models/KontenIcon.php#L8)

| Kolom | Blueprint | Null | Kunci | Definisi dan bukti |
| --- | --- | --- | --- | --- |
| `id` | `id` | tidak | PK | `$table->id()` · [2025_11_23_000004_create_konten_icon_table.php](../../../../Motifnesia-Server/database/migrations/2025_11_23_000004_create_konten_icon_table.php#L12) |
| `nama` | `string` | ya | — | `$table->string('nama')->nullable()` · [2025_11_23_000004_create_konten_icon_table.php](../../../../Motifnesia-Server/database/migrations/2025_11_23_000004_create_konten_icon_table.php#L13) |
| `gambar` | `string` | ya | — | `$table->string('gambar')->nullable()` · [2025_11_23_000004_create_konten_icon_table.php](../../../../Motifnesia-Server/database/migrations/2025_11_23_000004_create_konten_icon_table.php#L14) |
| `link` | `string` | ya | — | `$table->string('link')->nullable()` · [2025_11_23_000004_create_konten_icon_table.php](../../../../Motifnesia-Server/database/migrations/2025_11_23_000004_create_konten_icon_table.php#L15) |
| `urutan` | `integer` | tidak | — | `$table->integer('urutan')->default(0)` · [2025_11_23_000004_create_konten_icon_table.php](../../../../Motifnesia-Server/database/migrations/2025_11_23_000004_create_konten_icon_table.php#L16) |
| `created_at` | `timestamp` | ya | — | `$table->timestamps()` · [2025_11_23_000004_create_konten_icon_table.php](../../../../Motifnesia-Server/database/migrations/2025_11_23_000004_create_konten_icon_table.php#L17) |
| `updated_at` | `timestamp` | ya | — | `$table->timestamps()` · [2025_11_23_000004_create_konten_icon_table.php](../../../../Motifnesia-Server/database/migrations/2025_11_23_000004_create_konten_icon_table.php#L17) |

### konten_slide_show

Model. [KontenSlideShow](../../../../Motifnesia-Server/app/Models/KontenSlideShow.php#L8)

| Kolom | Blueprint | Null | Kunci | Definisi dan bukti |
| --- | --- | --- | --- | --- |
| `id` | `id` | tidak | PK | `$table->id()` · [2025_11_23_000006_create_konten_slide_show_table.php](../../../../Motifnesia-Server/database/migrations/2025_11_23_000006_create_konten_slide_show_table.php#L12) |
| `judul` | `string` | ya | — | `$table->string('judul')->nullable()` · [2025_11_23_000006_create_konten_slide_show_table.php](../../../../Motifnesia-Server/database/migrations/2025_11_23_000006_create_konten_slide_show_table.php#L13) |
| `caption` | `string` | ya | — | `$table->string('caption')->nullable()` · [2025_11_23_000006_create_konten_slide_show_table.php](../../../../Motifnesia-Server/database/migrations/2025_11_23_000006_create_konten_slide_show_table.php#L14) |
| `gambar` | `string` | ya | — | `$table->string('gambar')->nullable()` · [2025_11_23_000006_create_konten_slide_show_table.php](../../../../Motifnesia-Server/database/migrations/2025_11_23_000006_create_konten_slide_show_table.php#L15) |
| `link` | `string` | ya | — | `$table->string('link')->nullable()` · [2025_11_23_000006_create_konten_slide_show_table.php](../../../../Motifnesia-Server/database/migrations/2025_11_23_000006_create_konten_slide_show_table.php#L16) |
| `aktif` | `boolean` | tidak | — | `$table->boolean('aktif')->default(true)` · [2025_11_23_000006_create_konten_slide_show_table.php](../../../../Motifnesia-Server/database/migrations/2025_11_23_000006_create_konten_slide_show_table.php#L17) |
| `urutan` | `integer` | tidak | — | `$table->integer('urutan')->default(0)` · [2025_11_23_000006_create_konten_slide_show_table.php](../../../../Motifnesia-Server/database/migrations/2025_11_23_000006_create_konten_slide_show_table.php#L18) |
| `created_at` | `timestamp` | ya | — | `$table->timestamps()` · [2025_11_23_000006_create_konten_slide_show_table.php](../../../../Motifnesia-Server/database/migrations/2025_11_23_000006_create_konten_slide_show_table.php#L19) |
| `updated_at` | `timestamp` | ya | — | `$table->timestamps()` · [2025_11_23_000006_create_konten_slide_show_table.php](../../../../Motifnesia-Server/database/migrations/2025_11_23_000006_create_konten_slide_show_table.php#L19) |

### audit_logs

Model. [AuditLog](../../../../Motifnesia-Server/app/Models/AuditLog.php#L7)

| Kolom | Blueprint | Null | Kunci | Definisi dan bukti |
| --- | --- | --- | --- | --- |
| `id` | `id` | tidak | PK | `$table->id()` · [2026_06_08_083619_create_audit_logs_table.php](../../../../Motifnesia-Server/database/migrations/2026_06_08_083619_create_audit_logs_table.php#L15) |
| `user_id` | `foreignId` | ya | FK | `$table->foreignId('user_id')->nullable()->constrained('users')->nullOnDelete()` · [2026_06_08_083619_create_audit_logs_table.php](../../../../Motifnesia-Server/database/migrations/2026_06_08_083619_create_audit_logs_table.php#L16) |
| `action` | `string` | tidak | — | `$table->string('action')` · [2026_06_08_083619_create_audit_logs_table.php](../../../../Motifnesia-Server/database/migrations/2026_06_08_083619_create_audit_logs_table.php#L17) |
| `model_type` | `string` | tidak | — | `$table->string('model_type')` · [2026_06_08_083619_create_audit_logs_table.php](../../../../Motifnesia-Server/database/migrations/2026_06_08_083619_create_audit_logs_table.php#L18) |
| `model_id` | `unsignedBigInteger` | ya | — | `$table->unsignedBigInteger('model_id')->nullable()` · [2026_06_08_083619_create_audit_logs_table.php](../../../../Motifnesia-Server/database/migrations/2026_06_08_083619_create_audit_logs_table.php#L19) |
| `details` | `json` | ya | — | `$table->json('details')->nullable()` · [2026_06_08_083619_create_audit_logs_table.php](../../../../Motifnesia-Server/database/migrations/2026_06_08_083619_create_audit_logs_table.php#L20) |
| `ip_address` | `string(45)` | ya | — | `$table->string('ip_address', 45)->nullable()` · [2026_06_08_083619_create_audit_logs_table.php](../../../../Motifnesia-Server/database/migrations/2026_06_08_083619_create_audit_logs_table.php#L21) |
| `created_at` | `timestamp` | tidak | — | `$table->timestamp('created_at')->useCurrent()` · [2026_06_08_083619_create_audit_logs_table.php](../../../../Motifnesia-Server/database/migrations/2026_06_08_083619_create_audit_logs_table.php#L22) |

## Pesanan, pembayaran dan retur

### orders

Model. [Order](../../../../Motifnesia-Server/app/Models/Order.php#L8)

| Kolom | Blueprint | Null | Kunci | Definisi dan bukti |
| --- | --- | --- | --- | --- |
| `id` | `id` | tidak | PK | `$table->id()` · [2025_12_11_100001_create_orders_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_11_100001_create_orders_table.php#L12) |
| `user_id` | `foreignId` | tidak | FK | `$table->foreignId('user_id')->constrained('users')` · [2025_12_11_100001_create_orders_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_11_100001_create_orders_table.php#L13) |
| `order_number` | `string` | tidak | UK | `$table->string('order_number')->unique()` · [2025_12_11_100001_create_orders_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_11_100001_create_orders_table.php#L14) |
| `alamat` | `text` | tidak | — | `$table->text('alamat')` · [2025_12_11_100001_create_orders_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_11_100001_create_orders_table.php#L15) |
| `metode_pengiriman_id` | `foreignId` | tidak | FK | `$table->foreignId('metode_pengiriman_id')->constrained('metode_pengiriman')` · [2025_12_11_100001_create_orders_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_11_100001_create_orders_table.php#L16) |
| `metode_pembayaran_id` | `foreignId` | tidak | FK | `$table->foreignId('metode_pembayaran_id')->constrained('metode_pembayaran')` · [2025_12_11_100001_create_orders_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_11_100001_create_orders_table.php#L17) |
| `delivery_status_id` | `foreignId` | tidak | FK | `$table->foreignId('delivery_status_id')->constrained('delivery_status')` · [2025_12_11_100001_create_orders_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_11_100001_create_orders_table.php#L18) |
| `total_ongkir` | `decimal(15, 2)` | tidak | — | `$table->decimal('total_ongkir', 15, 2)` · [2025_12_11_100001_create_orders_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_11_100001_create_orders_table.php#L19) |
| `total_bayar` | `decimal(15, 2)` | tidak | — | `$table->decimal('total_bayar', 15, 2)` · [2025_12_11_100001_create_orders_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_11_100001_create_orders_table.php#L20) |
| `payment_number` | `string` | ya | — | `$table->string('payment_number')->nullable()` · [2025_12_11_100001_create_orders_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_11_100001_create_orders_table.php#L21) |
| `created_at` | `timestamp` | ya | — | `$table->timestamps()` · [2025_12_11_100001_create_orders_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_11_100001_create_orders_table.php#L22) |
| `updated_at` | `timestamp` | ya | — | `$table->timestamps()` · [2025_12_11_100001_create_orders_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_11_100001_create_orders_table.php#L22) |
| `membership_redemption_id` | `foreignId` | ya | FK | `$table->foreignId('membership_redemption_id')->nullable()->after('payment_number')->constrained('user_reward_redemptions')->nullOnDelete()` · [2026_05_23_000001_sync_membership_voucher_and_review_moderation.php](../../../../Motifnesia-Server/database/migrations/2026_05_23_000001_sync_membership_voucher_and_review_moderation.php#L14) |
| `voucher_code` | `string` | ya | — | `$table->string('voucher_code')->nullable()->after('membership_redemption_id')` · [2026_05_23_000001_sync_membership_voucher_and_review_moderation.php](../../../../Motifnesia-Server/database/migrations/2026_05_23_000001_sync_membership_voucher_and_review_moderation.php#L22) |
| `voucher_discount` | `decimal(15, 2)` | tidak | — | `$table->decimal('voucher_discount', 15, 2)->default(0)->after('voucher_code')` · [2026_05_23_000001_sync_membership_voucher_and_review_moderation.php](../../../../Motifnesia-Server/database/migrations/2026_05_23_000001_sync_membership_voucher_and_review_moderation.php#L26) |
| `payment_status` | `string(40)` | tidak | — | `$table->string('payment_status', 40)->default('waiting_verification')->after('payment_number')` · [2026_06_08_000001_add_ecommerce_flow_fields.php](../../../../Motifnesia-Server/database/migrations/2026_06_08_000001_add_ecommerce_flow_fields.php#L13) |
| `payment_deadline_at` | `timestamp` | ya | — | `$table->timestamp('payment_deadline_at')->nullable()->after('payment_status')` · [2026_06_08_000001_add_ecommerce_flow_fields.php](../../../../Motifnesia-Server/database/migrations/2026_06_08_000001_add_ecommerce_flow_fields.php#L17) |
| `paid_at` | `timestamp` | ya | — | `$table->timestamp('paid_at')->nullable()->after('payment_deadline_at')` · [2026_06_08_000001_add_ecommerce_flow_fields.php](../../../../Motifnesia-Server/database/migrations/2026_06_08_000001_add_ecommerce_flow_fields.php#L21) |
| `payment_verified_at` | `timestamp` | ya | — | `$table->timestamp('payment_verified_at')->nullable()->after('paid_at')` · [2026_06_08_000001_add_ecommerce_flow_fields.php](../../../../Motifnesia-Server/database/migrations/2026_06_08_000001_add_ecommerce_flow_fields.php#L25) |
| `payment_rejected_at` | `timestamp` | ya | — | `$table->timestamp('payment_rejected_at')->nullable()->after('payment_verified_at')` · [2026_06_08_000001_add_ecommerce_flow_fields.php](../../../../Motifnesia-Server/database/migrations/2026_06_08_000001_add_ecommerce_flow_fields.php#L29) |
| `payment_note` | `text` | ya | — | `$table->text('payment_note')->nullable()->after('payment_rejected_at')` · [2026_06_08_000001_add_ecommerce_flow_fields.php](../../../../Motifnesia-Server/database/migrations/2026_06_08_000001_add_ecommerce_flow_fields.php#L33) |
| `customer_confirmed_at` | `timestamp` | ya | — | `$table->timestamp('customer_confirmed_at')->nullable()->after('payment_note')` · [2026_06_08_000001_add_ecommerce_flow_fields.php](../../../../Motifnesia-Server/database/migrations/2026_06_08_000001_add_ecommerce_flow_fields.php#L37) |
| `sold_counted_at` | `timestamp` | ya | — | `$table->timestamp('sold_counted_at')->nullable()->after('customer_confirmed_at')` · [2026_06_08_000001_add_ecommerce_flow_fields.php](../../../../Motifnesia-Server/database/migrations/2026_06_08_000001_add_ecommerce_flow_fields.php#L41) |
| `payment_proof` | `string` | ya | — | `$table->string('payment_proof')->nullable()->after('payment_note')` · [2026_06_08_083000_add_payment_proof_to_orders_table.php](../../../../Motifnesia-Server/database/migrations/2026_06_08_083000_add_payment_proof_to_orders_table.php#L15) |
| `membership_tier` | `string` | ya | — | `$table->string('membership_tier')->nullable()->after('voucher_discount')` · [2026_06_09_050240_add_membership_tier_discount_to_orders_table.php](../../../../Motifnesia-Server/database/migrations/2026_06_09_050240_add_membership_tier_discount_to_orders_table.php#L15) |
| `membership_tier_discount` | `decimal(15, 2)` | tidak | — | `$table->decimal('membership_tier_discount', 15, 2)->default(0.0)->after('membership_tier')` · [2026_06_09_050240_add_membership_tier_discount_to_orders_table.php](../../../../Motifnesia-Server/database/migrations/2026_06_09_050240_add_membership_tier_discount_to_orders_table.php#L16) |

### order_items

Model. [OrderItem](../../../../Motifnesia-Server/app/Models/OrderItem.php#L8)

| Kolom | Blueprint | Null | Kunci | Definisi dan bukti |
| --- | --- | --- | --- | --- |
| `id` | `id` | tidak | PK | `$table->id()` · [2025_12_11_100002_create_order_items_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_11_100002_create_order_items_table.php#L12) |
| `order_id` | `foreignId` | tidak | FK | `$table->foreignId('order_id')->constrained('orders')->onDelete('cascade')` · [2025_12_11_100002_create_order_items_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_11_100002_create_order_items_table.php#L13) |
| `produk_id` | `unsignedInteger` | tidak | FK | `$table->unsignedInteger('produk_id')` · [2025_12_11_100002_create_order_items_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_11_100002_create_order_items_table.php#L14) |
| `nama_produk` | `string(255)` | tidak | — | `$table->string('nama_produk', 255)` · [2025_12_11_100002_create_order_items_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_11_100002_create_order_items_table.php#L15) |
| `ukuran` | `string(10)` | ya | — | `$table->string('ukuran', 10)->nullable()` · [2025_12_11_100002_create_order_items_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_11_100002_create_order_items_table.php#L16) |
| `qty` | `integer` | tidak | — | `$table->integer('qty')` · [2025_12_11_100002_create_order_items_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_11_100002_create_order_items_table.php#L17) |
| `harga` | `decimal(12, 2)` | tidak | — | `$table->decimal('harga', 12, 2)` · [2025_12_11_100002_create_order_items_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_11_100002_create_order_items_table.php#L18) |
| `subtotal` | `decimal(12, 2)` | tidak | — | `$table->decimal('subtotal', 12, 2)` · [2025_12_11_100002_create_order_items_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_11_100002_create_order_items_table.php#L19) |
| `created_at` | `timestamp` | ya | — | `$table->timestamps()` · [2025_12_11_100002_create_order_items_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_11_100002_create_order_items_table.php#L20) |
| `updated_at` | `timestamp` | ya | — | `$table->timestamps()` · [2025_12_11_100002_create_order_items_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_11_100002_create_order_items_table.php#L20) |

### order_status_history

Model. [OrderStatusHistory](../../../../Motifnesia-Server/app/Models/OrderStatusHistory.php#L8)

| Kolom | Blueprint | Null | Kunci | Definisi dan bukti |
| --- | --- | --- | --- | --- |
| `id` | `id` | tidak | PK | `$table->id()` · [2025_12_11_100003_create_order_status_history_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_11_100003_create_order_status_history_table.php#L12) |
| `order_id` | `foreignId` | tidak | FK | `$table->foreignId('order_id')->constrained('orders')->onDelete('cascade')` · [2025_12_11_100003_create_order_status_history_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_11_100003_create_order_status_history_table.php#L13) |
| `delivery_status_id` | `foreignId` | tidak | FK | `$table->foreignId('delivery_status_id')->constrained('delivery_status')` · [2025_12_11_100003_create_order_status_history_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_11_100003_create_order_status_history_table.php#L14) |
| `changed_at` | `timestamp` | tidak | — | `$table->timestamp('changed_at')` · [2025_12_11_100003_create_order_status_history_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_11_100003_create_order_status_history_table.php#L15) |
| `created_at` | `timestamp` | ya | — | `$table->timestamps()` · [2025_12_11_100003_create_order_status_history_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_11_100003_create_order_status_history_table.php#L16) |
| `updated_at` | `timestamp` | ya | — | `$table->timestamps()` · [2025_12_11_100003_create_order_status_history_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_11_100003_create_order_status_history_table.php#L16) |

### delivery_status

Model. [DeliveryStatus](../../../../Motifnesia-Server/app/Models/DeliveryStatus.php#L7)

| Kolom | Blueprint | Null | Kunci | Definisi dan bukti |
| --- | --- | --- | --- | --- |
| `id` | `id` | tidak | PK | `$table->id()` · [2025_12_10_115919_create_delivery_status_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_10_115919_create_delivery_status_table.php#L15) |
| `nama_status` | `string` | tidak | — | `$table->string('nama_status')` · [2025_12_10_115919_create_delivery_status_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_10_115919_create_delivery_status_table.php#L16) |
| `deskripsi` | `string` | ya | — | `$table->string('deskripsi')->nullable()` · [2025_12_10_115919_create_delivery_status_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_10_115919_create_delivery_status_table.php#L17) |
| `created_at` | `timestamp` | ya | — | `$table->timestamps()` · [2025_12_10_115919_create_delivery_status_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_10_115919_create_delivery_status_table.php#L18) |
| `updated_at` | `timestamp` | ya | — | `$table->timestamps()` · [2025_12_10_115919_create_delivery_status_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_10_115919_create_delivery_status_table.php#L18) |

### metode_pembayaran

Model. [MetodePembayaran](../../../../Motifnesia-Server/app/Models/MetodePembayaran.php#L8)

| Kolom | Blueprint | Null | Kunci | Definisi dan bukti |
| --- | --- | --- | --- | --- |
| `id` | `id` | tidak | PK | `$table->id()` · [2025_12_07_000017_create_metode_pembayaran_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_07_000017_create_metode_pembayaran_table.php#L11) |
| `nama_pembayaran` | `string` | tidak | — | `$table->string('nama_pembayaran')` · [2025_12_07_000017_create_metode_pembayaran_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_07_000017_create_metode_pembayaran_table.php#L12) |
| `deskripsi_pembayaran` | `string` | ya | — | `$table->string('deskripsi_pembayaran')->nullable()` · [2025_12_07_000017_create_metode_pembayaran_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_07_000017_create_metode_pembayaran_table.php#L13) |
| `created_at` | `timestamp` | ya | — | `$table->timestamps()` · [2025_12_07_000017_create_metode_pembayaran_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_07_000017_create_metode_pembayaran_table.php#L14) |
| `updated_at` | `timestamp` | ya | — | `$table->timestamps()` · [2025_12_07_000017_create_metode_pembayaran_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_07_000017_create_metode_pembayaran_table.php#L14) |

### metode_pengiriman

Model. [MetodePengiriman](../../../../Motifnesia-Server/app/Models/MetodePengiriman.php#L8)

| Kolom | Blueprint | Null | Kunci | Definisi dan bukti |
| --- | --- | --- | --- | --- |
| `id` | `id` | tidak | PK | `$table->id()` · [2025_12_07_000016_create_metode_pengiriman_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_07_000016_create_metode_pengiriman_table.php#L11) |
| `nama_pengiriman` | `string` | tidak | — | `$table->string('nama_pengiriman')` · [2025_12_07_000016_create_metode_pengiriman_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_07_000016_create_metode_pengiriman_table.php#L12) |
| `deskripsi_pengiriman` | `string` | ya | — | `$table->string('deskripsi_pengiriman')->nullable()` · [2025_12_07_000016_create_metode_pengiriman_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_07_000016_create_metode_pengiriman_table.php#L13) |
| `harga` | `integer` | tidak | — | `$table->integer('harga')->default(0)` · [2025_12_07_000016_create_metode_pengiriman_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_07_000016_create_metode_pengiriman_table.php#L14) |
| `created_at` | `timestamp` | ya | — | `$table->timestamps()` · [2025_12_07_000016_create_metode_pengiriman_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_07_000016_create_metode_pengiriman_table.php#L15) |
| `updated_at` | `timestamp` | ya | — | `$table->timestamps()` · [2025_12_07_000016_create_metode_pengiriman_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_07_000016_create_metode_pengiriman_table.php#L15) |

### returns

Model. [ProductReturn](../../../../Motifnesia-Server/app/Models/ProductReturn.php#L9)

| Kolom | Blueprint | Null | Kunci | Definisi dan bukti |
| --- | --- | --- | --- | --- |
| `id` | `id` | tidak | PK | `$table->id()` · [2025_12_13_000001_create_returns_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_13_000001_create_returns_table.php#L15) |
| `user_id` | `foreignId` | tidak | FK | `$table->foreignId('user_id')->constrained('users')->onDelete('cascade')` · [2025_12_13_000001_create_returns_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_13_000001_create_returns_table.php#L16) |
| `order_id` | `foreignId` | tidak | FK | `$table->foreignId('order_id')->constrained('orders')->onDelete('cascade')` · [2025_12_13_000001_create_returns_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_13_000001_create_returns_table.php#L17) |
| `order_item_id` | `foreignId` | tidak | FK | `$table->foreignId('order_item_id')->constrained('order_items')->onDelete('cascade')` · [2025_12_13_000001_create_returns_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_13_000001_create_returns_table.php#L18) |
| `produk_id` | `unsignedInteger` | tidak | FK | `$table->unsignedInteger('produk_id')` · [2025_12_13_000001_create_returns_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_13_000001_create_returns_table.php#L19) |
| `reason` | `enum(['Ukuran tidak sesuai', 'Barang rusak/cacat', 'Salah kirim produk', 'Tidak sesuai deskripsi', 'Berubah pikiran', 'Lainnya'])` | tidak | — | `$table->enum('reason', ['Ukuran tidak sesuai', 'Barang rusak/cacat', 'Salah kirim produk', 'Tidak sesuai deskripsi', 'Berubah pikiran', 'Lainnya'])` · [2025_12_13_000001_create_returns_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_13_000001_create_returns_table.php#L23) |
| `description` | `text` | ya | — | `$table->text('description')->nullable()` · [2025_12_13_000001_create_returns_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_13_000001_create_returns_table.php#L31) |
| `photo_proof` | `string` | ya | — | `$table->string('photo_proof')->nullable()` · [2025_12_13_000001_create_returns_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_13_000001_create_returns_table.php#L32) |
| `status` | `enum(['Pending', 'Disetujui', 'Ditolak', 'Diproses', 'Selesai'])` | tidak | — | `$table->enum('status', ['Pending', 'Disetujui', 'Ditolak', 'Diproses', 'Selesai'])->default('Pending')` · [2025_12_13_000001_create_returns_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_13_000001_create_returns_table.php#L35) |
| `admin_note` | `text` | ya | — | `$table->text('admin_note')->nullable()` · [2025_12_13_000001_create_returns_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_13_000001_create_returns_table.php#L36) |
| `action_type` | `enum(['Refund', 'Tukar Barang'])` | tidak | — | `$table->enum('action_type', ['Refund', 'Tukar Barang'])->default('Refund')` · [2025_12_13_000001_create_returns_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_13_000001_create_returns_table.php#L37) |
| `refund_amount` | `decimal(15, 2)` | ya | — | `$table->decimal('refund_amount', 15, 2)->nullable()` · [2025_12_13_000001_create_returns_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_13_000001_create_returns_table.php#L40) |
| `refund_status` | `enum(['Belum', 'Diproses', 'Selesai'])` | tidak | — | `$table->enum('refund_status', ['Belum', 'Diproses', 'Selesai'])->default('Belum')` · [2025_12_13_000001_create_returns_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_13_000001_create_returns_table.php#L41) |
| `created_at` | `timestamp` | ya | — | `$table->timestamps()` · [2025_12_13_000001_create_returns_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_13_000001_create_returns_table.php#L43) |
| `updated_at` | `timestamp` | ya | — | `$table->timestamps()` · [2025_12_13_000001_create_returns_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_13_000001_create_returns_table.php#L43) |
| `return_stage` | `string(40)` | tidak | — | `$table->string('return_stage', 40)->default('request_submitted')->after('refund_status')` · [2026_06_08_000001_add_ecommerce_flow_fields.php](../../../../Motifnesia-Server/database/migrations/2026_06_08_000001_add_ecommerce_flow_fields.php#L95) |
| `courier_photo` | `string` | ya | — | `$table->string('courier_photo')->nullable()->after('return_stage')` · [2026_06_08_000001_add_ecommerce_flow_fields.php](../../../../Motifnesia-Server/database/migrations/2026_06_08_000001_add_ecommerce_flow_fields.php#L99) |
| `courier_note` | `text` | ya | — | `$table->text('courier_note')->nullable()->after('courier_photo')` · [2026_06_08_000001_add_ecommerce_flow_fields.php](../../../../Motifnesia-Server/database/migrations/2026_06_08_000001_add_ecommerce_flow_fields.php#L103) |
| `courier_submitted_at` | `timestamp` | ya | — | `$table->timestamp('courier_submitted_at')->nullable()->after('courier_note')` · [2026_06_08_000001_add_ecommerce_flow_fields.php](../../../../Motifnesia-Server/database/migrations/2026_06_08_000001_add_ecommerce_flow_fields.php#L107) |
| `return_deadline_at` | `timestamp` | ya | — | `$table->timestamp('return_deadline_at')->nullable()->after('courier_submitted_at')` · [2026_06_08_000001_add_ecommerce_flow_fields.php](../../../../Motifnesia-Server/database/migrations/2026_06_08_000001_add_ecommerce_flow_fields.php#L111) |
| `approved_at` | `timestamp` | ya | — | `$table->timestamp('approved_at')->nullable()->after('return_deadline_at')` · [2026_06_08_000001_add_ecommerce_flow_fields.php](../../../../Motifnesia-Server/database/migrations/2026_06_08_000001_add_ecommerce_flow_fields.php#L115) |
| `rejected_at` | `timestamp` | ya | — | `$table->timestamp('rejected_at')->nullable()->after('approved_at')` · [2026_06_08_000001_add_ecommerce_flow_fields.php](../../../../Motifnesia-Server/database/migrations/2026_06_08_000001_add_ecommerce_flow_fields.php#L119) |
| `completed_at` | `timestamp` | ya | — | `$table->timestamp('completed_at')->nullable()->after('rejected_at')` · [2026_06_08_000001_add_ecommerce_flow_fields.php](../../../../Motifnesia-Server/database/migrations/2026_06_08_000001_add_ecommerce_flow_fields.php#L123) |

Indeks/constraint tambahan. `index('user_id')` [migration](../../../../Motifnesia-Server/database/migrations/2025_12_13_000001_create_returns_table.php#L46), `index('order_id')` [migration](../../../../Motifnesia-Server/database/migrations/2025_12_13_000001_create_returns_table.php#L47), `index('status')` [migration](../../../../Motifnesia-Server/database/migrations/2025_12_13_000001_create_returns_table.php#L48), `index('created_at')` [migration](../../../../Motifnesia-Server/database/migrations/2025_12_13_000001_create_returns_table.php#L49)

### order_reviews

Model. [OrderReview](../../../../Motifnesia-Server/app/Models/OrderReview.php#L8)

| Kolom | Blueprint | Null | Kunci | Definisi dan bukti |
| --- | --- | --- | --- | --- |
| `id` | `id` | tidak | PK | `$table->id()` · [2025_12_11_150000_create_order_reviews_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_11_150000_create_order_reviews_table.php#L15) |
| `user_id` | `foreignId` | tidak | FK | `$table->foreignId('user_id')->constrained('users')->onDelete('cascade')` · [2025_12_11_150000_create_order_reviews_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_11_150000_create_order_reviews_table.php#L16) |
| `order_item_id` | `foreignId` | tidak | FK | `$table->foreignId('order_item_id')->constrained('order_items')->onDelete('cascade')` · [2025_12_11_150000_create_order_reviews_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_11_150000_create_order_reviews_table.php#L17) |
| `order_id` | `foreignId` | tidak | FK | `$table->foreignId('order_id')->constrained('orders')->onDelete('cascade')` · [2025_12_11_150000_create_order_reviews_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_11_150000_create_order_reviews_table.php#L18) |
| `produk_id` | `unsignedInteger` | tidak | FK | `$table->unsignedInteger('produk_id')` · [2025_12_11_150000_create_order_reviews_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_11_150000_create_order_reviews_table.php#L19) |
| `rating` | `tinyInteger` | tidak | — | `$table->tinyInteger('rating')->comment('Rating 1-5')` · [2025_12_11_150000_create_order_reviews_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_11_150000_create_order_reviews_table.php#L20) |
| `deskripsi_ulasan` | `text` | ya | — | `$table->text('deskripsi_ulasan')->nullable()` · [2025_12_11_150000_create_order_reviews_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_11_150000_create_order_reviews_table.php#L21) |
| `created_at` | `timestamp` | ya | — | `$table->timestamps()` · [2025_12_11_150000_create_order_reviews_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_11_150000_create_order_reviews_table.php#L22) |
| `updated_at` | `timestamp` | ya | — | `$table->timestamps()` · [2025_12_11_150000_create_order_reviews_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_11_150000_create_order_reviews_table.php#L22) |
| `moderation_status` | `string(20)` | tidak | — | `$table->string('moderation_status', 20)->default('approved')->after('deskripsi_ulasan')` · [2026_05_23_000001_sync_membership_voucher_and_review_moderation.php](../../../../Motifnesia-Server/database/migrations/2026_05_23_000001_sync_membership_voucher_and_review_moderation.php#L34) |
| `moderation_note` | `text` | ya | — | `$table->text('moderation_note')->nullable()->after('moderation_status')` · [2026_05_23_000001_sync_membership_voucher_and_review_moderation.php](../../../../Motifnesia-Server/database/migrations/2026_05_23_000001_sync_membership_voucher_and_review_moderation.php#L38) |
| `moderated_at` | `timestamp` | ya | — | `$table->timestamp('moderated_at')->nullable()->after('moderation_note')` · [2026_05_23_000001_sync_membership_voucher_and_review_moderation.php](../../../../Motifnesia-Server/database/migrations/2026_05_23_000001_sync_membership_voucher_and_review_moderation.php#L42) |
| `moderated_by` | `foreignId` | ya | FK | `$table->foreignId('moderated_by')->nullable()->after('moderated_at')->constrained('users')->nullOnDelete()` · [2026_05_23_000001_sync_membership_voucher_and_review_moderation.php](../../../../Motifnesia-Server/database/migrations/2026_05_23_000001_sync_membership_voucher_and_review_moderation.php#L46) |

Indeks/constraint tambahan. `index(['user_id', 'produk_id'])` [migration](../../../../Motifnesia-Server/database/migrations/2025_12_11_150000_create_order_reviews_table.php#L28), `index('order_item_id')` [migration](../../../../Motifnesia-Server/database/migrations/2025_12_11_150000_create_order_reviews_table.php#L29)

### checkout

Model. [Checkout](../../../../Motifnesia-Server/app/Models/Checkout.php#L7)

| Kolom | Blueprint | Null | Kunci | Definisi dan bukti |
| --- | --- | --- | --- | --- |
| `id` | `increments` | tidak | PK | `$table->increments('id')` · [2025_12_11_140000_create_checkout_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_11_140000_create_checkout_table.php#L12) |
| `user_id` | `foreignId` | tidak | FK | `$table->foreignId('user_id')->constrained('users')->onDelete('cascade')` · [2025_12_11_140000_create_checkout_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_11_140000_create_checkout_table.php#L13) |
| `alamat` | `text` | tidak | — | `$table->text('alamat')` · [2025_12_11_140000_create_checkout_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_11_140000_create_checkout_table.php#L14) |
| `pengiriman` | `string(20)` | tidak | — | `$table->string('pengiriman', 20)` · [2025_12_11_140000_create_checkout_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_11_140000_create_checkout_table.php#L15) |
| `pembayaran` | `string(30)` | tidak | — | `$table->string('pembayaran', 30)` · [2025_12_11_140000_create_checkout_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_11_140000_create_checkout_table.php#L16) |
| `total_harga` | `decimal(12, 2)` | tidak | — | `$table->decimal('total_harga', 12, 2)` · [2025_12_11_140000_create_checkout_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_11_140000_create_checkout_table.php#L17) |
| `ongkir` | `decimal(12, 2)` | tidak | — | `$table->decimal('ongkir', 12, 2)` · [2025_12_11_140000_create_checkout_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_11_140000_create_checkout_table.php#L18) |
| `total_bayar` | `decimal(12, 2)` | tidak | — | `$table->decimal('total_bayar', 12, 2)` · [2025_12_11_140000_create_checkout_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_11_140000_create_checkout_table.php#L19) |
| `status_id` | `unsignedInteger` | tidak | FK | `$table->unsignedInteger('status_id')->default(1)` · [2025_12_11_140000_create_checkout_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_11_140000_create_checkout_table.php#L20) |
| `created_at` | `timestamp` | tidak | — | `$table->timestamp('created_at')->useCurrent()` · [2025_12_11_140000_create_checkout_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_11_140000_create_checkout_table.php#L21) |

### checkout_items

Model. [CheckoutItem](../../../../Motifnesia-Server/app/Models/CheckoutItem.php#L8)

| Kolom | Blueprint | Null | Kunci | Definisi dan bukti |
| --- | --- | --- | --- | --- |
| `id` | `increments` | tidak | PK | `$table->increments('id')` · [2025_12_11_140001_create_checkout_items_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_11_140001_create_checkout_items_table.php#L12) |
| `checkout_id` | `unsignedInteger` | tidak | FK | `$table->unsignedInteger('checkout_id')` · [2025_12_11_140001_create_checkout_items_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_11_140001_create_checkout_items_table.php#L13) |
| `product_id` | `unsignedInteger` | tidak | FK | `$table->unsignedInteger('product_id')` · [2025_12_11_140001_create_checkout_items_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_11_140001_create_checkout_items_table.php#L14) |
| `ukuran` | `string(10)` | tidak | — | `$table->string('ukuran', 10)` · [2025_12_11_140001_create_checkout_items_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_11_140001_create_checkout_items_table.php#L15) |
| `qty` | `integer` | tidak | — | `$table->integer('qty')` · [2025_12_11_140001_create_checkout_items_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_11_140001_create_checkout_items_table.php#L16) |
| `harga_satuan` | `decimal(12, 2)` | tidak | — | `$table->decimal('harga_satuan', 12, 2)` · [2025_12_11_140001_create_checkout_items_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_11_140001_create_checkout_items_table.php#L17) |
| `subtotal` | `decimal(12, 2)` | tidak | — | `$table->decimal('subtotal', 12, 2)` · [2025_12_11_140001_create_checkout_items_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_11_140001_create_checkout_items_table.php#L18) |

### status_transaksi

Model. [StatusTransaksi](../../../../Motifnesia-Server/app/Models/StatusTransaksi.php#L8)

| Kolom | Blueprint | Null | Kunci | Definisi dan bukti |
| --- | --- | --- | --- | --- |
| `id` | `increments` | tidak | PK | `$table->increments('id')` · [2025_12_11_135959_create_status_transaksi_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_11_135959_create_status_transaksi_table.php#L12) |
| `nama_status` | `string(20)` | tidak | — | `$table->string('nama_status', 20)` · [2025_12_11_135959_create_status_transaksi_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_11_135959_create_status_transaksi_table.php#L13) |
| `keterangan` | `string(100)` | ya | — | `$table->string('keterangan', 100)->nullable()` · [2025_12_11_135959_create_status_transaksi_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_11_135959_create_status_transaksi_table.php#L14) |

## Persediaan dan pengadaan

### suppliers

Model. [Supplier](../../../../Motifnesia-Server/app/Models/Supplier.php#L8)

| Kolom | Blueprint | Null | Kunci | Definisi dan bukti |
| --- | --- | --- | --- | --- |
| `id` | `id` | tidak | PK | `$table->id()` · [2026_06_11_000001_create_supply_chain_tables.php](../../../../Motifnesia-Server/database/migrations/2026_06_11_000001_create_supply_chain_tables.php#L14) |
| `user_id` | `foreignId` | ya | FK | `$table->foreignId('user_id')->nullable()->constrained('users')->nullOnDelete()` · [2026_06_11_000001_create_supply_chain_tables.php](../../../../Motifnesia-Server/database/migrations/2026_06_11_000001_create_supply_chain_tables.php#L15) |
| `name` | `string` | tidak | — | `$table->string('name')` · [2026_06_11_000001_create_supply_chain_tables.php](../../../../Motifnesia-Server/database/migrations/2026_06_11_000001_create_supply_chain_tables.php#L16) |
| `contact_person` | `string` | ya | — | `$table->string('contact_person')->nullable()` · [2026_06_11_000001_create_supply_chain_tables.php](../../../../Motifnesia-Server/database/migrations/2026_06_11_000001_create_supply_chain_tables.php#L17) |
| `email` | `string` | ya | — | `$table->string('email')->nullable()` · [2026_06_11_000001_create_supply_chain_tables.php](../../../../Motifnesia-Server/database/migrations/2026_06_11_000001_create_supply_chain_tables.php#L18) |
| `phone` | `string` | ya | — | `$table->string('phone')->nullable()` · [2026_06_11_000001_create_supply_chain_tables.php](../../../../Motifnesia-Server/database/migrations/2026_06_11_000001_create_supply_chain_tables.php#L19) |
| `address` | `text` | ya | — | `$table->text('address')->nullable()` · [2026_06_11_000001_create_supply_chain_tables.php](../../../../Motifnesia-Server/database/migrations/2026_06_11_000001_create_supply_chain_tables.php#L20) |
| `status` | `string(30)` | tidak | — | `$table->string('status', 30)->default('active')` · [2026_06_11_000001_create_supply_chain_tables.php](../../../../Motifnesia-Server/database/migrations/2026_06_11_000001_create_supply_chain_tables.php#L21) |
| `notes` | `text` | ya | — | `$table->text('notes')->nullable()` · [2026_06_11_000001_create_supply_chain_tables.php](../../../../Motifnesia-Server/database/migrations/2026_06_11_000001_create_supply_chain_tables.php#L22) |
| `created_at` | `timestamp` | ya | — | `$table->timestamps()` · [2026_06_11_000001_create_supply_chain_tables.php](../../../../Motifnesia-Server/database/migrations/2026_06_11_000001_create_supply_chain_tables.php#L23) |
| `updated_at` | `timestamp` | ya | — | `$table->timestamps()` · [2026_06_11_000001_create_supply_chain_tables.php](../../../../Motifnesia-Server/database/migrations/2026_06_11_000001_create_supply_chain_tables.php#L23) |

Indeks/constraint tambahan. `index(['status', 'name'])` [migration](../../../../Motifnesia-Server/database/migrations/2026_06_11_000001_create_supply_chain_tables.php#L25)

### stock_procurements

Model. [StockProcurement](../../../../Motifnesia-Server/app/Models/StockProcurement.php#L8)

| Kolom | Blueprint | Null | Kunci | Definisi dan bukti |
| --- | --- | --- | --- | --- |
| `id` | `id` | tidak | PK | `$table->id()` · [2026_06_11_000001_create_supply_chain_tables.php](../../../../Motifnesia-Server/database/migrations/2026_06_11_000001_create_supply_chain_tables.php#L31) |
| `procurement_number` | `string` | tidak | UK | `$table->string('procurement_number')->unique()` · [2026_06_11_000001_create_supply_chain_tables.php](../../../../Motifnesia-Server/database/migrations/2026_06_11_000001_create_supply_chain_tables.php#L32) |
| `supplier_id` | `foreignId` | ya | FK | `$table->foreignId('supplier_id')->nullable()->constrained('suppliers')->nullOnDelete()` · [2026_06_11_000001_create_supply_chain_tables.php](../../../../Motifnesia-Server/database/migrations/2026_06_11_000001_create_supply_chain_tables.php#L33) |
| `created_by` | `foreignId` | ya | FK | `$table->foreignId('created_by')->nullable()->constrained('users')->nullOnDelete()` · [2026_06_11_000001_create_supply_chain_tables.php](../../../../Motifnesia-Server/database/migrations/2026_06_11_000001_create_supply_chain_tables.php#L34) |
| `confirmed_by` | `foreignId` | ya | FK | `$table->foreignId('confirmed_by')->nullable()->constrained('users')->nullOnDelete()` · [2026_06_11_000001_create_supply_chain_tables.php](../../../../Motifnesia-Server/database/migrations/2026_06_11_000001_create_supply_chain_tables.php#L35) |
| `applied_by` | `foreignId` | ya | FK | `$table->foreignId('applied_by')->nullable()->constrained('users')->nullOnDelete()` · [2026_06_11_000001_create_supply_chain_tables.php](../../../../Motifnesia-Server/database/migrations/2026_06_11_000001_create_supply_chain_tables.php#L36) |
| `status` | `string(40)` | tidak | — | `$table->string('status', 40)->default('pending')` · [2026_06_11_000001_create_supply_chain_tables.php](../../../../Motifnesia-Server/database/migrations/2026_06_11_000001_create_supply_chain_tables.php#L37) |
| `note` | `text` | ya | — | `$table->text('note')->nullable()` · [2026_06_11_000001_create_supply_chain_tables.php](../../../../Motifnesia-Server/database/migrations/2026_06_11_000001_create_supply_chain_tables.php#L38) |
| `approved_at` | `timestamp` | ya | — | `$table->timestamp('approved_at')->nullable()` · [2026_06_11_000001_create_supply_chain_tables.php](../../../../Motifnesia-Server/database/migrations/2026_06_11_000001_create_supply_chain_tables.php#L39) |
| `in_delivery_at` | `timestamp` | ya | — | `$table->timestamp('in_delivery_at')->nullable()` · [2026_06_11_000001_create_supply_chain_tables.php](../../../../Motifnesia-Server/database/migrations/2026_06_11_000001_create_supply_chain_tables.php#L40) |
| `arrived_at` | `timestamp` | ya | — | `$table->timestamp('arrived_at')->nullable()` · [2026_06_11_000001_create_supply_chain_tables.php](../../../../Motifnesia-Server/database/migrations/2026_06_11_000001_create_supply_chain_tables.php#L41) |
| `stock_applied_at` | `timestamp` | ya | — | `$table->timestamp('stock_applied_at')->nullable()` · [2026_06_11_000001_create_supply_chain_tables.php](../../../../Motifnesia-Server/database/migrations/2026_06_11_000001_create_supply_chain_tables.php#L42) |
| `created_at` | `timestamp` | ya | — | `$table->timestamps()` · [2026_06_11_000001_create_supply_chain_tables.php](../../../../Motifnesia-Server/database/migrations/2026_06_11_000001_create_supply_chain_tables.php#L43) |
| `updated_at` | `timestamp` | ya | — | `$table->timestamps()` · [2026_06_11_000001_create_supply_chain_tables.php](../../../../Motifnesia-Server/database/migrations/2026_06_11_000001_create_supply_chain_tables.php#L43) |

Indeks/constraint tambahan. `index(['status', 'created_at'])` [migration](../../../../Motifnesia-Server/database/migrations/2026_06_11_000001_create_supply_chain_tables.php#L45)

### stock_procurement_items

Model. [StockProcurementItem](../../../../Motifnesia-Server/app/Models/StockProcurementItem.php#L8)

| Kolom | Blueprint | Null | Kunci | Definisi dan bukti |
| --- | --- | --- | --- | --- |
| `id` | `id` | tidak | PK | `$table->id()` · [2026_06_11_000001_create_supply_chain_tables.php](../../../../Motifnesia-Server/database/migrations/2026_06_11_000001_create_supply_chain_tables.php#L51) |
| `stock_procurement_id` | `foreignId` | tidak | FK | `$table->foreignId('stock_procurement_id')->constrained('stock_procurements')->cascadeOnDelete()` · [2026_06_11_000001_create_supply_chain_tables.php](../../../../Motifnesia-Server/database/migrations/2026_06_11_000001_create_supply_chain_tables.php#L52) |
| `produk_id` | `unsignedInteger` | tidak | FK | `$table->unsignedInteger('produk_id')` · [2026_06_11_000001_create_supply_chain_tables.php](../../../../Motifnesia-Server/database/migrations/2026_06_11_000001_create_supply_chain_tables.php#L53) |
| `qty_s` | `unsignedInteger` | tidak | — | `$table->unsignedInteger('qty_s')->default(0)` · [2026_06_11_000001_create_supply_chain_tables.php](../../../../Motifnesia-Server/database/migrations/2026_06_11_000001_create_supply_chain_tables.php#L54) |
| `qty_m` | `unsignedInteger` | tidak | — | `$table->unsignedInteger('qty_m')->default(0)` · [2026_06_11_000001_create_supply_chain_tables.php](../../../../Motifnesia-Server/database/migrations/2026_06_11_000001_create_supply_chain_tables.php#L55) |
| `qty_l` | `unsignedInteger` | tidak | — | `$table->unsignedInteger('qty_l')->default(0)` · [2026_06_11_000001_create_supply_chain_tables.php](../../../../Motifnesia-Server/database/migrations/2026_06_11_000001_create_supply_chain_tables.php#L56) |
| `qty_xl` | `unsignedInteger` | tidak | — | `$table->unsignedInteger('qty_xl')->default(0)` · [2026_06_11_000001_create_supply_chain_tables.php](../../../../Motifnesia-Server/database/migrations/2026_06_11_000001_create_supply_chain_tables.php#L57) |
| `total_qty` | `unsignedInteger` | tidak | — | `$table->unsignedInteger('total_qty')->default(0)` · [2026_06_11_000001_create_supply_chain_tables.php](../../../../Motifnesia-Server/database/migrations/2026_06_11_000001_create_supply_chain_tables.php#L58) |
| `created_at` | `timestamp` | ya | — | `$table->timestamps()` · [2026_06_11_000001_create_supply_chain_tables.php](../../../../Motifnesia-Server/database/migrations/2026_06_11_000001_create_supply_chain_tables.php#L59) |
| `updated_at` | `timestamp` | ya | — | `$table->timestamps()` · [2026_06_11_000001_create_supply_chain_tables.php](../../../../Motifnesia-Server/database/migrations/2026_06_11_000001_create_supply_chain_tables.php#L59) |

Indeks/constraint tambahan. `unique(['stock_procurement_id', 'produk_id'])` [migration](../../../../Motifnesia-Server/database/migrations/2026_06_11_000001_create_supply_chain_tables.php#L62), `index(['produk_id'])` [migration](../../../../Motifnesia-Server/database/migrations/2026_06_11_000001_create_supply_chain_tables.php#L63)

### warehouse_stocks

Model. [WarehouseStock](../../../../Motifnesia-Server/app/Models/WarehouseStock.php#L8)

| Kolom | Blueprint | Null | Kunci | Definisi dan bukti |
| --- | --- | --- | --- | --- |
| `id` | `id` | tidak | PK | `$table->id()` · [2026_06_11_000001_create_supply_chain_tables.php](../../../../Motifnesia-Server/database/migrations/2026_06_11_000001_create_supply_chain_tables.php#L69) |
| `produk_id` | `unsignedInteger` | tidak | FK | `$table->unsignedInteger('produk_id')` · [2026_06_11_000001_create_supply_chain_tables.php](../../../../Motifnesia-Server/database/migrations/2026_06_11_000001_create_supply_chain_tables.php#L70) |
| `ukuran` | `string(20)` | tidak | — | `$table->string('ukuran', 20)` · [2026_06_11_000001_create_supply_chain_tables.php](../../../../Motifnesia-Server/database/migrations/2026_06_11_000001_create_supply_chain_tables.php#L71) |
| `stok` | `unsignedInteger` | tidak | — | `$table->unsignedInteger('stok')->default(0)` · [2026_06_11_000001_create_supply_chain_tables.php](../../../../Motifnesia-Server/database/migrations/2026_06_11_000001_create_supply_chain_tables.php#L72) |
| `updated_by` | `foreignId` | ya | FK | `$table->foreignId('updated_by')->nullable()->constrained('users')->nullOnDelete()` · [2026_06_11_000001_create_supply_chain_tables.php](../../../../Motifnesia-Server/database/migrations/2026_06_11_000001_create_supply_chain_tables.php#L73) |
| `created_at` | `timestamp` | ya | — | `$table->timestamps()` · [2026_06_11_000001_create_supply_chain_tables.php](../../../../Motifnesia-Server/database/migrations/2026_06_11_000001_create_supply_chain_tables.php#L74) |
| `updated_at` | `timestamp` | ya | — | `$table->timestamps()` · [2026_06_11_000001_create_supply_chain_tables.php](../../../../Motifnesia-Server/database/migrations/2026_06_11_000001_create_supply_chain_tables.php#L74) |

Indeks/constraint tambahan. `unique(['produk_id', 'ukuran'])` [migration](../../../../Motifnesia-Server/database/migrations/2026_06_11_000001_create_supply_chain_tables.php#L77), `index(['produk_id', 'stok'])` [migration](../../../../Motifnesia-Server/database/migrations/2026_06_11_000001_create_supply_chain_tables.php#L78)

### stock_movements

Model. [StockMovement](../../../../Motifnesia-Server/app/Models/StockMovement.php#L8)

| Kolom | Blueprint | Null | Kunci | Definisi dan bukti |
| --- | --- | --- | --- | --- |
| `id` | `id` | tidak | PK | `$table->id()` · [2026_06_11_000001_create_supply_chain_tables.php](../../../../Motifnesia-Server/database/migrations/2026_06_11_000001_create_supply_chain_tables.php#L108) |
| `produk_id` | `unsignedInteger` | tidak | FK | `$table->unsignedInteger('produk_id')` · [2026_06_11_000001_create_supply_chain_tables.php](../../../../Motifnesia-Server/database/migrations/2026_06_11_000001_create_supply_chain_tables.php#L109) |
| `ukuran` | `string(20)` | tidak | — | `$table->string('ukuran', 20)` · [2026_06_11_000001_create_supply_chain_tables.php](../../../../Motifnesia-Server/database/migrations/2026_06_11_000001_create_supply_chain_tables.php#L110) |
| `movement_type` | `string(40)` | tidak | — | `$table->string('movement_type', 40)` · [2026_06_11_000001_create_supply_chain_tables.php](../../../../Motifnesia-Server/database/migrations/2026_06_11_000001_create_supply_chain_tables.php#L111) |
| `reference_type` | `string` | ya | — | `$table->string('reference_type')->nullable()` · [2026_06_11_000001_create_supply_chain_tables.php](../../../../Motifnesia-Server/database/migrations/2026_06_11_000001_create_supply_chain_tables.php#L112) |
| `reference_id` | `unsignedBigInteger` | ya | — | `$table->unsignedBigInteger('reference_id')->nullable()` · [2026_06_11_000001_create_supply_chain_tables.php](../../../../Motifnesia-Server/database/migrations/2026_06_11_000001_create_supply_chain_tables.php#L113) |
| `qty_change` | `integer` | tidak | — | `$table->integer('qty_change')->default(0)` · [2026_06_11_000001_create_supply_chain_tables.php](../../../../Motifnesia-Server/database/migrations/2026_06_11_000001_create_supply_chain_tables.php#L114) |
| `system_stock_before` | `integer` | tidak | — | `$table->integer('system_stock_before')->default(0)` · [2026_06_11_000001_create_supply_chain_tables.php](../../../../Motifnesia-Server/database/migrations/2026_06_11_000001_create_supply_chain_tables.php#L115) |
| `system_stock_after` | `integer` | tidak | — | `$table->integer('system_stock_after')->default(0)` · [2026_06_11_000001_create_supply_chain_tables.php](../../../../Motifnesia-Server/database/migrations/2026_06_11_000001_create_supply_chain_tables.php#L116) |
| `warehouse_stock_before` | `integer` | tidak | — | `$table->integer('warehouse_stock_before')->default(0)` · [2026_06_11_000001_create_supply_chain_tables.php](../../../../Motifnesia-Server/database/migrations/2026_06_11_000001_create_supply_chain_tables.php#L117) |
| `warehouse_stock_after` | `integer` | tidak | — | `$table->integer('warehouse_stock_after')->default(0)` · [2026_06_11_000001_create_supply_chain_tables.php](../../../../Motifnesia-Server/database/migrations/2026_06_11_000001_create_supply_chain_tables.php#L118) |
| `user_id` | `foreignId` | ya | FK | `$table->foreignId('user_id')->nullable()->constrained('users')->nullOnDelete()` · [2026_06_11_000001_create_supply_chain_tables.php](../../../../Motifnesia-Server/database/migrations/2026_06_11_000001_create_supply_chain_tables.php#L119) |
| `note` | `text` | ya | — | `$table->text('note')->nullable()` · [2026_06_11_000001_create_supply_chain_tables.php](../../../../Motifnesia-Server/database/migrations/2026_06_11_000001_create_supply_chain_tables.php#L120) |
| `created_at` | `timestamp` | ya | — | `$table->timestamps()` · [2026_06_11_000001_create_supply_chain_tables.php](../../../../Motifnesia-Server/database/migrations/2026_06_11_000001_create_supply_chain_tables.php#L121) |
| `updated_at` | `timestamp` | ya | — | `$table->timestamps()` · [2026_06_11_000001_create_supply_chain_tables.php](../../../../Motifnesia-Server/database/migrations/2026_06_11_000001_create_supply_chain_tables.php#L121) |

Indeks/constraint tambahan. `index(['produk_id', 'ukuran', 'created_at'])` [migration](../../../../Motifnesia-Server/database/migrations/2026_06_11_000001_create_supply_chain_tables.php#L124), `index(['reference_type', 'reference_id'])` [migration](../../../../Motifnesia-Server/database/migrations/2026_06_11_000001_create_supply_chain_tables.php#L125)

### stock_opnames

Model. [StockOpname](../../../../Motifnesia-Server/app/Models/StockOpname.php#L8)

| Kolom | Blueprint | Null | Kunci | Definisi dan bukti |
| --- | --- | --- | --- | --- |
| `id` | `id` | tidak | PK | `$table->id()` · [2026_06_11_000001_create_supply_chain_tables.php](../../../../Motifnesia-Server/database/migrations/2026_06_11_000001_create_supply_chain_tables.php#L131) |
| `opname_number` | `string` | tidak | UK | `$table->string('opname_number')->unique()` · [2026_06_11_000001_create_supply_chain_tables.php](../../../../Motifnesia-Server/database/migrations/2026_06_11_000001_create_supply_chain_tables.php#L132) |
| `produk_id` | `unsignedInteger` | tidak | FK | `$table->unsignedInteger('produk_id')` · [2026_06_11_000001_create_supply_chain_tables.php](../../../../Motifnesia-Server/database/migrations/2026_06_11_000001_create_supply_chain_tables.php#L133) |
| `ukuran` | `string(20)` | tidak | — | `$table->string('ukuran', 20)` · [2026_06_11_000001_create_supply_chain_tables.php](../../../../Motifnesia-Server/database/migrations/2026_06_11_000001_create_supply_chain_tables.php#L134) |
| `system_stock_before` | `integer` | tidak | — | `$table->integer('system_stock_before')->default(0)` · [2026_06_11_000001_create_supply_chain_tables.php](../../../../Motifnesia-Server/database/migrations/2026_06_11_000001_create_supply_chain_tables.php#L135) |
| `warehouse_stock_before` | `integer` | tidak | — | `$table->integer('warehouse_stock_before')->default(0)` · [2026_06_11_000001_create_supply_chain_tables.php](../../../../Motifnesia-Server/database/migrations/2026_06_11_000001_create_supply_chain_tables.php#L136) |
| `system_stock_after` | `integer` | tidak | — | `$table->integer('system_stock_after')->default(0)` · [2026_06_11_000001_create_supply_chain_tables.php](../../../../Motifnesia-Server/database/migrations/2026_06_11_000001_create_supply_chain_tables.php#L137) |
| `difference` | `integer` | tidak | — | `$table->integer('difference')->default(0)` · [2026_06_11_000001_create_supply_chain_tables.php](../../../../Motifnesia-Server/database/migrations/2026_06_11_000001_create_supply_chain_tables.php#L138) |
| `adjusted_by` | `foreignId` | ya | FK | `$table->foreignId('adjusted_by')->nullable()->constrained('users')->nullOnDelete()` · [2026_06_11_000001_create_supply_chain_tables.php](../../../../Motifnesia-Server/database/migrations/2026_06_11_000001_create_supply_chain_tables.php#L139) |
| `note` | `text` | ya | — | `$table->text('note')->nullable()` · [2026_06_11_000001_create_supply_chain_tables.php](../../../../Motifnesia-Server/database/migrations/2026_06_11_000001_create_supply_chain_tables.php#L140) |
| `created_at` | `timestamp` | ya | — | `$table->timestamps()` · [2026_06_11_000001_create_supply_chain_tables.php](../../../../Motifnesia-Server/database/migrations/2026_06_11_000001_create_supply_chain_tables.php#L141) |
| `updated_at` | `timestamp` | ya | — | `$table->timestamps()` · [2026_06_11_000001_create_supply_chain_tables.php](../../../../Motifnesia-Server/database/migrations/2026_06_11_000001_create_supply_chain_tables.php#L141) |

Indeks/constraint tambahan. `index(['produk_id', 'ukuran', 'created_at'])` [migration](../../../../Motifnesia-Server/database/migrations/2026_06_11_000001_create_supply_chain_tables.php#L144)

## Membership dan komunikasi

### membership_rewards

Model. [MembershipReward](../../../../Motifnesia-Server/app/Models/MembershipReward.php#L9)

| Kolom | Blueprint | Null | Kunci | Definisi dan bukti |
| --- | --- | --- | --- | --- |
| `id` | `id` | tidak | PK | `$table->id()` · [2026_05_22_000001_create_membership_feature_tables.php](../../../../Motifnesia-Server/database/migrations/2026_05_22_000001_create_membership_feature_tables.php#L48) |
| `title` | `string` | tidak | — | `$table->string('title')` · [2026_05_22_000001_create_membership_feature_tables.php](../../../../Motifnesia-Server/database/migrations/2026_05_22_000001_create_membership_feature_tables.php#L49) |
| `description` | `text` | ya | — | `$table->text('description')->nullable()` · [2026_05_22_000001_create_membership_feature_tables.php](../../../../Motifnesia-Server/database/migrations/2026_05_22_000001_create_membership_feature_tables.php#L50) |
| `points_required` | `integer` | tidak | — | `$table->integer('points_required')` · [2026_05_22_000001_create_membership_feature_tables.php](../../../../Motifnesia-Server/database/migrations/2026_05_22_000001_create_membership_feature_tables.php#L51) |
| `discount_type` | `string(30)` | tidak | — | `$table->string('discount_type', 30)` · [2026_05_22_000001_create_membership_feature_tables.php](../../../../Motifnesia-Server/database/migrations/2026_05_22_000001_create_membership_feature_tables.php#L52) |
| `discount_value` | `integer` | tidak | — | `$table->integer('discount_value')->default(0)` · [2026_05_22_000001_create_membership_feature_tables.php](../../../../Motifnesia-Server/database/migrations/2026_05_22_000001_create_membership_feature_tables.php#L53) |
| `is_active` | `boolean` | tidak | — | `$table->boolean('is_active')->default(true)` · [2026_05_22_000001_create_membership_feature_tables.php](../../../../Motifnesia-Server/database/migrations/2026_05_22_000001_create_membership_feature_tables.php#L54) |
| `created_at` | `timestamp` | ya | — | `$table->timestamps()` · [2026_05_22_000001_create_membership_feature_tables.php](../../../../Motifnesia-Server/database/migrations/2026_05_22_000001_create_membership_feature_tables.php#L55) |
| `updated_at` | `timestamp` | ya | — | `$table->timestamps()` · [2026_05_22_000001_create_membership_feature_tables.php](../../../../Motifnesia-Server/database/migrations/2026_05_22_000001_create_membership_feature_tables.php#L55) |
| `max_discount_value` | `decimal(12, 2)` | ya | — | `$table->decimal('max_discount_value', 12, 2)->nullable()->after('discount_value')` · [2026_06_08_083427_add_max_discount_value_to_membership_rewards_table.php](../../../../Motifnesia-Server/database/migrations/2026_06_08_083427_add_max_discount_value_to_membership_rewards_table.php#L15) |

Indeks/constraint tambahan. `index(['is_active', 'points_required'])` [migration](../../../../Motifnesia-Server/database/migrations/2026_05_22_000001_create_membership_feature_tables.php#L57)

### user_reward_redemptions

Model. [UserRewardRedemption](../../../../Motifnesia-Server/app/Models/UserRewardRedemption.php#L8)

| Kolom | Blueprint | Null | Kunci | Definisi dan bukti |
| --- | --- | --- | --- | --- |
| `id` | `id` | tidak | PK | `$table->id()` · [2026_05_22_000001_create_membership_feature_tables.php](../../../../Motifnesia-Server/database/migrations/2026_05_22_000001_create_membership_feature_tables.php#L63) |
| `user_id` | `foreignId` | tidak | FK | `$table->foreignId('user_id')->constrained('users')->onDelete('cascade')` · [2026_05_22_000001_create_membership_feature_tables.php](../../../../Motifnesia-Server/database/migrations/2026_05_22_000001_create_membership_feature_tables.php#L64) |
| `reward_id` | `foreignId` | tidak | FK | `$table->foreignId('reward_id')->constrained('membership_rewards')->onDelete('cascade')` · [2026_05_22_000001_create_membership_feature_tables.php](../../../../Motifnesia-Server/database/migrations/2026_05_22_000001_create_membership_feature_tables.php#L65) |
| `voucher_code` | `string` | tidak | UK | `$table->string('voucher_code')->unique()` · [2026_05_22_000001_create_membership_feature_tables.php](../../../../Motifnesia-Server/database/migrations/2026_05_22_000001_create_membership_feature_tables.php#L66) |
| `points_used` | `integer` | tidak | — | `$table->integer('points_used')` · [2026_05_22_000001_create_membership_feature_tables.php](../../../../Motifnesia-Server/database/migrations/2026_05_22_000001_create_membership_feature_tables.php#L67) |
| `status` | `string(20)` | tidak | — | `$table->string('status', 20)->default('active')` · [2026_05_22_000001_create_membership_feature_tables.php](../../../../Motifnesia-Server/database/migrations/2026_05_22_000001_create_membership_feature_tables.php#L68) |
| `redeemed_at` | `timestamp` | ya | — | `$table->timestamp('redeemed_at')->nullable()` · [2026_05_22_000001_create_membership_feature_tables.php](../../../../Motifnesia-Server/database/migrations/2026_05_22_000001_create_membership_feature_tables.php#L69) |
| `used_at` | `timestamp` | ya | — | `$table->timestamp('used_at')->nullable()` · [2026_05_22_000001_create_membership_feature_tables.php](../../../../Motifnesia-Server/database/migrations/2026_05_22_000001_create_membership_feature_tables.php#L70) |
| `created_at` | `timestamp` | ya | — | `$table->timestamps()` · [2026_05_22_000001_create_membership_feature_tables.php](../../../../Motifnesia-Server/database/migrations/2026_05_22_000001_create_membership_feature_tables.php#L71) |
| `updated_at` | `timestamp` | ya | — | `$table->timestamps()` · [2026_05_22_000001_create_membership_feature_tables.php](../../../../Motifnesia-Server/database/migrations/2026_05_22_000001_create_membership_feature_tables.php#L71) |

Indeks/constraint tambahan. `index(['user_id', 'status'])` [migration](../../../../Motifnesia-Server/database/migrations/2026_05_22_000001_create_membership_feature_tables.php#L73)

### point_transactions

Model. [PointTransaction](../../../../Motifnesia-Server/app/Models/PointTransaction.php#L8)

| Kolom | Blueprint | Null | Kunci | Definisi dan bukti |
| --- | --- | --- | --- | --- |
| `id` | `id` | tidak | PK | `$table->id()` · [2026_05_22_000001_create_membership_feature_tables.php](../../../../Motifnesia-Server/database/migrations/2026_05_22_000001_create_membership_feature_tables.php#L33) |
| `user_id` | `foreignId` | tidak | FK | `$table->foreignId('user_id')->constrained('users')->onDelete('cascade')` · [2026_05_22_000001_create_membership_feature_tables.php](../../../../Motifnesia-Server/database/migrations/2026_05_22_000001_create_membership_feature_tables.php#L34) |
| `order_id` | `foreignId` | ya | FK | `$table->foreignId('order_id')->nullable()->constrained('orders')->nullOnDelete()` · [2026_05_22_000001_create_membership_feature_tables.php](../../../../Motifnesia-Server/database/migrations/2026_05_22_000001_create_membership_feature_tables.php#L35) |
| `type` | `string(20)` | tidak | — | `$table->string('type', 20)` · [2026_05_22_000001_create_membership_feature_tables.php](../../../../Motifnesia-Server/database/migrations/2026_05_22_000001_create_membership_feature_tables.php#L36) |
| `points` | `integer` | tidak | — | `$table->integer('points')` · [2026_05_22_000001_create_membership_feature_tables.php](../../../../Motifnesia-Server/database/migrations/2026_05_22_000001_create_membership_feature_tables.php#L37) |
| `description` | `text` | ya | — | `$table->text('description')->nullable()` · [2026_05_22_000001_create_membership_feature_tables.php](../../../../Motifnesia-Server/database/migrations/2026_05_22_000001_create_membership_feature_tables.php#L38) |
| `created_at` | `timestamp` | ya | — | `$table->timestamps()` · [2026_05_22_000001_create_membership_feature_tables.php](../../../../Motifnesia-Server/database/migrations/2026_05_22_000001_create_membership_feature_tables.php#L39) |
| `updated_at` | `timestamp` | ya | — | `$table->timestamps()` · [2026_05_22_000001_create_membership_feature_tables.php](../../../../Motifnesia-Server/database/migrations/2026_05_22_000001_create_membership_feature_tables.php#L39) |

Indeks/constraint tambahan. `index(['user_id', 'type'])` [migration](../../../../Motifnesia-Server/database/migrations/2026_05_22_000001_create_membership_feature_tables.php#L41), `index(['order_id', 'type'])` [migration](../../../../Motifnesia-Server/database/migrations/2026_05_22_000001_create_membership_feature_tables.php#L42)

### notifications

Model. [Notification](../../../../Motifnesia-Server/app/Models/Notification.php#L8)

| Kolom | Blueprint | Null | Kunci | Definisi dan bukti |
| --- | --- | --- | --- | --- |
| `id` | `id` | tidak | PK | `$table->id()` · [2025_12_12_000001_create_notifications_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_12_000001_create_notifications_table.php#L12) |
| `user_id` | `foreignId` | ya | FK | `$table->foreignId('user_id')->nullable()->constrained('users')->onDelete('cascade')` · [2025_12_12_000001_create_notifications_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_12_000001_create_notifications_table.php#L13) |
| `type` | `string(50)` | tidak | — | `$table->string('type', 50)->default('system')->change()` · [2026_05_21_000001_normalize_notifications_type_and_data.php](../../../../Motifnesia-Server/database/migrations/2026_05_21_000001_normalize_notifications_type_and_data.php#L22) |
| `title` | `string` | tidak | — | `$table->string('title')` · [2025_12_12_000001_create_notifications_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_12_000001_create_notifications_table.php#L15) |
| `message` | `text` | tidak | — | `$table->text('message')` · [2025_12_12_000001_create_notifications_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_12_000001_create_notifications_table.php#L16) |
| `link` | `string` | ya | — | `$table->string('link')->nullable()` · [2025_12_12_000001_create_notifications_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_12_000001_create_notifications_table.php#L17) |
| `priority` | `enum(['urgent', 'important', 'info', 'normal'])` | tidak | — | `$table->enum('priority', ['urgent', 'important', 'info', 'normal'])->default('normal')` · [2025_12_12_000001_create_notifications_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_12_000001_create_notifications_table.php#L18) |
| `is_read` | `boolean` | tidak | — | `$table->boolean('is_read')->default(false)` · [2025_12_12_000001_create_notifications_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_12_000001_create_notifications_table.php#L19) |
| `created_at` | `timestamp` | ya | — | `$table->timestamps()` · [2025_12_12_000001_create_notifications_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_12_000001_create_notifications_table.php#L20) |
| `updated_at` | `timestamp` | ya | — | `$table->timestamps()` · [2025_12_12_000001_create_notifications_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_12_000001_create_notifications_table.php#L20) |
| `data` | `json` | ya | — | `$table->json('data')->nullable()->after('is_read')` · [2026_05_21_000001_normalize_notifications_type_and_data.php](../../../../Motifnesia-Server/database/migrations/2026_05_21_000001_normalize_notifications_type_and_data.php#L28) |

Indeks/constraint tambahan. `index(['user_id', 'is_read'])` [migration](../../../../Motifnesia-Server/database/migrations/2025_12_12_000001_create_notifications_table.php#L22), `index('created_at')` [migration](../../../../Motifnesia-Server/database/migrations/2025_12_12_000001_create_notifications_table.php#L23)

### chats

Model. [Chat](../../../../Motifnesia-Server/app/Models/Chat.php#L8)

| Kolom | Blueprint | Null | Kunci | Definisi dan bukti |
| --- | --- | --- | --- | --- |
| `id` | `id` | tidak | PK | `$table->id()` · [2025_12_27_031318_create_chats_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_27_031318_create_chats_table.php#L15) |
| `user_id` | `foreignId` | tidak | FK | `$table->foreignId('user_id')->constrained('users')->onDelete('cascade')` · [2025_12_27_031318_create_chats_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_27_031318_create_chats_table.php#L16) |
| `admin_id` | `foreignId` | ya | FK | `$table->foreignId('admin_id')->nullable()->constrained('users')->onDelete('set null')` · [2025_12_27_031318_create_chats_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_27_031318_create_chats_table.php#L17) |
| `subject` | `string` | ya | — | `$table->string('subject')->nullable()` · [2025_12_27_031318_create_chats_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_27_031318_create_chats_table.php#L18) |
| `status` | `enum(['active', 'closed'])` | tidak | — | `$table->enum('status', ['active', 'closed'])->default('active')` · [2025_12_27_031318_create_chats_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_27_031318_create_chats_table.php#L19) |
| `last_message_at` | `timestamp` | ya | — | `$table->timestamp('last_message_at')->nullable()` · [2025_12_27_031318_create_chats_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_27_031318_create_chats_table.php#L20) |
| `created_at` | `timestamp` | ya | — | `$table->timestamps()` · [2025_12_27_031318_create_chats_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_27_031318_create_chats_table.php#L21) |
| `updated_at` | `timestamp` | ya | — | `$table->timestamps()` · [2025_12_27_031318_create_chats_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_27_031318_create_chats_table.php#L21) |

Indeks/constraint tambahan. `index(['user_id', 'status'])` [migration](../../../../Motifnesia-Server/database/migrations/2025_12_27_031318_create_chats_table.php#L23)

### chat_messages

Model. [ChatMessage](../../../../Motifnesia-Server/app/Models/ChatMessage.php#L8)

| Kolom | Blueprint | Null | Kunci | Definisi dan bukti |
| --- | --- | --- | --- | --- |
| `id` | `id` | tidak | PK | `$table->id()` · [2025_12_27_031328_create_chat_messages_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_27_031328_create_chat_messages_table.php#L15) |
| `chat_id` | `foreignId` | tidak | FK | `$table->foreignId('chat_id')->constrained('chats')->onDelete('cascade')` · [2025_12_27_031328_create_chat_messages_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_27_031328_create_chat_messages_table.php#L16) |
| `sender_id` | `foreignId` | tidak | FK | `$table->foreignId('sender_id')->constrained('users')->onDelete('cascade')` · [2025_12_27_031328_create_chat_messages_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_27_031328_create_chat_messages_table.php#L17) |
| `message` | `text` | tidak | — | `$table->text('message')` · [2025_12_27_031328_create_chat_messages_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_27_031328_create_chat_messages_table.php#L18) |
| `is_read` | `boolean` | tidak | — | `$table->boolean('is_read')->default(false)` · [2025_12_27_031328_create_chat_messages_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_27_031328_create_chat_messages_table.php#L19) |
| `created_at` | `timestamp` | ya | — | `$table->timestamps()` · [2025_12_27_031328_create_chat_messages_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_27_031328_create_chat_messages_table.php#L20) |
| `updated_at` | `timestamp` | ya | — | `$table->timestamps()` · [2025_12_27_031328_create_chat_messages_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_27_031328_create_chat_messages_table.php#L20) |

Indeks/constraint tambahan. `index(['chat_id', 'created_at'])` [migration](../../../../Motifnesia-Server/database/migrations/2025_12_27_031328_create_chat_messages_table.php#L22)

## Infrastruktur Laravel

### cache

| Kolom | Blueprint | Null | Kunci | Definisi dan bukti |
| --- | --- | --- | --- | --- |
| `key` | `string` | tidak | PK | `$table->string('key')->primary()` · [0001_01_01_000001_create_cache_table.php](../../../../Motifnesia-Server/database/migrations/0001_01_01_000001_create_cache_table.php#L15) |
| `value` | `mediumText` | tidak | — | `$table->mediumText('value')` · [0001_01_01_000001_create_cache_table.php](../../../../Motifnesia-Server/database/migrations/0001_01_01_000001_create_cache_table.php#L16) |
| `expiration` | `integer` | tidak | — | `$table->integer('expiration')` · [0001_01_01_000001_create_cache_table.php](../../../../Motifnesia-Server/database/migrations/0001_01_01_000001_create_cache_table.php#L17) |

### cache_locks

| Kolom | Blueprint | Null | Kunci | Definisi dan bukti |
| --- | --- | --- | --- | --- |
| `key` | `string` | tidak | PK | `$table->string('key')->primary()` · [0001_01_01_000001_create_cache_table.php](../../../../Motifnesia-Server/database/migrations/0001_01_01_000001_create_cache_table.php#L21) |
| `owner` | `string` | tidak | — | `$table->string('owner')` · [0001_01_01_000001_create_cache_table.php](../../../../Motifnesia-Server/database/migrations/0001_01_01_000001_create_cache_table.php#L22) |
| `expiration` | `integer` | tidak | — | `$table->integer('expiration')` · [0001_01_01_000001_create_cache_table.php](../../../../Motifnesia-Server/database/migrations/0001_01_01_000001_create_cache_table.php#L23) |

### failed_jobs

| Kolom | Blueprint | Null | Kunci | Definisi dan bukti |
| --- | --- | --- | --- | --- |
| `id` | `id` | tidak | PK | `$table->id()` · [0001_01_01_000002_create_jobs_table.php](../../../../Motifnesia-Server/database/migrations/0001_01_01_000002_create_jobs_table.php#L38) |
| `uuid` | `string` | tidak | UK | `$table->string('uuid')->unique()` · [0001_01_01_000002_create_jobs_table.php](../../../../Motifnesia-Server/database/migrations/0001_01_01_000002_create_jobs_table.php#L39) |
| `connection` | `text` | tidak | — | `$table->text('connection')` · [0001_01_01_000002_create_jobs_table.php](../../../../Motifnesia-Server/database/migrations/0001_01_01_000002_create_jobs_table.php#L40) |
| `queue` | `text` | tidak | — | `$table->text('queue')` · [0001_01_01_000002_create_jobs_table.php](../../../../Motifnesia-Server/database/migrations/0001_01_01_000002_create_jobs_table.php#L41) |
| `payload` | `longText` | tidak | — | `$table->longText('payload')` · [0001_01_01_000002_create_jobs_table.php](../../../../Motifnesia-Server/database/migrations/0001_01_01_000002_create_jobs_table.php#L42) |
| `exception` | `longText` | tidak | — | `$table->longText('exception')` · [0001_01_01_000002_create_jobs_table.php](../../../../Motifnesia-Server/database/migrations/0001_01_01_000002_create_jobs_table.php#L43) |
| `failed_at` | `timestamp` | tidak | — | `$table->timestamp('failed_at')->useCurrent()` · [0001_01_01_000002_create_jobs_table.php](../../../../Motifnesia-Server/database/migrations/0001_01_01_000002_create_jobs_table.php#L44) |

### job_batches

| Kolom | Blueprint | Null | Kunci | Definisi dan bukti |
| --- | --- | --- | --- | --- |
| `id` | `string` | tidak | PK | `$table->string('id')->primary()` · [0001_01_01_000002_create_jobs_table.php](../../../../Motifnesia-Server/database/migrations/0001_01_01_000002_create_jobs_table.php#L25) |
| `name` | `string` | tidak | — | `$table->string('name')` · [0001_01_01_000002_create_jobs_table.php](../../../../Motifnesia-Server/database/migrations/0001_01_01_000002_create_jobs_table.php#L26) |
| `total_jobs` | `integer` | tidak | — | `$table->integer('total_jobs')` · [0001_01_01_000002_create_jobs_table.php](../../../../Motifnesia-Server/database/migrations/0001_01_01_000002_create_jobs_table.php#L27) |
| `pending_jobs` | `integer` | tidak | — | `$table->integer('pending_jobs')` · [0001_01_01_000002_create_jobs_table.php](../../../../Motifnesia-Server/database/migrations/0001_01_01_000002_create_jobs_table.php#L28) |
| `failed_jobs` | `integer` | tidak | — | `$table->integer('failed_jobs')` · [0001_01_01_000002_create_jobs_table.php](../../../../Motifnesia-Server/database/migrations/0001_01_01_000002_create_jobs_table.php#L29) |
| `failed_job_ids` | `longText` | tidak | — | `$table->longText('failed_job_ids')` · [0001_01_01_000002_create_jobs_table.php](../../../../Motifnesia-Server/database/migrations/0001_01_01_000002_create_jobs_table.php#L30) |
| `options` | `mediumText` | ya | — | `$table->mediumText('options')->nullable()` · [0001_01_01_000002_create_jobs_table.php](../../../../Motifnesia-Server/database/migrations/0001_01_01_000002_create_jobs_table.php#L31) |
| `cancelled_at` | `integer` | ya | — | `$table->integer('cancelled_at')->nullable()` · [0001_01_01_000002_create_jobs_table.php](../../../../Motifnesia-Server/database/migrations/0001_01_01_000002_create_jobs_table.php#L32) |
| `created_at` | `integer` | tidak | — | `$table->integer('created_at')` · [0001_01_01_000002_create_jobs_table.php](../../../../Motifnesia-Server/database/migrations/0001_01_01_000002_create_jobs_table.php#L33) |
| `finished_at` | `integer` | ya | — | `$table->integer('finished_at')->nullable()` · [0001_01_01_000002_create_jobs_table.php](../../../../Motifnesia-Server/database/migrations/0001_01_01_000002_create_jobs_table.php#L34) |

### jobs

| Kolom | Blueprint | Null | Kunci | Definisi dan bukti |
| --- | --- | --- | --- | --- |
| `id` | `id` | tidak | PK | `$table->id()` · [0001_01_01_000002_create_jobs_table.php](../../../../Motifnesia-Server/database/migrations/0001_01_01_000002_create_jobs_table.php#L15) |
| `queue` | `string` | tidak | — | `$table->string('queue')->index()` · [0001_01_01_000002_create_jobs_table.php](../../../../Motifnesia-Server/database/migrations/0001_01_01_000002_create_jobs_table.php#L16) |
| `payload` | `longText` | tidak | — | `$table->longText('payload')` · [0001_01_01_000002_create_jobs_table.php](../../../../Motifnesia-Server/database/migrations/0001_01_01_000002_create_jobs_table.php#L17) |
| `attempts` | `unsignedTinyInteger` | tidak | — | `$table->unsignedTinyInteger('attempts')` · [0001_01_01_000002_create_jobs_table.php](../../../../Motifnesia-Server/database/migrations/0001_01_01_000002_create_jobs_table.php#L18) |
| `reserved_at` | `unsignedInteger` | ya | — | `$table->unsignedInteger('reserved_at')->nullable()` · [0001_01_01_000002_create_jobs_table.php](../../../../Motifnesia-Server/database/migrations/0001_01_01_000002_create_jobs_table.php#L19) |
| `available_at` | `unsignedInteger` | tidak | — | `$table->unsignedInteger('available_at')` · [0001_01_01_000002_create_jobs_table.php](../../../../Motifnesia-Server/database/migrations/0001_01_01_000002_create_jobs_table.php#L20) |
| `created_at` | `unsignedInteger` | tidak | — | `$table->unsignedInteger('created_at')` · [0001_01_01_000002_create_jobs_table.php](../../../../Motifnesia-Server/database/migrations/0001_01_01_000002_create_jobs_table.php#L21) |

### sessions

| Kolom | Blueprint | Null | Kunci | Definisi dan bukti |
| --- | --- | --- | --- | --- |
| `id` | `string` | tidak | PK | `$table->string('id')->primary()` · [2025_11_23_000002_create_sessions_table.php](../../../../Motifnesia-Server/database/migrations/2025_11_23_000002_create_sessions_table.php#L17) |
| `user_id` | `foreignId` | ya | — | `$table->foreignId('user_id')->nullable()->index()` · [2025_11_23_000002_create_sessions_table.php](../../../../Motifnesia-Server/database/migrations/2025_11_23_000002_create_sessions_table.php#L18) |
| `ip_address` | `string(45)` | ya | — | `$table->string('ip_address', 45)->nullable()` · [2025_11_23_000002_create_sessions_table.php](../../../../Motifnesia-Server/database/migrations/2025_11_23_000002_create_sessions_table.php#L19) |
| `user_agent` | `text` | ya | — | `$table->text('user_agent')->nullable()` · [2025_11_23_000002_create_sessions_table.php](../../../../Motifnesia-Server/database/migrations/2025_11_23_000002_create_sessions_table.php#L20) |
| `payload` | `text` | tidak | — | `$table->text('payload')` · [2025_11_23_000002_create_sessions_table.php](../../../../Motifnesia-Server/database/migrations/2025_11_23_000002_create_sessions_table.php#L21) |
| `last_activity` | `integer` | tidak | — | `$table->integer('last_activity')->index()` · [2025_11_23_000002_create_sessions_table.php](../../../../Motifnesia-Server/database/migrations/2025_11_23_000002_create_sessions_table.php#L22) |

## Foreign key fisik dan kardinalitas

| Parent | Child | Kunci child → parent | Parent per child | Child per parent | Saat parent dihapus | Bukti |
| --- | --- | --- | --- | --- | --- | --- |
| users | reviews | `user_id → id` | 1 | 0..n | cascade | [2025_11_24_000012_create_reviews_table.php](../../../../Motifnesia-Server/database/migrations/2025_11_24_000012_create_reviews_table.php#L16) |
| users | shopping_card | `user_id → id` | 0..1 | 0..n | cascade | [2025_12_06_000015_create_shopping_card_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_06_000015_create_shopping_card_table.php#L18) |
| produk | shopping_card | `product_id → id` | 0..1 | 0..n | cascade | [2025_12_06_000015_create_shopping_card_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_06_000015_create_shopping_card_table.php#L19) |
| users | orders | `user_id → id` | 1 | 0..n | default DB | [2025_12_11_100001_create_orders_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_11_100001_create_orders_table.php#L13) |
| metode_pengiriman | orders | `metode_pengiriman_id → id` | 1 | 0..n | default DB | [2025_12_11_100001_create_orders_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_11_100001_create_orders_table.php#L16) |
| metode_pembayaran | orders | `metode_pembayaran_id → id` | 1 | 0..n | default DB | [2025_12_11_100001_create_orders_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_11_100001_create_orders_table.php#L17) |
| delivery_status | orders | `delivery_status_id → id` | 1 | 0..n | default DB | [2025_12_11_100001_create_orders_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_11_100001_create_orders_table.php#L18) |
| orders | order_items | `order_id → id` | 1 | 0..n | cascade | [2025_12_11_100002_create_order_items_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_11_100002_create_order_items_table.php#L13) |
| produk | order_items | `produk_id → id` | 1 | 0..n | cascade | [2025_12_11_100002_create_order_items_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_11_100002_create_order_items_table.php#L22) |
| orders | order_status_history | `order_id → id` | 1 | 0..n | cascade | [2025_12_11_100003_create_order_status_history_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_11_100003_create_order_status_history_table.php#L13) |
| delivery_status | order_status_history | `delivery_status_id → id` | 1 | 0..n | default DB | [2025_12_11_100003_create_order_status_history_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_11_100003_create_order_status_history_table.php#L14) |
| users | product_favorite | `user_id → id` | 1 | 0..n | cascade | [2025_12_11_130000_create_product_favorite_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_11_130000_create_product_favorite_table.php#L13) |
| produk | product_favorite | `produk_id → id` | 1 | 0..n | cascade | [2025_12_11_130000_create_product_favorite_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_11_130000_create_product_favorite_table.php#L15) |
| users | checkout | `user_id → id` | 1 | 0..n | cascade | [2025_12_11_140000_create_checkout_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_11_140000_create_checkout_table.php#L13) |
| status_transaksi | checkout | `status_id → id` | 1 | 0..n | default DB | [2025_12_11_140000_create_checkout_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_11_140000_create_checkout_table.php#L23) |
| checkout | checkout_items | `checkout_id → id` | 1 | 0..n | cascade | [2025_12_11_140001_create_checkout_items_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_11_140001_create_checkout_items_table.php#L20) |
| produk | checkout_items | `product_id → id` | 1 | 0..n | cascade | [2025_12_11_140001_create_checkout_items_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_11_140001_create_checkout_items_table.php#L21) |
| users | order_reviews | `user_id → id` | 1 | 0..n | cascade | [2025_12_11_150000_create_order_reviews_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_11_150000_create_order_reviews_table.php#L16) |
| order_items | order_reviews | `order_item_id → id` | 1 | 0..n | cascade | [2025_12_11_150000_create_order_reviews_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_11_150000_create_order_reviews_table.php#L17) |
| orders | order_reviews | `order_id → id` | 1 | 0..n | cascade | [2025_12_11_150000_create_order_reviews_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_11_150000_create_order_reviews_table.php#L18) |
| produk | order_reviews | `produk_id → id` | 1 | 0..n | cascade | [2025_12_11_150000_create_order_reviews_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_11_150000_create_order_reviews_table.php#L25) |
| users | notifications | `user_id → id` | 0..1 | 0..n | cascade | [2025_12_12_000001_create_notifications_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_12_000001_create_notifications_table.php#L13) |
| users | returns | `user_id → id` | 1 | 0..n | cascade | [2025_12_13_000001_create_returns_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_13_000001_create_returns_table.php#L16) |
| orders | returns | `order_id → id` | 1 | 0..n | cascade | [2025_12_13_000001_create_returns_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_13_000001_create_returns_table.php#L17) |
| order_items | returns | `order_item_id → id` | 1 | 0..n | cascade | [2025_12_13_000001_create_returns_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_13_000001_create_returns_table.php#L18) |
| produk | returns | `produk_id → id` | 1 | 0..n | cascade | [2025_12_13_000001_create_returns_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_13_000001_create_returns_table.php#L20) |
| users | chats | `user_id → id` | 1 | 0..n | cascade | [2025_12_27_031318_create_chats_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_27_031318_create_chats_table.php#L16) |
| users | chats | `admin_id → id` | 0..1 | 0..n | set null | [2025_12_27_031318_create_chats_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_27_031318_create_chats_table.php#L17) |
| chats | chat_messages | `chat_id → id` | 1 | 0..n | cascade | [2025_12_27_031328_create_chat_messages_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_27_031328_create_chat_messages_table.php#L16) |
| users | chat_messages | `sender_id → id` | 1 | 0..n | cascade | [2025_12_27_031328_create_chat_messages_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_27_031328_create_chat_messages_table.php#L17) |
| users | user_addresses | `user_id → id` | 1 | 0..n | cascade | [2026_01_04_175218_create_user_addresses_table.php](../../../../Motifnesia-Server/database/migrations/2026_01_04_175218_create_user_addresses_table.php#L16) |
| users | point_transactions | `user_id → id` | 1 | 0..n | cascade | [2026_05_22_000001_create_membership_feature_tables.php](../../../../Motifnesia-Server/database/migrations/2026_05_22_000001_create_membership_feature_tables.php#L34) |
| orders | point_transactions | `order_id → id` | 0..1 | 0..n | set null | [2026_05_22_000001_create_membership_feature_tables.php](../../../../Motifnesia-Server/database/migrations/2026_05_22_000001_create_membership_feature_tables.php#L35) |
| users | user_reward_redemptions | `user_id → id` | 1 | 0..n | cascade | [2026_05_22_000001_create_membership_feature_tables.php](../../../../Motifnesia-Server/database/migrations/2026_05_22_000001_create_membership_feature_tables.php#L64) |
| membership_rewards | user_reward_redemptions | `reward_id → id` | 1 | 0..n | cascade | [2026_05_22_000001_create_membership_feature_tables.php](../../../../Motifnesia-Server/database/migrations/2026_05_22_000001_create_membership_feature_tables.php#L65) |
| user_reward_redemptions | orders | `membership_redemption_id → id` | 0..1 | 0..n | set null | [2026_05_23_000001_sync_membership_voucher_and_review_moderation.php](../../../../Motifnesia-Server/database/migrations/2026_05_23_000001_sync_membership_voucher_and_review_moderation.php#L14) |
| users | order_reviews | `moderated_by → id` | 0..1 | 0..n | set null | [2026_05_23_000001_sync_membership_voucher_and_review_moderation.php](../../../../Motifnesia-Server/database/migrations/2026_05_23_000001_sync_membership_voucher_and_review_moderation.php#L46) |
| users | users | `account_status_changed_by → id` | 0..1 | 0..n | set null | [2026_06_08_000001_add_ecommerce_flow_fields.php](../../../../Motifnesia-Server/database/migrations/2026_06_08_000001_add_ecommerce_flow_fields.php#L59) |
| produk | product_size_stocks | `produk_id → id` | 1 | 0..n | cascade | [2026_06_08_000001_add_ecommerce_flow_fields.php](../../../../Motifnesia-Server/database/migrations/2026_06_08_000001_add_ecommerce_flow_fields.php#L87) |
| users | audit_logs | `user_id → id` | 0..1 | 0..n | set null | [2026_06_08_083619_create_audit_logs_table.php](../../../../Motifnesia-Server/database/migrations/2026_06_08_083619_create_audit_logs_table.php#L16) |
| users | suppliers | `user_id → id` | 0..1 | 0..n | set null | [2026_06_11_000001_create_supply_chain_tables.php](../../../../Motifnesia-Server/database/migrations/2026_06_11_000001_create_supply_chain_tables.php#L15) |
| suppliers | stock_procurements | `supplier_id → id` | 0..1 | 0..n | set null | [2026_06_11_000001_create_supply_chain_tables.php](../../../../Motifnesia-Server/database/migrations/2026_06_11_000001_create_supply_chain_tables.php#L33) |
| users | stock_procurements | `created_by → id` | 0..1 | 0..n | set null | [2026_06_11_000001_create_supply_chain_tables.php](../../../../Motifnesia-Server/database/migrations/2026_06_11_000001_create_supply_chain_tables.php#L34) |
| users | stock_procurements | `confirmed_by → id` | 0..1 | 0..n | set null | [2026_06_11_000001_create_supply_chain_tables.php](../../../../Motifnesia-Server/database/migrations/2026_06_11_000001_create_supply_chain_tables.php#L35) |
| users | stock_procurements | `applied_by → id` | 0..1 | 0..n | set null | [2026_06_11_000001_create_supply_chain_tables.php](../../../../Motifnesia-Server/database/migrations/2026_06_11_000001_create_supply_chain_tables.php#L36) |
| stock_procurements | stock_procurement_items | `stock_procurement_id → id` | 1 | 0..n | cascade | [2026_06_11_000001_create_supply_chain_tables.php](../../../../Motifnesia-Server/database/migrations/2026_06_11_000001_create_supply_chain_tables.php#L52) |
| produk | stock_procurement_items | `produk_id → id` | 1 | 0..n | cascade | [2026_06_11_000001_create_supply_chain_tables.php](../../../../Motifnesia-Server/database/migrations/2026_06_11_000001_create_supply_chain_tables.php#L61) |
| users | warehouse_stocks | `updated_by → id` | 0..1 | 0..n | set null | [2026_06_11_000001_create_supply_chain_tables.php](../../../../Motifnesia-Server/database/migrations/2026_06_11_000001_create_supply_chain_tables.php#L73) |
| produk | warehouse_stocks | `produk_id → id` | 1 | 0..n | cascade | [2026_06_11_000001_create_supply_chain_tables.php](../../../../Motifnesia-Server/database/migrations/2026_06_11_000001_create_supply_chain_tables.php#L76) |
| users | stock_movements | `user_id → id` | 0..1 | 0..n | set null | [2026_06_11_000001_create_supply_chain_tables.php](../../../../Motifnesia-Server/database/migrations/2026_06_11_000001_create_supply_chain_tables.php#L119) |
| produk | stock_movements | `produk_id → id` | 1 | 0..n | cascade | [2026_06_11_000001_create_supply_chain_tables.php](../../../../Motifnesia-Server/database/migrations/2026_06_11_000001_create_supply_chain_tables.php#L123) |
| users | stock_opnames | `adjusted_by → id` | 0..1 | 0..n | set null | [2026_06_11_000001_create_supply_chain_tables.php](../../../../Motifnesia-Server/database/migrations/2026_06_11_000001_create_supply_chain_tables.php#L139) |
| produk | stock_opnames | `produk_id → id` | 1 | 0..n | cascade | [2026_06_11_000001_create_supply_chain_tables.php](../../../../Motifnesia-Server/database/migrations/2026_06_11_000001_create_supply_chain_tables.php#L143) |

## Relasi Eloquent

| Model dan relasi | Implementasi | Status basis data |
| --- | --- | --- |
| [AuditLog::user](../../../../Motifnesia-Server/app/Models/AuditLog.php#L26) | `belongsTo(\App\Models\User::class)` | Model aktif dalam kode. Cocokkan kolom dan constraint pada tabel terkait. |
| [Chat::user](../../../../Motifnesia-Server/app/Models/Chat.php#L27) | `belongsTo(\App\Models\User::class, 'user_id')` | Model aktif dalam kode. Cocokkan kolom dan constraint pada tabel terkait. |
| [Chat::admin](../../../../Motifnesia-Server/app/Models/Chat.php#L35) | `belongsTo(\App\Models\User::class, 'admin_id')` | Model aktif dalam kode. Cocokkan kolom dan constraint pada tabel terkait. |
| [Chat::messages](../../../../Motifnesia-Server/app/Models/Chat.php#L43) | `hasMany(\App\Models\ChatMessage::class)` | Model aktif dalam kode. Cocokkan kolom dan constraint pada tabel terkait. |
| [Chat::lastMessage](../../../../Motifnesia-Server/app/Models/Chat.php#L51) | `hasOne(\App\Models\ChatMessage::class)` | Model aktif dalam kode. Cocokkan kolom dan constraint pada tabel terkait. |
| [ChatMessage::chat](../../../../Motifnesia-Server/app/Models/ChatMessage.php#L27) | `belongsTo(\App\Models\Chat::class)` | Model aktif dalam kode. Cocokkan kolom dan constraint pada tabel terkait. |
| [ChatMessage::sender](../../../../Motifnesia-Server/app/Models/ChatMessage.php#L35) | `belongsTo(\App\Models\User::class, 'sender_id')` | Model aktif dalam kode. Cocokkan kolom dan constraint pada tabel terkait. |
| [Checkout::user](../../../../Motifnesia-Server/app/Models/Checkout.php#L31) | `belongsTo(\App\Models\User::class)` | Model aktif dalam kode. Cocokkan kolom dan constraint pada tabel terkait. |
| [Checkout::items](../../../../Motifnesia-Server/app/Models/Checkout.php#L36) | `hasMany(\App\Models\CheckoutItem::class, 'checkout_id')` | Model aktif dalam kode. Cocokkan kolom dan constraint pada tabel terkait. |
| [Checkout::status](../../../../Motifnesia-Server/app/Models/Checkout.php#L41) | `belongsTo(\App\Models\StatusTransaksi::class, 'status_id')` | Model aktif dalam kode. Cocokkan kolom dan constraint pada tabel terkait. |
| [Checkout::reviews](../../../../Motifnesia-Server/app/Models/Checkout.php#L46) | `hasMany(\App\Models\OrderReview::class, 'checkout_id')` | Model aktif dalam kode. Cocokkan kolom dan constraint pada tabel terkait. |
| [CheckoutItem::checkout](../../../../Motifnesia-Server/app/Models/CheckoutItem.php#L33) | `belongsTo(\App\Models\Checkout::class, 'checkout_id')` | Model aktif dalam kode. Cocokkan kolom dan constraint pada tabel terkait. |
| [CheckoutItem::produk](../../../../Motifnesia-Server/app/Models/CheckoutItem.php#L41) | `belongsTo(\App\Models\Produk::class, 'product_id')` | Model aktif dalam kode. Cocokkan kolom dan constraint pada tabel terkait. |
| [CheckoutItem::review](../../../../Motifnesia-Server/app/Models/CheckoutItem.php#L49) | `hasOne(\App\Models\OrderReview::class, 'order_item_id')` | Model aktif dalam kode. Cocokkan kolom dan constraint pada tabel terkait. |
| [DeliveryStatus::checkouts](../../../../Motifnesia-Server/app/Models/DeliveryStatus.php#L16) | `hasMany(\App\Models\Checkout::class, 'delivery_status_id')` | Model aktif dalam kode. Cocokkan kolom dan constraint pada tabel terkait. |
| [MembershipReward::redemptions](../../../../Motifnesia-Server/app/Models/MembershipReward.php#L30) | `hasMany(\App\Models\UserRewardRedemption::class, 'reward_id')` | Model aktif dalam kode. Cocokkan kolom dan constraint pada tabel terkait. |
| [Notification::user](../../../../Motifnesia-Server/app/Models/Notification.php#L33) | `belongsTo(\App\Models\User::class)` | Model aktif dalam kode. Cocokkan kolom dan constraint pada tabel terkait. |
| [Order::user](../../../../Motifnesia-Server/app/Models/Order.php#L51) | `belongsTo(\App\Models\User::class)` | Model aktif dalam kode. Cocokkan kolom dan constraint pada tabel terkait. |
| [Order::metodePengiriman](../../../../Motifnesia-Server/app/Models/Order.php#L56) | `belongsTo(\App\Models\MetodePengiriman::class)` | Model aktif dalam kode. Cocokkan kolom dan constraint pada tabel terkait. |
| [Order::metodePembayaran](../../../../Motifnesia-Server/app/Models/Order.php#L61) | `belongsTo(\App\Models\MetodePembayaran::class)` | Model aktif dalam kode. Cocokkan kolom dan constraint pada tabel terkait. |
| [Order::deliveryStatus](../../../../Motifnesia-Server/app/Models/Order.php#L66) | `belongsTo(\App\Models\DeliveryStatus::class)` | Model aktif dalam kode. Cocokkan kolom dan constraint pada tabel terkait. |
| [Order::orderItems](../../../../Motifnesia-Server/app/Models/Order.php#L71) | `hasMany(\App\Models\OrderItem::class)` | Model aktif dalam kode. Cocokkan kolom dan constraint pada tabel terkait. |
| [Order::membershipRedemption](../../../../Motifnesia-Server/app/Models/Order.php#L76) | `belongsTo(\App\Models\UserRewardRedemption::class, 'membership_redemption_id')` | Model aktif dalam kode. Cocokkan kolom dan constraint pada tabel terkait. |
| [OrderItem::order](../../../../Motifnesia-Server/app/Models/OrderItem.php#L22) | `belongsTo(\App\Models\Order::class)` | Model aktif dalam kode. Cocokkan kolom dan constraint pada tabel terkait. |
| [OrderItem::produk](../../../../Motifnesia-Server/app/Models/OrderItem.php#L27) | `belongsTo(\App\Models\Produk::class)` | Model aktif dalam kode. Cocokkan kolom dan constraint pada tabel terkait. |
| [OrderItem::review](../../../../Motifnesia-Server/app/Models/OrderItem.php#L32) | `hasOne(\App\Models\OrderReview::class, 'order_item_id')` | Model aktif dalam kode. Cocokkan kolom dan constraint pada tabel terkait. |
| [OrderItem::productReturns](../../../../Motifnesia-Server/app/Models/OrderItem.php#L37) | `hasMany(\App\Models\ProductReturn::class, 'order_item_id')` | Model aktif dalam kode. Cocokkan kolom dan constraint pada tabel terkait. |
| [OrderReview::user](../../../../Motifnesia-Server/app/Models/OrderReview.php#L37) | `belongsTo(\App\Models\User::class, 'user_id')` | Model aktif dalam kode. Cocokkan kolom dan constraint pada tabel terkait. |
| [OrderReview::orderItem](../../../../Motifnesia-Server/app/Models/OrderReview.php#L45) | `belongsTo(\App\Models\OrderItem::class, 'order_item_id')` | Model aktif dalam kode. Cocokkan kolom dan constraint pada tabel terkait. |
| [OrderReview::order](../../../../Motifnesia-Server/app/Models/OrderReview.php#L53) | `belongsTo(\App\Models\Order::class, 'order_id')` | Model aktif dalam kode. Cocokkan kolom dan constraint pada tabel terkait. |
| [OrderReview::produk](../../../../Motifnesia-Server/app/Models/OrderReview.php#L61) | `belongsTo(\App\Models\Produk::class, 'produk_id')` | Model aktif dalam kode. Cocokkan kolom dan constraint pada tabel terkait. |
| [OrderReview::moderator](../../../../Motifnesia-Server/app/Models/OrderReview.php#L66) | `belongsTo(\App\Models\User::class, 'moderated_by')` | Model aktif dalam kode. Cocokkan kolom dan constraint pada tabel terkait. |
| [OrderStatusHistory::order](../../../../Motifnesia-Server/app/Models/OrderStatusHistory.php#L24) | `belongsTo(\App\Models\Order::class)` | Model aktif dalam kode. Cocokkan kolom dan constraint pada tabel terkait. |
| [OrderStatusHistory::deliveryStatus](../../../../Motifnesia-Server/app/Models/OrderStatusHistory.php#L29) | `belongsTo(\App\Models\DeliveryStatus::class)` | Model aktif dalam kode. Cocokkan kolom dan constraint pada tabel terkait. |
| [PointTransaction::user](../../../../Motifnesia-Server/app/Models/PointTransaction.php#L24) | `belongsTo(\App\Models\User::class)` | Model aktif dalam kode. Cocokkan kolom dan constraint pada tabel terkait. |
| [PointTransaction::order](../../../../Motifnesia-Server/app/Models/PointTransaction.php#L29) | `belongsTo(\App\Models\Order::class)` | Model aktif dalam kode. Cocokkan kolom dan constraint pada tabel terkait. |
| [ProductFavorite::user](../../../../Motifnesia-Server/app/Models/ProductFavorite.php#L19) | `belongsTo(\App\Models\User::class)` | Model aktif dalam kode. Cocokkan kolom dan constraint pada tabel terkait. |
| [ProductFavorite::produk](../../../../Motifnesia-Server/app/Models/ProductFavorite.php#L24) | `belongsTo(\App\Models\Produk::class)` | Model aktif dalam kode. Cocokkan kolom dan constraint pada tabel terkait. |
| [ProductOrder::user](../../../../Motifnesia-Server/app/Models/ProductOrder.php#L25) | `belongsTo(\App\Models\User::class)` | Model aktif dalam kode. Cocokkan kolom dan constraint pada tabel terkait. |
| [ProductOrder::metodePengiriman](../../../../Motifnesia-Server/app/Models/ProductOrder.php#L30) | `belongsTo(\App\Models\MetodePengiriman::class, 'metode_pengiriman_id')` | Model aktif dalam kode. Cocokkan kolom dan constraint pada tabel terkait. |
| [ProductOrder::metodePembayaran](../../../../Motifnesia-Server/app/Models/ProductOrder.php#L35) | `belongsTo(\App\Models\MetodePembayaran::class, 'metode_pembayaran_id')` | Model aktif dalam kode. Cocokkan kolom dan constraint pada tabel terkait. |
| [ProductOrder::details](../../../../Motifnesia-Server/app/Models/ProductOrder.php#L40) | `hasMany(\App\Models\ProductOrderDetail::class, 'order_id')` | Model aktif dalam kode. Cocokkan kolom dan constraint pada tabel terkait. |
| [ProductOrderDetail::order](../../../../Motifnesia-Server/app/Models/ProductOrderDetail.php#L20) | `belongsTo(\App\Models\ProductOrder::class, 'order_id')` | Model aktif dalam kode. Cocokkan kolom dan constraint pada tabel terkait. |
| [ProductOrderDetail::produk](../../../../Motifnesia-Server/app/Models/ProductOrderDetail.php#L25) | `belongsTo(\App\Models\Produk::class, 'product_id')` | Model aktif dalam kode. Cocokkan kolom dan constraint pada tabel terkait. |
| [ProductReturn::user](../../../../Motifnesia-Server/app/Models/ProductReturn.php#L52) | `belongsTo(\App\Models\User::class)` | Model aktif dalam kode. Cocokkan kolom dan constraint pada tabel terkait. |
| [ProductReturn::order](../../../../Motifnesia-Server/app/Models/ProductReturn.php#L60) | `belongsTo(\App\Models\Order::class)` | Model aktif dalam kode. Cocokkan kolom dan constraint pada tabel terkait. |
| [ProductReturn::orderItem](../../../../Motifnesia-Server/app/Models/ProductReturn.php#L68) | `belongsTo(\App\Models\OrderItem::class)` | Model aktif dalam kode. Cocokkan kolom dan constraint pada tabel terkait. |
| [ProductReturn::produk](../../../../Motifnesia-Server/app/Models/ProductReturn.php#L76) | `belongsTo(\App\Models\Produk::class)` | Model aktif dalam kode. Cocokkan kolom dan constraint pada tabel terkait. |
| [ProductSizeStock::produk](../../../../Motifnesia-Server/app/Models/ProductSizeStock.php#L25) | `belongsTo(\App\Models\Produk::class, 'produk_id')` | Model aktif dalam kode. Cocokkan kolom dan constraint pada tabel terkait. |
| [Produk::reviews](../../../../Motifnesia-Server/app/Models/Produk.php#L50) | `hasMany(\App\Models\OrderReview::class, 'produk_id')` | Model aktif dalam kode. Cocokkan kolom dan constraint pada tabel terkait. |
| [Produk::sizeStocks](../../../../Motifnesia-Server/app/Models/Produk.php#L55) | `hasMany(\App\Models\ProductSizeStock::class, 'produk_id')` | Model aktif dalam kode. Cocokkan kolom dan constraint pada tabel terkait. |
| [Produk::warehouseStocks](../../../../Motifnesia-Server/app/Models/Produk.php#L60) | `hasMany(\App\Models\WarehouseStock::class, 'produk_id')` | Model aktif dalam kode. Cocokkan kolom dan constraint pada tabel terkait. |
| [Produk::stockMovements](../../../../Motifnesia-Server/app/Models/Produk.php#L65) | `hasMany(\App\Models\StockMovement::class, 'produk_id')` | Model aktif dalam kode. Cocokkan kolom dan constraint pada tabel terkait. |
| [Review::user](../../../../Motifnesia-Server/app/Models/Review.php#L20) | `belongsTo(\App\Models\User::class)` | Model aktif dalam kode. Cocokkan kolom dan constraint pada tabel terkait. |
| [ShoppingCard::user](../../../../Motifnesia-Server/app/Models/ShoppingCard.php#L16) | `belongsTo(\App\Models\User::class)` | Model aktif dalam kode. Cocokkan kolom dan constraint pada tabel terkait. |
| [ShoppingCard::produk](../../../../Motifnesia-Server/app/Models/ShoppingCard.php#L21) | `belongsTo(\App\Models\Produk::class, 'product_id')` | Model aktif dalam kode. Cocokkan kolom dan constraint pada tabel terkait. |
| [StatusTransaksi::checkouts](../../../../Motifnesia-Server/app/Models/StatusTransaksi.php#L24) | `hasMany(\App\Models\Checkout::class, 'status_id')` | Model aktif dalam kode. Cocokkan kolom dan constraint pada tabel terkait. |
| [StockMovement::produk](../../../../Motifnesia-Server/app/Models/StockMovement.php#L35) | `belongsTo(\App\Models\Produk::class, 'produk_id')` | Model aktif dalam kode. Cocokkan kolom dan constraint pada tabel terkait. |
| [StockMovement::user](../../../../Motifnesia-Server/app/Models/StockMovement.php#L40) | `belongsTo(\App\Models\User::class)` | Model aktif dalam kode. Cocokkan kolom dan constraint pada tabel terkait. |
| [StockOpname::produk](../../../../Motifnesia-Server/app/Models/StockOpname.php#L31) | `belongsTo(\App\Models\Produk::class, 'produk_id')` | Model aktif dalam kode. Cocokkan kolom dan constraint pada tabel terkait. |
| [StockOpname::adjustedBy](../../../../Motifnesia-Server/app/Models/StockOpname.php#L36) | `belongsTo(\App\Models\User::class, 'adjusted_by')` | Model aktif dalam kode. Cocokkan kolom dan constraint pada tabel terkait. |
| [StockProcurement::supplier](../../../../Motifnesia-Server/app/Models/StockProcurement.php#L50) | `belongsTo(\App\Models\Supplier::class)` | Model aktif dalam kode. Cocokkan kolom dan constraint pada tabel terkait. |
| [StockProcurement::items](../../../../Motifnesia-Server/app/Models/StockProcurement.php#L55) | `hasMany(\App\Models\StockProcurementItem::class)` | Model aktif dalam kode. Cocokkan kolom dan constraint pada tabel terkait. |
| [StockProcurement::creator](../../../../Motifnesia-Server/app/Models/StockProcurement.php#L60) | `belongsTo(\App\Models\User::class, 'created_by')` | Model aktif dalam kode. Cocokkan kolom dan constraint pada tabel terkait. |
| [StockProcurement::confirmer](../../../../Motifnesia-Server/app/Models/StockProcurement.php#L65) | `belongsTo(\App\Models\User::class, 'confirmed_by')` | Model aktif dalam kode. Cocokkan kolom dan constraint pada tabel terkait. |
| [StockProcurement::applier](../../../../Motifnesia-Server/app/Models/StockProcurement.php#L70) | `belongsTo(\App\Models\User::class, 'applied_by')` | Model aktif dalam kode. Cocokkan kolom dan constraint pada tabel terkait. |
| [StockProcurementItem::procurement](../../../../Motifnesia-Server/app/Models/StockProcurementItem.php#L30) | `belongsTo(\App\Models\StockProcurement::class, 'stock_procurement_id')` | Model aktif dalam kode. Cocokkan kolom dan constraint pada tabel terkait. |
| [StockProcurementItem::produk](../../../../Motifnesia-Server/app/Models/StockProcurementItem.php#L35) | `belongsTo(\App\Models\Produk::class, 'produk_id')` | Model aktif dalam kode. Cocokkan kolom dan constraint pada tabel terkait. |
| [Supplier::user](../../../../Motifnesia-Server/app/Models/Supplier.php#L23) | `belongsTo(\App\Models\User::class)` | Model aktif dalam kode. Cocokkan kolom dan constraint pada tabel terkait. |
| [Supplier::procurements](../../../../Motifnesia-Server/app/Models/Supplier.php#L28) | `hasMany(\App\Models\StockProcurement::class)` | Model aktif dalam kode. Cocokkan kolom dan constraint pada tabel terkait. |
| [User::orders](../../../../Motifnesia-Server/app/Models/User.php#L85) | `hasMany(\App\Models\Order::class)` | Model aktif dalam kode. Cocokkan kolom dan constraint pada tabel terkait. |
| [User::addresses](../../../../Motifnesia-Server/app/Models/User.php#L91) | `hasMany(\App\Models\UserAddress::class)` | Model aktif dalam kode. Cocokkan kolom dan constraint pada tabel terkait. |
| [User::primaryAddress](../../../../Motifnesia-Server/app/Models/User.php#L97) | `hasOne(\App\Models\UserAddress::class)` | Model aktif dalam kode. Cocokkan kolom dan constraint pada tabel terkait. |
| [User::pointTransactions](../../../../Motifnesia-Server/app/Models/User.php#L102) | `hasMany(\App\Models\PointTransaction::class)` | Model aktif dalam kode. Cocokkan kolom dan constraint pada tabel terkait. |
| [User::rewardRedemptions](../../../../Motifnesia-Server/app/Models/User.php#L107) | `hasMany(\App\Models\UserRewardRedemption::class)` | Model aktif dalam kode. Cocokkan kolom dan constraint pada tabel terkait. |
| [User::supplierProfile](../../../../Motifnesia-Server/app/Models/User.php#L112) | `hasOne(\App\Models\Supplier::class)` | Model aktif dalam kode. Cocokkan kolom dan constraint pada tabel terkait. |
| [UserAddress::user](../../../../Motifnesia-Server/app/Models/UserAddress.php#L30) | `belongsTo(\App\Models\User::class)` | Model aktif dalam kode. Cocokkan kolom dan constraint pada tabel terkait. |
| [UserRewardRedemption::user](../../../../Motifnesia-Server/app/Models/UserRewardRedemption.php#L28) | `belongsTo(\App\Models\User::class)` | Model aktif dalam kode. Cocokkan kolom dan constraint pada tabel terkait. |
| [UserRewardRedemption::reward](../../../../Motifnesia-Server/app/Models/UserRewardRedemption.php#L33) | `belongsTo(\App\Models\MembershipReward::class, 'reward_id')` | Model aktif dalam kode. Cocokkan kolom dan constraint pada tabel terkait. |
| [WarehouseStock::produk](../../../../Motifnesia-Server/app/Models/WarehouseStock.php#L23) | `belongsTo(\App\Models\Produk::class, 'produk_id')` | Model aktif dalam kode. Cocokkan kolom dan constraint pada tabel terkait. |
| [WarehouseStock::updater](../../../../Motifnesia-Server/app/Models/WarehouseStock.php#L28) | `belongsTo(\App\Models\User::class, 'updated_by')` | Model aktif dalam kode. Cocokkan kolom dan constraint pada tabel terkait. |

Model berikut memakai nama tabel yang tidak ditemukan pada migration terdata. Ketersediaan tabel runtime berstatus TBD. `ProductOrder` (`product_order`), `ProductOrderDetail` (`product_order_detail`), `ProductOrderItem` (`product_order_items`).

## Jejak migration

| Operasi | Tabel | Bukti |
| --- | --- | --- |
| create | users | [0001_01_01_000000_create_users_table.php](../../../../Motifnesia-Server/database/migrations/0001_01_01_000000_create_users_table.php#L14) |
| create | password_reset_tokens | [0001_01_01_000000_create_users_table.php](../../../../Motifnesia-Server/database/migrations/0001_01_01_000000_create_users_table.php#L24) |
| create | cache | [0001_01_01_000001_create_cache_table.php](../../../../Motifnesia-Server/database/migrations/0001_01_01_000001_create_cache_table.php#L14) |
| create | cache_locks | [0001_01_01_000001_create_cache_table.php](../../../../Motifnesia-Server/database/migrations/0001_01_01_000001_create_cache_table.php#L20) |
| create | jobs | [0001_01_01_000002_create_jobs_table.php](../../../../Motifnesia-Server/database/migrations/0001_01_01_000002_create_jobs_table.php#L14) |
| create | job_batches | [0001_01_01_000002_create_jobs_table.php](../../../../Motifnesia-Server/database/migrations/0001_01_01_000002_create_jobs_table.php#L24) |
| create | failed_jobs | [0001_01_01_000002_create_jobs_table.php](../../../../Motifnesia-Server/database/migrations/0001_01_01_000002_create_jobs_table.php#L37) |
| create | produk | [2025_11_23_000001_create_produk_table.php](../../../../Motifnesia-Server/database/migrations/2025_11_23_000001_create_produk_table.php#L16) |
| create | sessions | [2025_11_23_000002_create_sessions_table.php](../../../../Motifnesia-Server/database/migrations/2025_11_23_000002_create_sessions_table.php#L16) |
| table | produk | [2025_11_23_000003_add_ukuran_to_produk_table.php](../../../../Motifnesia-Server/database/migrations/2025_11_23_000003_add_ukuran_to_produk_table.php#L16) |
| create | konten_icon | [2025_11_23_000004_create_konten_icon_table.php](../../../../Motifnesia-Server/database/migrations/2025_11_23_000004_create_konten_icon_table.php#L11) |
| create | konten_about_us | [2025_11_23_000005_create_konten_about_us_table.php](../../../../Motifnesia-Server/database/migrations/2025_11_23_000005_create_konten_about_us_table.php#L11) |
| create | konten_slide_show | [2025_11_23_000006_create_konten_slide_show_table.php](../../../../Motifnesia-Server/database/migrations/2025_11_23_000006_create_konten_slide_show_table.php#L11) |
| table | konten_about_us | [2025_11_24_000007_add_fields_to_konten_about_us.php](../../../../Motifnesia-Server/database/migrations/2025_11_24_000007_add_fields_to_konten_about_us.php#L11) |
| table | users | [2025_11_24_000010_add_profile_fields_to_users.php](../../../../Motifnesia-Server/database/migrations/2025_11_24_000010_add_profile_fields_to_users.php#L14) |
| table | users | [2025_11_24_000011_add_address_to_users.php](../../../../Motifnesia-Server/database/migrations/2025_11_24_000011_add_address_to_users.php#L14) |
| create | reviews | [2025_11_24_000012_create_reviews_table.php](../../../../Motifnesia-Server/database/migrations/2025_11_24_000012_create_reviews_table.php#L14) |
| table | users | [2025_11_24_000013_add_full_name_to_users_table.php](../../../../Motifnesia-Server/database/migrations/2025_11_24_000013_add_full_name_to_users_table.php#L14) |
| table | users | [2025_12_06_000014_add_role_to_users_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_06_000014_add_role_to_users_table.php#L10) |
| create | shopping_card | [2025_12_06_000015_create_shopping_card_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_06_000015_create_shopping_card_table.php#L10) |
| create | metode_pengiriman | [2025_12_07_000016_create_metode_pengiriman_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_07_000016_create_metode_pengiriman_table.php#L10) |
| create | metode_pembayaran | [2025_12_07_000017_create_metode_pembayaran_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_07_000017_create_metode_pembayaran_table.php#L10) |
| create | delivery_status | [2025_12_10_115919_create_delivery_status_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_10_115919_create_delivery_status_table.php#L14) |
| create | orders | [2025_12_11_100001_create_orders_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_11_100001_create_orders_table.php#L11) |
| create | order_items | [2025_12_11_100002_create_order_items_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_11_100002_create_order_items_table.php#L11) |
| create | order_status_history | [2025_12_11_100003_create_order_status_history_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_11_100003_create_order_status_history_table.php#L11) |
| create | product_favorite | [2025_12_11_130000_create_product_favorite_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_11_130000_create_product_favorite_table.php#L11) |
| create | status_transaksi | [2025_12_11_135959_create_status_transaksi_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_11_135959_create_status_transaksi_table.php#L11) |
| create | checkout | [2025_12_11_140000_create_checkout_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_11_140000_create_checkout_table.php#L11) |
| create | checkout_items | [2025_12_11_140001_create_checkout_items_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_11_140001_create_checkout_items_table.php#L11) |
| create | order_reviews | [2025_12_11_150000_create_order_reviews_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_11_150000_create_order_reviews_table.php#L14) |
| table | produk | [2025_12_11_150001_add_rating_to_produk_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_11_150001_add_rating_to_produk_table.php#L14) |
| create | notifications | [2025_12_12_000001_create_notifications_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_12_000001_create_notifications_table.php#L11) |
| create | returns | [2025_12_13_000001_create_returns_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_13_000001_create_returns_table.php#L14) |
| table | produk | [2025_12_13_061923_add_gender_to_produk_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_13_061923_add_gender_to_produk_table.php#L14) |
| table | produk | [2025_12_14_144811_change_terjual_to_integer_in_produk_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_14_144811_change_terjual_to_integer_in_produk_table.php#L27) |
| table | users | [2025_12_27_024723_add_secret_fields_to_users_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_27_024723_add_secret_fields_to_users_table.php#L14) |
| table | users | [2025_12_27_024822_add_secret_fields_to_users_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_27_024822_add_secret_fields_to_users_table.php#L14) |
| create | chats | [2025_12_27_031318_create_chats_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_27_031318_create_chats_table.php#L14) |
| create | chat_messages | [2025_12_27_031328_create_chat_messages_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_27_031328_create_chat_messages_table.php#L14) |
| table | users | [2025_12_27_040134_add_unique_to_name_in_users_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_27_040134_add_unique_to_name_in_users_table.php#L14) |
| table | produk | [2025_12_27_051934_increase_ukuran_length_in_produk_table.php](../../../../Motifnesia-Server/database/migrations/2025_12_27_051934_increase_ukuran_length_in_produk_table.php#L14) |
| create | user_addresses | [2026_01_04_175218_create_user_addresses_table.php](../../../../Motifnesia-Server/database/migrations/2026_01_04_175218_create_user_addresses_table.php#L14) |
| table | notifications | [2026_05_21_000001_normalize_notifications_type_and_data.php](../../../../Motifnesia-Server/database/migrations/2026_05_21_000001_normalize_notifications_type_and_data.php#L21) |
| table | notifications | [2026_05_21_000001_normalize_notifications_type_and_data.php](../../../../Motifnesia-Server/database/migrations/2026_05_21_000001_normalize_notifications_type_and_data.php#L27) |
| table | users | [2026_05_22_000001_create_membership_feature_tables.php](../../../../Motifnesia-Server/database/migrations/2026_05_22_000001_create_membership_feature_tables.php#L12) |
| create | point_transactions | [2026_05_22_000001_create_membership_feature_tables.php](../../../../Motifnesia-Server/database/migrations/2026_05_22_000001_create_membership_feature_tables.php#L32) |
| create | membership_rewards | [2026_05_22_000001_create_membership_feature_tables.php](../../../../Motifnesia-Server/database/migrations/2026_05_22_000001_create_membership_feature_tables.php#L47) |
| create | user_reward_redemptions | [2026_05_22_000001_create_membership_feature_tables.php](../../../../Motifnesia-Server/database/migrations/2026_05_22_000001_create_membership_feature_tables.php#L62) |
| table | orders | [2026_05_23_000001_sync_membership_voucher_and_review_moderation.php](../../../../Motifnesia-Server/database/migrations/2026_05_23_000001_sync_membership_voucher_and_review_moderation.php#L12) |
| table | order_reviews | [2026_05_23_000001_sync_membership_voucher_and_review_moderation.php](../../../../Motifnesia-Server/database/migrations/2026_05_23_000001_sync_membership_voucher_and_review_moderation.php#L32) |
| table | orders | [2026_06_08_000001_add_ecommerce_flow_fields.php](../../../../Motifnesia-Server/database/migrations/2026_06_08_000001_add_ecommerce_flow_fields.php#L11) |
| table | users | [2026_06_08_000001_add_ecommerce_flow_fields.php](../../../../Motifnesia-Server/database/migrations/2026_06_08_000001_add_ecommerce_flow_fields.php#L45) |
| table | produk | [2026_06_08_000001_add_ecommerce_flow_fields.php](../../../../Motifnesia-Server/database/migrations/2026_06_08_000001_add_ecommerce_flow_fields.php#L67) |
| create | product_size_stocks | [2026_06_08_000001_add_ecommerce_flow_fields.php](../../../../Motifnesia-Server/database/migrations/2026_06_08_000001_add_ecommerce_flow_fields.php#L78) |
| table | returns | [2026_06_08_000001_add_ecommerce_flow_fields.php](../../../../Motifnesia-Server/database/migrations/2026_06_08_000001_add_ecommerce_flow_fields.php#L93) |
| create | personal_access_tokens | [2026_06_08_082433_create_personal_access_tokens_table.php](../../../../Motifnesia-Server/database/migrations/2026_06_08_082433_create_personal_access_tokens_table.php#L14) |
| table | orders | [2026_06_08_083000_add_payment_proof_to_orders_table.php](../../../../Motifnesia-Server/database/migrations/2026_06_08_083000_add_payment_proof_to_orders_table.php#L14) |
| table | membership_rewards | [2026_06_08_083427_add_max_discount_value_to_membership_rewards_table.php](../../../../Motifnesia-Server/database/migrations/2026_06_08_083427_add_max_discount_value_to_membership_rewards_table.php#L14) |
| create | audit_logs | [2026_06_08_083619_create_audit_logs_table.php](../../../../Motifnesia-Server/database/migrations/2026_06_08_083619_create_audit_logs_table.php#L14) |
| table | users | [2026_06_09_043741_add_admin_role_to_users_table.php](../../../../Motifnesia-Server/database/migrations/2026_06_09_043741_add_admin_role_to_users_table.php#L14) |
| table | produk | [2026_06_09_050041_add_filosofi_motif_to_produk_table.php](../../../../Motifnesia-Server/database/migrations/2026_06_09_050041_add_filosofi_motif_to_produk_table.php#L14) |
| table | users | [2026_06_09_050047_add_membership_tier_fields_to_users_table.php](../../../../Motifnesia-Server/database/migrations/2026_06_09_050047_add_membership_tier_fields_to_users_table.php#L14) |
| table | orders | [2026_06_09_050240_add_membership_tier_discount_to_orders_table.php](../../../../Motifnesia-Server/database/migrations/2026_06_09_050240_add_membership_tier_discount_to_orders_table.php#L14) |
| create | suppliers | [2026_06_11_000001_create_supply_chain_tables.php](../../../../Motifnesia-Server/database/migrations/2026_06_11_000001_create_supply_chain_tables.php#L13) |
| create | stock_procurements | [2026_06_11_000001_create_supply_chain_tables.php](../../../../Motifnesia-Server/database/migrations/2026_06_11_000001_create_supply_chain_tables.php#L30) |
| create | stock_procurement_items | [2026_06_11_000001_create_supply_chain_tables.php](../../../../Motifnesia-Server/database/migrations/2026_06_11_000001_create_supply_chain_tables.php#L50) |
| create | warehouse_stocks | [2026_06_11_000001_create_supply_chain_tables.php](../../../../Motifnesia-Server/database/migrations/2026_06_11_000001_create_supply_chain_tables.php#L68) |
| create | stock_movements | [2026_06_11_000001_create_supply_chain_tables.php](../../../../Motifnesia-Server/database/migrations/2026_06_11_000001_create_supply_chain_tables.php#L107) |
| create | stock_opnames | [2026_06_11_000001_create_supply_chain_tables.php](../../../../Motifnesia-Server/database/migrations/2026_06_11_000001_create_supply_chain_tables.php#L130) |
