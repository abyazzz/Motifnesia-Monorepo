import 'package:flutter/material.dart';
import 'package:motifnesia_mobile/app/routes/navigation.dart';
import 'package:motifnesia_mobile/core/api/api_contract.dart';
import 'package:motifnesia_mobile/shared/layouts/api_page.dart';
import 'package:motifnesia_mobile/shared/widgets/action_controls.dart';
import 'package:motifnesia_mobile/shared/widgets/layout_blocks.dart';
import 'package:motifnesia_mobile/shared/widgets/photo.dart';

class FavoritesPage extends ApiPage {
  const FavoritesPage(super.arguments, {super.key});

  @override
  ApiPageState<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends ApiPageState<FavoritesPage> {
  @override
  Widget buildContent() {
    final favorites = records(data['favorites']);
    return StackGroup([
      PageHeading('Produk favorit', subtitle: '${favorites.length} tersimpan'),
      if (favorites.isEmpty) emptyMessage('Belum ada produk favorit.'),
      for (final favorite in favorites)
        Block(
          child: StackGroup([
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Photo(
                api,
                productImage(asMap(favorite['produk'])),
                width: 55,
                height: 55,
              ),
              title: Text(productName(asMap(favorite['produk']))),
              subtitle: Text(money(productPrice(asMap(favorite['produk'])))),
              onTap: () =>
                  openPage(context, '/products/${text(favorite['produk_id'])}'),
            ),
            actionGroup([
              actionButton(
                'Tambah keranjang',
                Icons.add_shopping_cart,
                busy
                    ? null
                    : () => action('/favorites/${idOf(favorite)}/add-to-cart'),
              ),
              actionButton(
                'Hapus',
                Icons.delete_outline,
                () => confirm(
                  'Hapus produk dari favorit?',
                  '/favorites/${idOf(favorite)}',
                  method: 'DELETE',
                ),
              ),
            ]),
          ]),
        ),
    ]);
  }
}
