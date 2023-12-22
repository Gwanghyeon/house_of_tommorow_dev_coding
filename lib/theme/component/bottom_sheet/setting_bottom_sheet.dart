import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:house_of_tomorrow/src/service/lang_service.dart';
import 'package:house_of_tomorrow/src/service/theme_service_revised.dart';
import 'package:house_of_tomorrow/theme/component/bottom_sheet/base_bottom_sheet.dart';
import 'package:house_of_tomorrow/theme/component/tile.dart';
import 'package:house_of_tomorrow/util/helper/intl_helper.dart';
import 'package:house_of_tomorrow/util/lang/generated/l10n.dart';

class SettingBottomSheet extends ConsumerWidget {
  const SettingBottomSheet({super.key});

  @override
  Widget build(context, ref) {
    final currentTheme = ref.watch(themeServiceProvider);
    final isLightTheme = currentTheme.brightness == Brightness.light;

    return BaseBottomSheet(
        child: Column(
      mainAxisSize: MainAxisSize.min, // 자식위젯의 크기에 맞춰 최소화
      children: [
        /// Theme Tile
        Tile(
          icon: isLightTheme ? 'sunny' : 'moon',
          title: S.current.theme,
          subTitle: isLightTheme ? S.current.light : S.current.dark,
          onPressed: ref.read(themeServiceProvider.notifier).toggleTheme,
        ),

        /// Language Tile
        Tile(
          icon: 'language',
          title: S.current.language,
          subTitle: IntlHelper.isKorean ? S.current.ko : S.current.en,
          onPressed: ref.watch(langServiceProvider.notifier).toggleLanguage,
        ),
      ],
    ));
  }
}
