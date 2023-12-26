import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:house_of_tomorrow/src/model/product.dart';
import 'package:house_of_tomorrow/src/service/theme_service_revised.dart';
import 'package:house_of_tomorrow/theme/component/rating.dart';
import 'package:house_of_tomorrow/util/helper/intl_helper.dart';
import 'package:house_of_tomorrow/util/route_path.dart';

class ProductCard extends ConsumerWidget {
  const ProductCard({super.key, required this.product});

  final Product product;

  @override
  Widget build(context, ref) {
    final theme = ref.watch(themeServiceProvider);
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          RoutePath.product,
          arguments: product,
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: theme.color.surface,
            boxShadow: theme.deco.shadow,
            borderRadius: BorderRadius.circular(16)),
        child: Column(
          children: [
            if (product.productColorList.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  product.productColorList.first.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            const SizedBox(height: 4),
            Text(
              product.name.toString(),
              style: theme.typo.headline4.copyWith(
                fontWeight: theme.typo.semiBold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              product.brand.toString(),
              style: theme.typo.headline4.copyWith(
                fontWeight: theme.typo.light,
                color: theme.color.subtext,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Expanded(
                  child: Text(
                    IntlHelper.currency(
                      symbol: product.priceUnit,
                      number: product.price,
                    ),
                    style: theme.typo.subtitle2,
                  ),
                ),
                Rating(rating: product.rating),
              ],
            )
          ],
        ),
      ),
    );
  }
}
