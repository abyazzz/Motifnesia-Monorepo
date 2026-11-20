import 'package:flutter/material.dart';
import 'package:motifnesia_mobile/core/api/api_contract.dart';
import 'package:motifnesia_mobile/shared/forms/form_view.dart';
import 'package:motifnesia_mobile/shared/layouts/api_page.dart';
import 'package:motifnesia_mobile/shared/widgets/action_controls.dart';
import 'package:motifnesia_mobile/shared/widgets/layout_blocks.dart';
import 'package:motifnesia_mobile/shared/widgets/metrics.dart';
import 'package:motifnesia_mobile/shared/widgets/photo.dart';

class SlidesPage extends ApiPage {
  const SlidesPage(super.arguments, {super.key});

  @override
  ApiPageState<SlidesPage> createState() => _SlidesPageState();
}

class _SlidesPageState extends ApiPageState<SlidesPage> {
  @override
  Widget buildContent() {
    final slides = records(data['slides']);
    return StackGroup([
      PageHeading(
        'Slideshow',
        subtitle: '${slides.length} slide',
        trailing: IconButton.filledTonal(
          tooltip: 'Tambah slide',
          icon: const Icon(Icons.add),
          onPressed: () =>
              prompt('Tambah slide', '/admin/konten/slides/create', const [
                FormFieldSpec('judul', 'Judul slide', required: false),
                FormFieldSpec('gambar', 'Gambar slide', kind: FieldKind.image),
              ]),
        ),
      ),
      if (slides.isEmpty) emptyMessage('Belum ada slide.'),
      for (final slide in slides)
        Block(
          child: StackGroup([
            Photo(api, slide['gambar'], height: 180),
            PageHeading(text(slide['judul'], 'Slide ${text(slide['urutan'])}')),
            detailLine('Urutan', slide['urutan']),
            actionGroup([
              actionButton(
                'Ubah',
                Icons.edit_outlined,
                () => prompt(
                  'Ubah slide',
                  '/admin/konten/slides/${idOf(slide)}/update',
                  [
                    FormFieldSpec(
                      'judul',
                      'Judul slide',
                      required: false,
                      initial: slide['judul'] ?? '',
                    ),
                    const FormFieldSpec(
                      'gambar',
                      'Gambar pengganti',
                      kind: FieldKind.image,
                      required: false,
                    ),
                  ],
                ),
              ),
              actionButton(
                'Hapus',
                Icons.delete_outline,
                () => confirm(
                  'Hapus slide ini?',
                  '/admin/konten/slides/${idOf(slide)}/delete',
                ),
              ),
            ]),
          ]),
        ),
    ]);
  }
}
