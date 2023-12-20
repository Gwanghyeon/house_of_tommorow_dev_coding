import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:house_of_tomorrow/theme/dark_theme.dart';
import 'package:house_of_tomorrow/theme/foundation/app_theme.dart';
import 'package:house_of_tomorrow/theme/light_theme.dart';

/// Riverpod

final themeServiceProvider =
    NotifierProvider<ThemeService, AppTheme>(ThemeService.new);

class ThemeService extends Notifier<AppTheme> {
  @override
  AppTheme build() => LightTheme();

  void toggleTheme() {
    if (state.brightness == Brightness.light) {
      state = DarkTheme();
    } else {
      state = LightTheme();
    }
  }
}
