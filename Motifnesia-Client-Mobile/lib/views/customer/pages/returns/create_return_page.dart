import 'package:flutter/material.dart';
import 'package:motifnesia_mobile/core/api/api_contract.dart';
import 'package:motifnesia_mobile/shared/forms/form_view.dart';
import 'package:motifnesia_mobile/shared/layouts/api_page.dart';
import 'package:motifnesia_mobile/shared/widgets/layout_blocks.dart';

class CreateReturnPage extends ApiPage {
  const CreateReturnPage(super.arguments, {super.key});

  @override
  ApiPageState<CreateReturnPage> createState() => _CreateReturnPageState();
}

class _CreateReturnPageState extends ApiPageState<CreateReturnPage> {
  @override
  Widget buildContent() {
    final orderItem = asMap(data['orderItem']);
    return StackGroup([
      PageHeading(
        productName(asMap(orderItem['produk'])),
        subtitle: '${text(orderItem['ukuran'])} × ${text(orderItem['qty'])}',
      ),
      inlineForm(
        const [
          FormFieldSpec(
            'reason',
            'Alasan retur',
            kind: FieldKind.choice,
            options: {
              'Ukuran tidak sesuai': 'Ukuran tidak sesuai',
              'Barang rusak/cacat': 'Barang rusak/cacat',
              'Salah kirim produk': 'Salah kirim produk',
              'Tidak sesuai deskripsi': 'Tidak sesuai deskripsi',
              'Berubah pikiran': 'Berubah pikiran',
              'Lainnya': 'Lainnya',
            },
          ),
          FormFieldSpec(
            'action_type',
            'Solusi yang diinginkan',
            kind: FieldKind.choice,
            options: {
              'Refund': 'Pengembalian dana',
              'Tukar Barang': 'Tukar barang',
            },
          ),
          FormFieldSpec(
            'description',
            'Keterangan',
            kind: FieldKind.multiline,
            required: false,
          ),
          FormFieldSpec(
            'photo_proof',
            'Foto produk',
            kind: FieldKind.image,
            required: false,
          ),
        ],
        '/returns',
        extra: {'order_item_id': uri.pathSegments.last},
        label: 'Ajukan retur',
      ),
    ]);
  }
}
