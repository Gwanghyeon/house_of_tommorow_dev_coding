import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:house_of_tomorrow/src/service/theme_service.dart';
import 'package:house_of_tomorrow/theme/component/asset_icon.dart';

class Tile extends ConsumerWidget {
  const Tile({
    super.key,
    required this.icon,
    required this.title,
    required this.subTitle,
    required this.onPressed,
  });

  final String icon;
  final String title;
  final String subTitle;
  final void Function() onPressed;

  @override
  Widget build(context, ref) {
    final theme = ref.watch(themeServiceProvider);
    return GestureDetector(
      onTap: onPressed,

      /// default:HitTestBehavior.deferToCHild -> 투명한 대상 이벤트 수신 불가
      /// translucent: 반투명 + 시각적으로 뒤에 있는 대상도 이벤트 수신
      /// opaque: 뒤에 있는 대상은 이벤트 수신 불가
      behavior: HitTestBehavior.translucent,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            /// Start
            AssetIcon(icon),
            const SizedBox(width: 8),

            /// Title
            Expanded(
                child: Text(
              title,
              style: theme.typo.headline6,
            )),
            const SizedBox(width: 8),

            /// SubTitle
            Text(
              subTitle,
              style: theme.typo.subtitle1.copyWith(
                color: theme.color.primary,
              ),
            ),
            const SizedBox(width: 8),

            /// EndIcon
            const AssetIcon('chevron-right'),
          ],
        ),
      ),
    );
  }
}
