// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:house_of_tomorrow/src/service/cart_service.dart';
import 'package:house_of_tomorrow/src/service/theme_service.dart';

// 장바구니 아이콘위에서 현재 추가된 아이템의 개수 표시
class CounterBadge extends ConsumerWidget {
  final Widget child;

  const CounterBadge({
    super.key,
    required this.child,
  });

  @override
  Widget build(context, ref) {
    final theme = ref.watch(themeServiceProvider);
    final counter = ref.watch(cartServiceProvider).cartItemList.length;

    // 특정 위젯 위에 표시되어야 하기에 Stack사용
    return Stack(
      alignment: Alignment.center,
      children: [
        // Cart button
        child,

        // Counter Badge
        Positioned(
          top: 10,
          right: 6,
          child: IgnorePointer(
            ignoring: true,
            child: CircleAvatar(
              backgroundColor: theme.color.secondary,
              radius: counter > 0 ? 10 : 0, // 반지름: 0인 경우 위젯 숨김
              child: Text(
                '$counter',
                style: theme.typo.body2.copyWith(
                  color: theme.color.onSecondary,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
