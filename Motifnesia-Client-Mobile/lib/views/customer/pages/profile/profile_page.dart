import 'package:flutter/material.dart';
import 'package:motifnesia_mobile/app/routes/navigation.dart';
import 'package:motifnesia_mobile/core/api/api_contract.dart';
import 'package:motifnesia_mobile/core/api/motifnesia_api.dart';
import 'package:motifnesia_mobile/shared/forms/form_view.dart';
import 'package:motifnesia_mobile/shared/layouts/api_page.dart';
import 'package:motifnesia_mobile/shared/widgets/action_controls.dart';
import 'package:motifnesia_mobile/shared/widgets/layout_blocks.dart';
import 'package:motifnesia_mobile/shared/widgets/metrics.dart';
import 'package:motifnesia_mobile/shared/widgets/photo.dart';
import 'package:motifnesia_mobile/views/customer/components/address_cards.dart';

class ProfilePage extends ApiPage {
  const ProfilePage(super.arguments, {super.key});

  @override
  ApiPageState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ApiPageState<ProfilePage>
    with AddressCards<ProfilePage> {
  @override
  Widget buildContent() {
    final profile = asMap(data['userProfile']);
    final history = records(data['purchaseHistory']);
    return StackGroup([
      Block(
        child: StackGroup([
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Photo(
              api,
              profile['profile_pic_url'],
              width: 52,
              height: 52,
            ),
            title: Text(text(profile['full_name'], 'Akun saya')),
            subtitle: Text(text(profile['email'])),
          ),
          detailLine('Username', profile['username']),
          detailLine('Telepon', profile['phone_number']),
          detailLine('Tanggal lahir', date(profile['birth_date'])),
          detailLine('Jumlah pesanan', data['totalOrders']),
          detailLine('Total belanja', money(session.viewer['total_spending'])),
          actionGroup([
            actionButton(
              'Ubah profil',
              Icons.edit_outlined,
              () => openPage(context, '/profile/edit'),
            ),
            actionButton(
              'Membership',
              Icons.workspace_premium_outlined,
              () => openPage(context, '/membership'),
            ),
          ]),
        ]),
      ),
      ...addressCards(editable: false),
      const PageHeading('Riwayat belanja'),
      if (history.isEmpty) emptyMessage('Belum ada pesanan.'),
      for (final item in history)
        Block(
          child: StackGroup([
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Photo(api, productImage(item), width: 52, height: 52),
              title: Text(productName(item)),
              subtitle: Text(
                'Pesanan #${text(item['order_id'])} · ${text(item['ukuran'])} × ${text(item['qty'])}',
              ),
            ),
            detailLine('Status', item['status_nama']),
            detailLine('Subtotal', money(item['subtotal'])),
            actionGroup([
              if (truth(item['can_confirm_arrival']))
                actionButton(
                  'Pesanan sampai',
                  Icons.task_alt,
                  () => confirm(
                    'Konfirmasi barang sudah diterima?',
                    '/orders/${item['order_id']}/confirm-arrived',
                  ),
                ),
              if (truth(item['can_review']))
                actionButton(
                  'Beri ulasan',
                  Icons.rate_review_outlined,
                  () => prompt(
                    'Beri ulasan',
                    '/order-reviews',
                    const [
                      FormFieldSpec(
                        'rating',
                        'Rating',
                        kind: FieldKind.choice,
                        initial: '5',
                        options: {
                          '5': '5 bintang',
                          '4': '4 bintang',
                          '3': '3 bintang',
                          '2': '2 bintang',
                          '1': '1 bintang',
                        },
                      ),
                      FormFieldSpec(
                        'deskripsi_ulasan',
                        'Ulasan',
                        kind: FieldKind.multiline,
                        required: false,
                      ),
                    ],
                    extra: {'order_item_id': item['order_item_id']},
                  ),
                ),
              if (truth(item['has_reviewed']))
                actionButton(
                  'Lihat ulasan',
                  Icons.star_outline,
                  () => _showOrderReview(item),
                ),
              if (truth(item['can_return']))
                actionButton(
                  'Ajukan retur',
                  Icons.assignment_return_outlined,
                  () => openPage(
                    context,
                    '/returns/create/${item['order_item_id']}',
                  ),
                ),
              if (truth(item['has_return']))
                actionButton(
                  'Lihat retur',
                  Icons.assignment_return_outlined,
                  () => openPage(context, '/returns'),
                ),
            ]),
          ], gap: 6),
        ),
    ]);
  }

  Future<void> _showOrderReview(Json item) async {
    try {
      final result = await api.get('/order-reviews/${item['order_item_id']}');
      if (!mounted) return;
      final review = asMap(result['review']);
      await showDialog<void>(
        context: context,
        builder: (dialog) => AlertDialog(
          title: const Text('Ulasan saya'),
          content: Text(
            '★ ${text(review['rating'])}\n${text(review['deskripsi_ulasan'])}',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialog),
              child: const Text('Tutup'),
            ),
          ],
        ),
      );
    } on ApiFailure catch (error) {
      feedback(error.message);
    }
  }
}
