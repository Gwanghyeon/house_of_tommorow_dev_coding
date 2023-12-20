import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

abstract class IntlHelper {
  static const en = Locale('en');
  static const ko = Locale('ko');

  // 한국어 확인 함수
  static bool get isKorean => Intl.getCurrentLocale() == ko.languageCode;
}
