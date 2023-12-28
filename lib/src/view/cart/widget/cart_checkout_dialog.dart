import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:house_of_tomorrow/src/service/cart_service.dart';
import 'package:house_of_tomorrow/src/service/theme_service.dart';
import 'package:house_of_tomorrow/theme/component/base_dialog.dart';
import 'package:house_of_tomorrow/theme/component/button/button.dart';
import 'package:house_of_tomorrow/util/lang/generated/l10n.dart';

class CartCheckoutDialog extends ConsumerWidget {
  const CartCheckoutDialog({super.key});

  @override
  Widget build(context, ref) {
    final theme = ref.read(themeServiceProvider);
    final cartServiceNotifier = ref.read(cartServiceProvider.notifier);

    return BaseDialog(
      title: S.current.checkout,
      content: Text(
        S.current.checkoutDialogDesc,
        style: theme.typo.headline6,
      ),
      actions: [
        // Checkout
        Button(
          text: S.current.checkout,
          width: double.infinity,
          color: theme.color.onPrimary,
          backgroundColor: theme.color.primary,
          onPressed: () {
            Navigator.pop(context);
            cartServiceNotifier
                .delete(cartServiceNotifier.selectedCartItemList);
          },
        ),

        const SizedBox(height: 12),

        // Cancel
        Button(
          text: S.current.cancel,
          width: double.infinity,
          color: theme.color.text,
          borderColor: theme.color.hint,
          type: ButtonType.outline,
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }
}
