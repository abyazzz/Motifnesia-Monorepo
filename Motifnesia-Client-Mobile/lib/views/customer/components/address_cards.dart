import 'package:flutter/material.dart';
import 'package:motifnesia_mobile/core/api/api_contract.dart';
import 'package:motifnesia_mobile/shared/forms/form_view.dart';
import 'package:motifnesia_mobile/shared/layouts/api_page.dart';
import 'package:motifnesia_mobile/shared/widgets/action_controls.dart';
import 'package:motifnesia_mobile/shared/widgets/layout_blocks.dart';

mixin AddressCards<T extends ApiPage> on ApiPageState<T> {
  List<Widget> addressCards({required bool editable}) {
    final addresses = records(data['addresses']);
    return [
      PageHeading(
        'Alamat',
        trailing: editable
            ? IconButton.filledTonal(
                tooltip: 'Tambah alamat',
                icon: const Icon(Icons.add),
                onPressed: () => prompt(
                  'Tambah alamat',
                  '/profile/addresses',
                  _addressFields({}),
                ),
              )
            : null,
      ),
      if (addresses.isEmpty) emptyMessage('Belum ada alamat.'),
      for (final address in addresses)
        Block(
          child: StackGroup([
            PageHeading(
              text(address['label'], 'Alamat'),
              subtitle: text(address['recipient_name']),
              trailing: truth(address['is_primary'])
                  ? statusBadge(context, 'Utama')
                  : null,
            ),
            Text(
              [
                    address['address_line'],
                    address['city'],
                    address['province'],
                    address['postal_code'],
                  ]
                  .map((value) => text(value))
                  .where((value) => value.isNotEmpty)
                  .join(', '),
            ),
            Text(text(address['phone_number'])),
            if (editable)
              actionGroup([
                actionButton(
                  'Ubah',
                  Icons.edit_outlined,
                  () => prompt(
                    'Ubah alamat',
                    '/profile/addresses/${idOf(address)}/update',
                    _addressFields(address),
                  ),
                ),
                if (!truth(address['is_primary']))
                  actionButton(
                    'Jadikan utama',
                    Icons.star_outline,
                    () => action(
                      '/profile/addresses/${idOf(address)}/set-primary',
                    ),
                  ),
                actionButton(
                  'Hapus',
                  Icons.delete_outline,
                  () => confirm(
                    'Hapus alamat ini?',
                    '/profile/addresses/${idOf(address)}',
                    method: 'DELETE',
                  ),
                ),
              ]),
          ], gap: 6),
        ),
    ];
  }

  List<FormFieldSpec> _addressFields(Json address) => [
    for (final field in const {
      'label': 'Label alamat',
      'recipient_name': 'Nama penerima',
      'phone_number': 'Telepon',
      'address_line': 'Alamat lengkap',
      'city': 'Kota',
      'province': 'Provinsi',
      'postal_code': 'Kode pos',
      'notes': 'Catatan',
    }.entries)
      FormFieldSpec(
        field.key,
        field.value,
        initial: address[field.key],
        required: !['label', 'notes'].contains(field.key),
      ),
  ];
}
