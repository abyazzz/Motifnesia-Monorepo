import 'package:flutter/material.dart';
import 'package:motifnesia_mobile/core/api/api_contract.dart';
import 'package:motifnesia_mobile/shared/forms/form_view.dart';
import 'package:motifnesia_mobile/shared/layouts/api_page.dart';
import 'package:motifnesia_mobile/shared/widgets/action_controls.dart';
import 'package:motifnesia_mobile/shared/widgets/layout_blocks.dart';
import 'package:motifnesia_mobile/shared/widgets/metrics.dart';

class SuppliersPage extends ApiPage {
  const SuppliersPage(super.arguments, {super.key});

  @override
  ApiPageState<SuppliersPage> createState() => _SuppliersPageState();
}

class _SuppliersPageState extends ApiPageState<SuppliersPage> {
  @override
  Widget buildContent() {
    final suppliers = records(data['suppliers']);
    return StackGroup([
      PageHeading(
        'Supplier',
        trailing: IconButton.filledTonal(
          tooltip: 'Tambah supplier',
          icon: const Icon(Icons.add),
          onPressed: () => prompt(
            'Tambah supplier',
            '/admin/suppliers',
            _supplierFields({}),
          ),
        ),
      ),
      if (suppliers.isEmpty) emptyMessage('Belum ada supplier.'),
      for (final supplier in suppliers)
        Block(
          child: StackGroup([
            PageHeading(
              text(supplier['name']),
              subtitle: text(supplier['contact_person']),
              trailing: statusBadge(
                context,
                supplier['status'] == 'active' ? 'Aktif' : 'Nonaktif',
              ),
            ),
            detailLine('Email', supplier['email']),
            detailLine('Telepon', supplier['phone']),
            detailLine('Alamat', supplier['address']),
            detailLine('Pengadaan', supplier['procurements_count']),
            detailLine('Akun login', asMap(supplier['user'])['name']),
            if (text(supplier['notes']).isNotEmpty)
              detailLine('Catatan', supplier['notes']),
            actionGroup([
              actionButton(
                'Ubah',
                Icons.edit_outlined,
                () => prompt(
                  'Ubah supplier',
                  '/admin/suppliers/${idOf(supplier)}',
                  _supplierFields(supplier),
                  method: 'PUT',
                ),
              ),
              if (supplier['status'] == 'active')
                actionButton(
                  'Nonaktifkan',
                  Icons.block_outlined,
                  () => confirm(
                    'Nonaktifkan supplier ini?',
                    '/admin/suppliers/${idOf(supplier)}',
                    method: 'DELETE',
                  ),
                ),
            ]),
          ], gap: 6),
        ),
      pagination(data['suppliers']),
    ]);
  }

  List<FormFieldSpec> _supplierFields(Json supplier) => [
    FormFieldSpec('name', 'Nama supplier', initial: supplier['name']),
    FormFieldSpec(
      'contact_person',
      'Kontak',
      initial: supplier['contact_person'] ?? '',
      required: false,
    ),
    FormFieldSpec(
      'email',
      'Email',
      kind: FieldKind.email,
      initial: supplier['email'],
      required: false,
    ),
    FormFieldSpec(
      'phone',
      'Telepon',
      initial: supplier['phone'],
      required: false,
    ),
    FormFieldSpec(
      'address',
      'Alamat',
      kind: FieldKind.multiline,
      initial: supplier['address'],
      required: false,
    ),
    FormFieldSpec(
      'status',
      'Status',
      kind: FieldKind.choice,
      initial: supplier['status'] ?? 'active',
      options: const {'active': 'Aktif', 'inactive': 'Nonaktif'},
    ),
    FormFieldSpec(
      'notes',
      'Catatan',
      initial: supplier['notes'],
      required: false,
    ),
    const FormFieldSpec(
      'password',
      'Sandi akun supplier',
      kind: FieldKind.secret,
      required: false,
    ),
  ];
}
