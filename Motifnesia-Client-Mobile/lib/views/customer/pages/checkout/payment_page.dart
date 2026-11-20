import 'package:flutter/material.dart';
import 'package:motifnesia_mobile/core/api/api_contract.dart';
import 'package:motifnesia_mobile/shared/forms/form_view.dart';
import 'package:motifnesia_mobile/shared/layouts/api_page.dart';
import 'package:motifnesia_mobile/shared/widgets/layout_blocks.dart';
import 'package:motifnesia_mobile/shared/widgets/metrics.dart';
import 'package:motifnesia_mobile/views/customer/components/payment_deadline.dart';

class PaymentPage extends ApiPage {
  const PaymentPage(super.arguments, {super.key});

  @override
  ApiPageState<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends ApiPageState<PaymentPage> {
  @override
  Widget buildContent() {
    final checkout = asMap(data['checkoutData']);
    final method = asMap(checkout['metode_pembayaran']);
    return StackGroup([
      Block(
        child: StackGroup([
          PageHeading(text(method['nama'], 'Metode pembayaran')),
          if (text(method['deskripsi']).isNotEmpty)
            Text(text(method['deskripsi'])),
          PaymentDeadline(text(data['paymentDeadline'])),
          detailLine('Subtotal produk', money(checkout['subtotal_produk'])),
          detailLine('Ongkos kirim', money(checkout['total_ongkir'])),
          if (number(checkout['membership_tier_discount']) > 0)
            detailLine(
              'Diskon member',
              money(checkout['membership_tier_discount']),
            ),
          if (number(checkout['voucher_discount']) > 0)
            detailLine('Voucher', money(checkout['voucher_discount'])),
          const Divider(),
          detailLine('Total pembayaran', money(checkout['total_bayar'])),
        ]),
      ),
      inlineForm(
        const [
          FormFieldSpec('payment_number', 'Nomor pembayaran'),
          FormFieldSpec(
            'payment_proof',
            'Bukti pembayaran',
            kind: FieldKind.image,
          ),
        ],
        '/payment/store',
        label: 'Kirim bukti pembayaran',
      ),
    ]);
  }
}
