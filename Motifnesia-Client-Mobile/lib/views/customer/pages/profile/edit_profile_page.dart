import 'package:flutter/material.dart';
import 'package:motifnesia_mobile/core/api/api_contract.dart';
import 'package:motifnesia_mobile/shared/forms/form_view.dart';
import 'package:motifnesia_mobile/shared/layouts/api_page.dart';
import 'package:motifnesia_mobile/shared/widgets/layout_blocks.dart';
import 'package:motifnesia_mobile/views/customer/components/address_cards.dart';

class EditProfilePage extends ApiPage {
  const EditProfilePage(super.arguments, {super.key});

  @override
  ApiPageState<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends ApiPageState<EditProfilePage>
    with AddressCards<EditProfilePage> {
  @override
  Widget buildContent() {
    final profile = asMap(data['userProfile']);
    return StackGroup([
      inlineForm([
        FormFieldSpec('username', 'Username', initial: profile['username']),
        FormFieldSpec(
          'full_name',
          'Nama lengkap',
          initial: profile['full_name'],
          required: false,
        ),
        FormFieldSpec(
          'phone_number',
          'Nomor telepon',
          initial: profile['phone_number'],
          required: false,
        ),
        FormFieldSpec(
          'birth_date',
          'Tanggal lahir (YYYY-MM-DD)',
          initial: profile['birth_date'],
          required: false,
        ),
        FormFieldSpec(
          'gender',
          'Jenis kelamin',
          kind: FieldKind.choice,
          initial: profile['gender'],
          required: false,
          options: const {'L': 'Laki-laki', 'P': 'Perempuan'},
        ),
        const FormFieldSpec(
          'profile_photo',
          'Foto profil',
          kind: FieldKind.image,
          required: false,
        ),
      ], '/profile/edit'),
      ...addressCards(editable: true),
    ]);
  }
}
