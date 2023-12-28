import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:house_of_tomorrow/src/service/theme_service.dart';

// 투명도를 상태로 관리하기 위해 StatefulWidget 사용
class ToastBuilder extends ConsumerStatefulWidget {
  const ToastBuilder({
    super.key,
    required this.text,
    required this.animDuration,
  });

  final String text;
  final Duration animDuration;

  @override
  ConsumerState<ToastBuilder> createState() => ToastBuilderState();
}

class ToastBuilderState extends ConsumerState<ToastBuilder> {
  //* Toast 클래스에서 isShow value 변경하여 애니메이션 재생
  //* 애니메이션 미적용시 필요없는 변수

  bool _isShow = false;

  bool get isShow => _isShow;

  set isShow(bool value) {
    setState(() {
      _isShow = value;
    });
  }

  @override
  Widget build(context) {
    final theme = ref.watch(themeServiceProvider);
    final size = MediaQuery.of(context).size;
    return Positioned(
      bottom: size.height / 5,
      left: 0,
      right: 0,
      child: Center(
        // Container child size에 맞추어 가운데 정렬
        child: AnimatedOpacity(
          // isShow 값에 따라 1에서 0 사이로 투명도 에니메이션 적용
          duration: widget.animDuration,
          opacity: isShow ? 1 : 0,
          child: Container(
            // Container: 크기 미지정 -> 전체 화면 차지
            decoration: BoxDecoration(
              color: theme.color.toastContainer,
              borderRadius: BorderRadius.circular(16),
            ),
            padding: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 16,
            ),
            child: DefaultTextStyle(
              style: theme.typo.headline6.copyWith(
                color: theme.color.onToastContainer,
              ),
              child: Text(widget.text),
            ),
          ),
        ),
      ),
    );
  }
}
