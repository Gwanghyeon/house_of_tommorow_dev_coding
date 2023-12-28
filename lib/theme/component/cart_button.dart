// 화면 상단에 위치한 장바구니 버튼
import 'package:flutter/material.dart';
import 'package:house_of_tomorrow/theme/component/button/button.dart';
import 'package:house_of_tomorrow/theme/component/counter_badge.dart';
import 'package:house_of_tomorrow/util/route_path.dart';

class CartButton extends StatelessWidget {
  const CartButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CounterBadge(
      child: Button(
        icon: 'basket',
        type: ButtonType.flat,
        onPressed: () => Navigator.pushNamed(context, RoutePath.cart),
      ),
    );
  }
}
