import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:house_of_tomorrow/src/model/product.dart';
import 'package:house_of_tomorrow/src/service/theme_service.dart';
import 'package:house_of_tomorrow/theme/component/rating.dart';

import '../../../../util/lang/generated/l10n.dart';

// For Showing the Description of the product
class ProductDesc extends ConsumerWidget {
  const ProductDesc({super.key, required this.product});

  final Product product;

  @override
  Widget build(context, ref) {
    final theme = ref.watch(themeServiceProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          Row(
            children: [
              /// Title
              Expanded(
                child: Text(
                  S.current.description,
                  style: theme.typo.headline4.copyWith(
                    fontWeight: theme.typo.semiBold,
                  ),
                ),
              ),

              /// Rating
              Rating(rating: product.rating),
            ],
          ),
          const SizedBox(height: 24),

          /// Content
          Text(
            product.desc.toString(),
            style: theme.typo.headline6.copyWith(
              color: theme.color.subtext,
            ),
          )
        ],
      ),
    );
  }
}
