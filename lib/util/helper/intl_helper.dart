import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

abstract class IntlHelper {
  static const en = Locale('en');
  static const ko = Locale('ko');

  // 한국어 확인 함수
  static bool get isKorean => Intl.getCurrentLocale() == ko.languageCode;

  static String currency({required String symbol, required int number}) {
    return NumberFormat.currency(
            symbol: symbol, locale: (symbol == '￦' ? ko : en).languageCode)
        .format(number);
  }
}
