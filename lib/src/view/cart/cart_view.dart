import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../theme/component/button/button.dart';
import '../../../theme/component/pop_button.dart';
import '../../../util/helper/intl_helper.dart';
import '../../../util/lang/generated/l10n.dart';
import '../../service/cart_service.dart';
import '../../service/theme_service.dart';
import 'widget/cart_widgets.dart';

// 장바구니 표시
class CartView extends ConsumerWidget {
  const CartView({super.key});

  @override
  Widget build(context, ref) {
    final theme = ref.watch(themeServiceProvider);
    final cartItemList = ref.watch(cartServiceProvider).cartItemList;

    // 장바구니에 추가된 상품의 총 가격
    final currentTotalPrice = cartItemList.fold(
      0,
      (previousValue, item) =>
          previousValue + (item.count * item.product.price),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(S.current.cart),
        leading: const PopButton(),
        titleSpacing: 0,
        actions: [
          // Delete Button
          Button(
            text: S.current.delete,
            type: ButtonType.flat,
            color: theme.color.secondary,
            isInactive: ref
                .read(cartServiceProvider.notifier)
                .selectedCartItemList
                .isEmpty,
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => const CartDeleteDialog(),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: cartItemList.isEmpty
                // When the cart is empty
                ? const CartEmpty()

                // Showing the products in cart
                : ListView.builder(
                    itemCount: cartItemList.length,
                    itemBuilder: (BuildContext context, int index) {
                      final item = cartItemList[index];
                      return CartItemTile(
                        cartItem: item,
                        // Select Item
                        onPressed: () {
                          ref.read(cartServiceProvider.notifier).update(index,
                              item.copyWith(isSelected: !item.isSelected));
                        },

                        // Increase & Decrease amount of the order
                        onCountChanged: (count) {
                          ref
                              .read(cartServiceProvider.notifier)
                              .update(index, item.copyWith(count: count));
                        },
                      );
                    },
                  ),
          ),

          // Cart Bottom Sheet
          CartBottomSheet(
            totalPrice: cartItemList.isEmpty
                ? '0'
                : IntlHelper.currency(
                    symbol: cartItemList.first.product.priceUnit,
                    number: currentTotalPrice,
                  ),
            selectedCartItemList:
                ref.watch(cartServiceProvider.notifier).selectedCartItemList,
            onCheckoutPressed: () {
              showDialog(
                context: context,
                builder: (context) => const CartCheckoutDialog(),
              );
            },
          ),
        ],
      ),
    );
  }
}
