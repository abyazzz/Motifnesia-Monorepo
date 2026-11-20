import 'package:motifnesia_mobile/core/api/api_contract.dart';
import 'package:motifnesia_mobile/shared/forms/form_view.dart';

List<FormFieldSpec> rewardFields(Json reward) => [
  FormFieldSpec('title', 'Judul reward', initial: reward['title']),
  FormFieldSpec(
    'description',
    'Deskripsi',
    kind: FieldKind.multiline,
    initial: reward['description'],
    required: false,
  ),
  FormFieldSpec(
    'points_required',
    'Poin diperlukan',
    kind: FieldKind.number,
    initial: reward['points_required'],
  ),
  FormFieldSpec(
    'discount_type',
    'Jenis diskon',
    kind: FieldKind.choice,
    initial: reward['discount_type'] ?? 'fixed',
    options: const {
      'fixed': 'Potongan nominal',
      'percent': 'Potongan persen',
      'free_shipping': 'Gratis ongkir',
    },
  ),
  FormFieldSpec(
    'discount_value',
    'Nilai diskon',
    kind: FieldKind.number,
    initial: reward['discount_value'] ?? '0',
  ),
  FormFieldSpec(
    'max_discount_value',
    'Batas maksimum diskon',
    kind: FieldKind.number,
    initial: reward['max_discount_value'],
    required: false,
  ),
  FormFieldSpec(
    'is_active',
    'Reward aktif',
    kind: FieldKind.toggle,
    initial: reward['is_active'] ?? true,
  ),
];
