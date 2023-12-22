import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:house_of_tomorrow/src/service/theme_service_revised.dart';
import 'package:house_of_tomorrow/theme/component/button/button.dart';

class InputField extends ConsumerStatefulWidget {
  /// 입력한 텍스트의 존재 여부에 따라 화면 갱신 -> StateFul
  const InputField({
    super.key,
    this.controller,
    this.hint,
    this.onChanged,
    this.onSubmitted,
    this.onClear,
  });
  final TextEditingController? controller;
  final String? hint;

  /// Functions
  final void Function(String text)? onChanged;
  final void Function(String text)? onSubmitted; // When the data Entered
  final void Function()? onClear;

  @override
  ConsumerState<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends ConsumerState<InputField> {
  late final controller = widget.controller ?? TextEditingController();
  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(themeServiceProvider);
    return TextField(
      controller: controller,
      onChanged: (value) {
        setState(() {});
        widget.onChanged;
      },
      onSubmitted: widget.onSubmitted,
      style: theme.typo.headline6,
      cursorColor: theme.color.primary,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(12),
          ),
          filled: true,
          fillColor: theme.color.hintContainer,
          hintText: widget.hint,
          hintStyle: theme.typo.headline5.copyWith(
            fontWeight: theme.typo.light,
            color: theme.color.onHintContainer,
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 11.5,
            horizontal: 16,
          ),
          suffixIcon: controller.text.isEmpty
              ? null
              : Button(
                  icon: 'close',
                  type: ButtonType.flat,
                  onPressed: () {
                    controller.clear();
                    widget.onClear?.call(); // null 이 아닌경우에만 호출하는 명령
                    setState(() {});
                  },
                )),
    );
  }
}
