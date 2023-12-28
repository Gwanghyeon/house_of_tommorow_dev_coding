import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:house_of_tomorrow/src/model/cart_item.dart';
import 'package:house_of_tomorrow/src/service/theme_service.dart';
import 'package:house_of_tomorrow/theme/component/asset_icon.dart';
import 'package:house_of_tomorrow/theme/component/counter_button.dart';
import 'package:house_of_tomorrow/util/helper/intl_helper.dart';

class CartItemTile extends ConsumerWidget {
  const CartItemTile({
    super.key,
    required this.cartItem,
    required this.onPressed,
    required this.onCountChanged,
  });

  final CartItem cartItem;
  final void Function() onPressed;
  final void Function(int count) onCountChanged;

  @override
  Widget build(context, ref) {
    final theme = ref.watch(themeServiceProvider);
    final productColor = cartItem.product.productColorList[cartItem.colorIdx];

    return GestureDetector(
      behavior: HitTestBehavior.translucent, // 비어있는 공간 탭시에도 이벤트 호출
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Image Part
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: CachedNetworkImage(
                    imageUrl: productColor.imageUrl,
                    width: 92,
                    height: 92,
                    fit: BoxFit.cover,
                    color: theme.color.background,
                    colorBlendMode: BlendMode.darken,
                  ),
                ),

                // Check Icon
                AssetIcon(
                  cartItem.isSelected ? 'check' : 'uncheck',
                  color: cartItem.isSelected
                      ? theme.color.primary
                      : theme.color.inactive,
                  size: 32,
                ),
              ],
            ),

            const SizedBox(width: 12),

            // Contents Part
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Product Name
                Text(
                  cartItem.product.name.toString(),
                  style: theme.typo.headline5,
                ),

                const SizedBox(height: 12),

                Row(
                  children: [
                    // Price
                    Text(
                      IntlHelper.currency(
                        symbol: cartItem.product.priceUnit,
                        number: cartItem.product.price * cartItem.count,
                      ),
                      style: theme.typo.subtitle1.copyWith(
                        color: theme.color.subtext,
                      ),
                    ),
                    const Spacer(),
                    // CounterButton
                    CounterButton(
                      count: cartItem.count,
                      onChanged: onCountChanged,
                    )
                  ],
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
