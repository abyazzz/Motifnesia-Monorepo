import 'package:flutter/material.dart';
import 'package:motifnesia_mobile/core/api/api_contract.dart';
import 'package:motifnesia_mobile/core/api/motifnesia_api.dart';
import 'package:motifnesia_mobile/shared/widgets/brand.dart';
import 'package:motifnesia_mobile/shared/widgets/layout_blocks.dart';
import 'package:motifnesia_mobile/shared/widgets/photo.dart';

class CatalogBanner extends StatefulWidget {
  const CatalogBanner({required this.slides, required this.api});
  final List<Json> slides;
  final MotifnesiaApi api;

  @override
  State<CatalogBanner> createState() => _CatalogBannerState();
}

class _CatalogBannerState extends State<CatalogBanner> {
  final controller = PageController();
  int selected = 0;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final slides = widget.slides;
    final count = slides.isEmpty ? 1 : slides.length;
    const heroes = ['assets/images/hero_slide_1.png', catalogPortrait];
    return StackGroup([
      SizedBox(
        height: 220,
        child: PageView.builder(
          controller: controller,
          onPageChanged: (index) => setState(() => selected = index),
          itemCount: count,
          itemBuilder: (context, index) {
            final slide = slides.isEmpty ? <String, dynamic>{} : slides[index];
            return ClipRRect(
              borderRadius: BorderRadius.circular(22),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  if (text(slide['gambar']).isEmpty)
                    Image.asset(
                      heroes[index % heroes.length],
                      fit: BoxFit.cover,
                    )
                  else
                    Photo(widget.api, slide['gambar'], radius: 0),
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Color(0xee131313),
                          Color(0x55232423),
                          Color(0x00232423),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 272),
                        child: StackGroup([
                          Text(
                            text(slide['judul'], 'Batik Nusantara'),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.white,
                              fontFamily: 'serif',
                              fontWeight: FontWeight.bold,
                              fontSize: 33,
                              height: 1.08,
                            ),
                          ),
                          Text(
                            text(
                              slide['caption'],
                              'Kenali motif dan temukan batik untuk setiap kesempatan.',
                            ),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(color: Color(0xfff2e9d6)),
                          ),
                        ], gap: 8),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      if (count > 1)
        Wrap(
          alignment: WrapAlignment.center,
          children: [
            for (var index = 0; index < count; index++)
              IconButton(
                tooltip: 'Tampilkan slide ${index + 1}',
                iconSize: 12,
                onPressed: () => controller.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 260),
                  curve: Curves.easeOut,
                ),
                icon: Icon(
                  index == selected ? Icons.circle : Icons.circle_outlined,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
          ],
        ),
    ], gap: 0);
  }
}
