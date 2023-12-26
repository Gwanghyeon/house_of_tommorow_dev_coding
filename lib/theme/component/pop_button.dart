import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:house_of_tomorrow/src/service/theme_service_revised.dart';
import 'package:house_of_tomorrow/theme/component/button/button.dart';

class PopButton extends ConsumerWidget {
  const PopButton({super.key});

  @override
  Widget build(context, ref) {
    return Button(
      icon: 'arrow-left',
      color: ref.watch(themeServiceProvider).color.text,
      type: ButtonType.flat,
      onPressed: () => Navigator.pop(context),
    );
  }
}