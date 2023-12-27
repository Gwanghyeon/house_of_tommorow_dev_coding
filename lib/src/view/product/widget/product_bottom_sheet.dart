// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:house_of_tomorrow/src/model/product.dart';
import 'package:house_of_tomorrow/src/service/theme_service.dart';
import 'package:house_of_tomorrow/theme/component/bottom_sheet/base_bottom_sheet.dart';
import 'package:house_of_tomorrow/theme/component/button/button.dart';
import 'package:house_of_tomorrow/theme/component/counter_button.dart';
import 'package:house_of_tomorrow/util/helper/intl_helper.dart';
import 'package:house_of_tomorrow/util/lang/generated/l10n.dart';

class ProductBottomSheet extends ConsumerWidget {
  const ProductBottomSheet({
    super.key,
    required this.count,
    required this.product,
    required this.onCountChanged,
    required this.onAddToCartPressed,
  });

  final int count;
  final Product product;
  final void Function(int count) onCountChanged;
  final void Function() onAddToCartPressed;

  @override
  Widget build(context, ref) {
    final theme = ref.watch(themeServiceProvider);
    return BaseBottomSheet(
        padding: const EdgeInsets.only(
          top: 32,
          bottom: 16,
          left: 16,
          right: 16,
        ),
        child: Wrap(
          runSpacing: 16,
          children: [
            Row(
              children: [
                Text(
                  S.current.quantity,
                  style: theme.typo.headline3,
                ),
                const Spacer(),

                /// Counter Button
                CounterButton(count: count, onChanged: onCountChanged),
              ],
            ),
            Row(
              children: [
                Text(
                  S.current.totalPrice,
                  style: theme.typo.headline3,
                ),
                const Spacer(),

                /// Price of the product
                Text(
                  IntlHelper.currency(
                    symbol: product.priceUnit,
                    number: product.price * count,
                  ),
                  style: theme.typo.headline3.copyWith(
                    color: theme.color.primary,
                  ),
                ),
              ],
            ),

            /// 카트에 담기 버튼
            Button(
              width: double.infinity,
              size: ButtonSize.large,
              text: S.current.addToCart,
              onPressed: onAddToCartPressed,
            ),
          ],
        ));
  }
}