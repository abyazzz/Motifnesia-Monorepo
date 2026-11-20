import 'package:flutter/material.dart';
import 'package:motifnesia_mobile/app/routes/navigation.dart';
import 'package:motifnesia_mobile/core/api/api_contract.dart';
import 'package:motifnesia_mobile/core/api/motifnesia_api.dart';
import 'package:motifnesia_mobile/shared/widgets/action_controls.dart';
import 'package:motifnesia_mobile/shared/widgets/layout_blocks.dart';
import 'package:motifnesia_mobile/shared/widgets/photo.dart';

class ProductGrid extends StatelessWidget {
  const ProductGrid({super.key, required this.api, required this.products});
  final MotifnesiaApi api;
  final List<Json> products;
  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, size) {
      final columns = size.maxWidth >= 950 ? 4 : (size.maxWidth >= 630 ? 3 : 2);
      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: products.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: columns,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          mainAxisExtent: size.maxWidth >= 630 ? 276 : 232,
        ),
        itemBuilder: (_, index) {
          final product = products[index];
          return Card(
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: () => openPage(context, '/products/${idOf(product)}'),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Photo(api, productImage(product), radius: 0),
                        if (whole(product['diskon_persen']) > 0)
                          Positioned(
                            top: 8,
                            left: 8,
                            child: statusBadge(
                              context,
                              '-${product['diskon_persen']}%',
                            ),
                          ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: StackGroup([
                      Text(
                        productName(product),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      Text(
                        money(productPrice(product)),
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text(
                        '★ ${text(product['rating'], '0')}  ·  Terjual ${whole(product['terjual'])}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ], gap: 4),
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}
