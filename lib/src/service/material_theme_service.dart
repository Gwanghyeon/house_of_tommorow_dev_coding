import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:house_of_tomorrow/src/service/theme_service_revised.dart';

final materialThemeServiceProvider =
    NotifierProvider<MaterialThemeService, ThemeData>(MaterialThemeService.new);

class MaterialThemeService extends Notifier<ThemeData> {
  @override
  ThemeData build() {
    final currentTheme = ref.watch(themeServiceProvider);

    return ThemeData(
      /// Scaffold
      scaffoldBackgroundColor: currentTheme.color.surface,

      /// AppBar
      appBarTheme: AppBarTheme(
        backgroundColor: currentTheme.color.surface,
        elevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(
          color: currentTheme.color.text,
        ),
        titleTextStyle: currentTheme.typo.headline2.copyWith(
          color: currentTheme.color.text,
        ),
      ),
    );
  }
}
