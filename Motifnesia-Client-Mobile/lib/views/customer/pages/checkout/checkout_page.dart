import 'dart:math';
import 'package:flutter/material.dart';
import 'package:motifnesia_mobile/app/routes/navigation.dart';
import 'package:motifnesia_mobile/core/api/api_contract.dart';
import 'package:motifnesia_mobile/shared/forms/form_view.dart';
import 'package:motifnesia_mobile/shared/layouts/api_page.dart';
import 'package:motifnesia_mobile/shared/widgets/action_controls.dart';
import 'package:motifnesia_mobile/shared/widgets/layout_blocks.dart';
import 'package:motifnesia_mobile/shared/widgets/metrics.dart';

class CheckoutPage extends ApiPage {
  const CheckoutPage(super.arguments, {super.key});

  @override
  ApiPageState<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends ApiPageState<CheckoutPage> {
  @override
  Widget buildContent() {
    final shipping = records(data['metodePengiriman']);
    final payment = records(data['metodePembayaran']);
    final vouchers = records(data['memberVouchers']);
    return StackGroup([
      Block(
        child: StackGroup([
          const PageHeading('Item pesanan'),
          for (final product in records(data['products']))
            detailLine(
              '${productName(product)} · ${text(product['ukuran'])} × ${text(product['qty'])}',
              money(number(productPrice(product)) * whole(product['qty'])),
            ),
          const Divider(),
          detailLine('Subtotal', money(data['subtotalProduk'])),
          if (number(data['tierDiscount']) > 0)
            detailLine('Diskon member', money(data['tierDiscount'])),
        ]),
      ),
      inlineForm(
        [
          FormFieldSpec(
            'alamat',
            'Alamat pengiriman',
            kind: FieldKind.multiline,
            initial: data['defaultAddress'],
          ),
          FormFieldSpec(
            'metode_pengiriman_id',
            'Metode pengiriman',
            kind: FieldKind.choice,
            options: {
              for (final item in shipping)
                idOf(
                  item,
                ): '${text(item['nama_pengiriman'])} · ${money(item['harga'])}',
            },
          ),
          FormFieldSpec(
            'metode_pembayaran_id',
            'Metode pembayaran',
            kind: FieldKind.choice,
            options: {
              for (final item in payment)
                idOf(item): text(item['nama_pembayaran']),
            },
          ),
          if (vouchers.isNotEmpty)
            FormFieldSpec(
              'voucher_code',
              'Voucher member',
              kind: FieldKind.choice,
              required: false,
              options: {
                '': 'Tanpa voucher',
                for (final item in vouchers)
                  text(
                    item['voucher_code'],
                  ): '${text(item['voucher_code'])} · ${text(asMap(item['reward'])['discount_label'])}',
              },
              initial: '',
            ),
        ],
        '/checkout/store',
        label: 'Lanjut ke pembayaran',
        summary: (values) {
          final method = shipping
              .where(
                (item) => idOf(item) == text(values['metode_pengiriman_id']),
              )
              .firstOrNull;
          final voucher = vouchers
              .where(
                (item) =>
                    text(item['voucher_code']) == text(values['voucher_code']),
              )
              .firstOrNull;
          final reward = asMap(voucher?['reward']);
          final fee = number(method?['harga']);
          final subtotal = number(data['subtotalProduk']);
          final tier = number(data['tierDiscount']);
          final price = number(reward['discount_value']);
          final cap = number(reward['max_discount_value']);
          final percent = ((subtotal - tier) * price / 100).floor();
          final discount = switch (reward['discount_type']) {
            'fixed' => price,
            'percent' => cap > 0 ? min(percent, cap) : percent,
            'free_shipping' => fee,
            _ => 0,
          };
          return StackGroup([
            detailLine('Estimasi ongkos kirim', money(fee)),
            if (discount > 0)
              detailLine(
                'Estimasi potongan voucher',
                money(min(discount, subtotal - tier + fee)),
              ),
            detailLine(
              'Estimasi total',
              money(max(0, subtotal + fee - tier - discount)),
            ),
          ], gap: 2);
        },
      ),
      actionButton(
        'Kelola alamat',
        Icons.location_on_outlined,
        () => openPage(context, '/profile/edit'),
      ),
    ]);
  }
}
