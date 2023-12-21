import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:house_of_tomorrow/src/service/theme_service_revised.dart';
import 'package:house_of_tomorrow/theme/component/bottom_sheet/base_bottom_sheet.dart';
import 'package:house_of_tomorrow/theme/component/button/button.dart';
import 'package:house_of_tomorrow/util/lang/generated/l10n.dart';

class ShoppingView extends ConsumerWidget {
  const ShoppingView({super.key});

  @override
  Widget build(context, ref) {
    final themeService = ref.watch(themeServiceProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(S.current.shopping),
        actions: [
          Button(
            icon: 'option',
            type: ButtonType.flat,
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) => const BaseBottomSheet(
                  child: Text('hello bottom sheet'),
                ),
              );
            },
          )
        ],
      ),
      body: Center(
        child: TextButton(
          onPressed: ref.read(themeServiceProvider.notifier).toggleTheme,
          child: Text(
            "Toggle Theme",
            style: themeService.typo.headline6,
          ),
        ),
      ),
    );
  }
}
