import 'package:flutter/material.dart';

// 포커스 위젯 외부 클릭시 unfoucs를 위한 위젯
// 키보드 외부 클릭 시 키보드를 숨기는 기능 구현
// ShoppingView의 Scaffold 부모로 선언
class HideKeyboard extends StatelessWidget {
  const HideKeyboard({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        // 현재 포커스가 되어있는 위젯의 정보를 받아올 수 있음
        onTap: FocusManager.instance.primaryFocus?.unfocus,
        child: child);
  }
}
