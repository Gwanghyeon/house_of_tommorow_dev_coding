import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:house_of_tomorrow/src/service/theme_service.dart';
import 'package:house_of_tomorrow/theme/component/asset_icon.dart';

// product bottom sheet에서 사용되는 상품 개수 증가, 감소 버튼
class CounterButton extends ConsumerWidget {
  const CounterButton(
      {super.key, required this.count, required this.onChanged});

  final int count;
  final void Function(int count) onChanged;

  @override
  Widget build(context, ref) {
    final theme = ref.watch(themeServiceProvider);
    // 1 보다 큰 경우에만 감소가 가능하도록 하기위한 변수
    bool isMinusActive = count > 1;
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 16,
      children: [
        /// Minus
        GestureDetector(
          onTap: () {
            if (!isMinusActive) return;
            onChanged(count - 1);
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 210),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: theme.color.surface,
              // 가능한 경우에만 그림자 적용
              boxShadow: isMinusActive ? theme.deco.shadow : null,
              borderRadius: BorderRadius.circular(99),
            ),
            child: AssetIcon(
              'minus',
              color: isMinusActive ? theme.color.primary : theme.color.inactive,
            ),
          ),
        ),

        /// Counter
        Text(
          '$count',
          style: theme.typo.headline4.copyWith(
            fontWeight: theme.typo.semiBold,
          ),
        ),

        /// Plus
        GestureDetector(
          onTap: () {
            onChanged(count + 1);
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 210),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: theme.color.surface,
              boxShadow: theme.deco.shadow,
              borderRadius: BorderRadius.circular(99),
            ),
            child: AssetIcon(
              'plus',
              color: theme.color.primary,
            ),
          ),
        ),
      ],
    );
  }
}
