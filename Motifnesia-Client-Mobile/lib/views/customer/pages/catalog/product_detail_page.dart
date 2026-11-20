import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:motifnesia_mobile/app/routes/navigation.dart';
import 'package:motifnesia_mobile/core/api/api_contract.dart';
import 'package:motifnesia_mobile/core/api/motifnesia_api.dart';
import 'package:motifnesia_mobile/core/catalog/product_sizes.dart';
import 'package:motifnesia_mobile/shared/forms/form_view.dart';
import 'package:motifnesia_mobile/shared/layouts/api_page.dart';
import 'package:motifnesia_mobile/shared/widgets/action_controls.dart';
import 'package:motifnesia_mobile/shared/widgets/layout_blocks.dart';
import 'package:motifnesia_mobile/shared/widgets/metrics.dart';
import 'package:motifnesia_mobile/shared/widgets/photo.dart';
import 'package:motifnesia_mobile/views/customer/components/product_grid.dart';

class ProductDetailPage extends ApiPage {
  const ProductDetailPage(super.arguments, {super.key});

  @override
  ApiPageState<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends ApiPageState<ProductDetailPage> {
  String? size;

  @override
  Widget buildContent() {
    final product = asMap(data['product']);
    final code = idOf(product);
    final variants = asMap(product['size_stocks']);
    final reviews = records(data['reviews']);
    final related = records(data['relatedProducts']);
    final discount = number(session.viewer['tier_discount']);
    return StackGroup([
      GestureDetector(
        onTap: () => showDialog<void>(
          context: context,
          builder: (dialog) => Dialog(
            child: InteractiveViewer(
              child: Photo(api, productImage(product), fit: BoxFit.contain),
            ),
          ),
        ),
        child: AspectRatio(
          aspectRatio: 1.22,
          child: Photo(api, productImage(product)),
        ),
      ),
      PageHeading(productName(product), subtitle: text(product['kategori'])),
      Wrap(
        spacing: 10,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Text(
            money(productPrice(product)),
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.w800,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          if (whole(product['diskon_persen']) > 0)
            Text(
              money(product['harga']),
              style: const TextStyle(decoration: TextDecoration.lineThrough),
            ),
        ],
      ),
      if (discount > 0 && truth(session.viewer['membership_active']))
        Text(
          'Estimasi harga member ${money(number(productPrice(product)) * (1 - discount))}',
        ),
      Block(
        child: StackGroup([
          PageHeading(
            'Pilih ukuran',
            trailing: TextButton(
              onPressed: _sizeGuide,
              child: const Text('Panduan'),
            ),
          ),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final item in productSizes)
                ChoiceChip(
                  label: Text(item),
                  selected: size == item,
                  onSelected: whole(variants[item]) <= 0
                      ? null
                      : (_) => setState(() => size = item),
                ),
            ],
          ),
          Text(
            size == null
                ? 'Pilih ukuran untuk melihat ketersediaan.'
                : 'Stok ukuran $size: ${whole(variants[size])}',
          ),
          actionGroup([
            FilledButton.icon(
              onPressed: size == null || busy
                  ? null
                  : () {
                      if (!session.signedIn) {
                        openPage(context, '/login');
                        return;
                      }
                      action(
                        '/cart/add',
                        fields: {'product_id': code, 'ukuran': size, 'qty': 1},
                        refresh: false,
                      );
                    },
              icon: const Icon(Icons.shopping_bag_outlined),
              label: const Text('Tambah ke keranjang'),
            ),
            IconButton.outlined(
              tooltip: 'Tambahkan ke favorit',
              icon: const Icon(Icons.favorite_border),
              onPressed: busy
                  ? null
                  : () => session.signedIn
                        ? action(
                            '/favorites/store',
                            fields: {'produk_id': code},
                            refresh: false,
                          )
                        : openPage(context, '/login'),
            ),
          ]),
          actionGroup([
            actionButton('Tanya admin', Icons.forum_outlined, () {
              if (!session.signedIn) {
                openPage(context, '/login');
                return;
              }
              prompt('Tanya admin', '/chat/product/$code/ask', const [
                FormFieldSpec(
                  'question',
                  'Pertanyaan tentang produk',
                  kind: FieldKind.multiline,
                  required: false,
                ),
              ], follow: true);
            }),
            actionButton(
              'Beli via WhatsApp',
              Icons.chat_outlined,
              size == null
                  ? null
                  : () async {
                      const phone = String.fromEnvironment(
                        'MOTIFNESIA_WHATSAPP',
                        defaultValue: '6281234567890',
                      );
                      const web = String.fromEnvironment(
                        'MOTIFNESIA_WEB_URL',
                        defaultValue: 'http://127.0.0.1:8001',
                      );
                      final productLink = Uri.parse(
                        web,
                      ).resolve('/products/$code');
                      final uri = Uri.https('wa.me', '/$phone', {
                        'text':
                            'Halo Motifnesia, saya tertarik dengan ${productName(product)} ukuran $size ( ${money(productPrice(product))} ). $productLink',
                      });
                      if (!await launchUrl(
                            uri,
                            mode: LaunchMode.externalApplication,
                          ) &&
                          mounted)
                        feedback('WhatsApp tidak dapat dibuka.');
                    },
            ),
          ]),
        ]),
      ),
      Block(
        child: StackGroup([
          const PageHeading('Detail produk'),
          Text(text(product['deskripsi'], 'Deskripsi belum tersedia.')),
          detailLine('Material', product['material']),
          detailLine('Proses', product['proses']),
          detailLine('SKU', product['sku']),
          if (text(product['filosofi_motif']).isNotEmpty) ...[
            const Divider(),
            const PageHeading('Filosofi motif'),
            Text(text(product['filosofi_motif'])),
          ],
        ]),
      ),
      PageHeading('Ulasan', subtitle: '${reviews.length} ulasan'),
      if (reviews.isEmpty) emptyMessage('Belum ada ulasan untuk produk ini.'),
      for (final review in reviews)
        Block(
          child: StackGroup([
            Text(
              text(asMap(review['user'])['name'], 'Pelanggan'),
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              '★ ${text(review['rating'])}  ·  ${date(review['created_at'])}',
            ),
            Text(text(review['deskripsi_ulasan'] ?? review['review'])),
          ], gap: 5),
        ),
      if (related.isNotEmpty) ...[
        const PageHeading('Koleksi lainnya'),
        ProductGrid(api: api, products: related),
      ],
    ], gap: 15);
  }

  void _sizeGuide() {
    String? suggested;
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      showDragHandle: true,
      builder: (sheet) => StatefulBuilder(
        builder: (context, setSheet) => SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(
            16,
            0,
            16,
            18 + MediaQuery.viewInsetsOf(sheet).bottom,
          ),
          child: StackGroup([
            FormView(
              embedded: true,
              title: 'Panduan ukuran',
              label: 'Cari ukuran',
              fields: const [
                FormFieldSpec(
                  'height',
                  'Tinggi badan (cm)',
                  kind: FieldKind.number,
                ),
                FormFieldSpec(
                  'weight',
                  'Berat badan (kg)',
                  kind: FieldKind.number,
                ),
              ],
              onSubmit: (fields, _) async {
                final height = number(fields['height']) / 100;
                final weight = number(fields['weight']);
                if (height <= 0 || weight <= 0)
                  throw const ApiFailure(
                    0,
                    'Masukkan tinggi dan berat yang valid.',
                    {},
                  );
                final bmi = weight / (height * height);
                setSheet(
                  () => suggested = bmi < 18.5
                      ? 'S'
                      : bmi < 23
                      ? 'M'
                      : bmi < 27.5
                      ? 'L'
                      : 'XL',
                );
              },
            ),
            if (suggested != null)
              Notice(
                icon: Icons.straighten_outlined,
                title: 'Rekomendasi ukuran $suggested',
                detail: 'Cek ketersediaan ukuran di detail produk.',
                end: FilledButton(
                  onPressed: () {
                    final available = whole(
                      asMap(asMap(data['product'])['size_stocks'])[suggested],
                    );
                    if (available > 0) setState(() => size = suggested);
                    Navigator.pop(sheet);
                  },
                  child: const Text('Kembali ke produk'),
                ),
              ),
          ]),
        ),
      ),
    );
  }
}
