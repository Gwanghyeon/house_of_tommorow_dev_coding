import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:house_of_tomorrow/src/service/theme_service_revised.dart';

class BaseBottomSheet extends ConsumerWidget {
  const BaseBottomSheet({
    required this.child,
    this.padding,
    super.key,
  });

  final Widget child;
  final EdgeInsets? padding;

  @override
  Widget build(context, ref) {
    final currentTheme = ref.watch(themeServiceProvider);
    return Container(
      decoration: BoxDecoration(
        color: currentTheme.color.surface,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        boxShadow: currentTheme.deco.shadow,
      ),
      padding: const EdgeInsets.only(
        top: 32,
        bottom: 16,
      ),
      child: child,
    );
  }
}
