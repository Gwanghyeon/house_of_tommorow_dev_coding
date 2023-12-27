// 여러 위젯에서 사용 가능하기에 theme/component에 선언

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:house_of_tomorrow/src/service/theme_service.dart';

class ColorPicker extends ConsumerWidget {
  const ColorPicker({
    super.key,
    required this.colorIdx,
    required this.colorList,
    required this.onColorSelected,
  });

  final int colorIdx;
  final List<Color> colorList;
  final void Function(int index) onColorSelected;

  @override
  Widget build(context, ref) {
    return Wrap(
      // 가로방향 정렬 -> Row과 달리 오버플로우 없이 다음 줄로 넘어감
      spacing: 16,
      alignment: WrapAlignment.center,
      children: colorList.asMap().entries.map((entry) {
        int index = entry.key;
        Color color = entry.value;
        bool isSelected = index == colorIdx;
        return GestureDetector(
          onTap: () => onColorSelected(index),
          child: AnimatedContainer(
            // 해당 컨테이너의 속성이 변경될때 해당 간격 만큼의 에니메이션 적용
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              border: isSelected
                  ? Border.all(
                      color: ref.watch(themeServiceProvider).color.primary,
                      width: 3)
                  : null,
              borderRadius: BorderRadius.circular(99),
            ),
            padding: EdgeInsets.all(isSelected ? 1 : 4),
            child: DecoratedBox(
              // 속성 하나만 사용할 경우 Container보다 가볍게 사용
              decoration: BoxDecoration(
                boxShadow: ref.watch(themeServiceProvider).deco.shadow,
              ),
              child: CircleAvatar(
                backgroundColor: color,
                radius: 20,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
