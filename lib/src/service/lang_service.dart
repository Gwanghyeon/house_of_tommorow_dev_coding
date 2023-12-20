import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:house_of_tomorrow/util/helper/intl_helper.dart';

final langServiceProvider =
    NotifierProvider<LangService, Locale>(LangService.new);

class LangService extends Notifier<Locale> {
  // todo: 기기의 언어정보를 초기값으로 전달하도록 설정
  @override
  Locale build() => const Locale('en');

  // 언어 변경
  void toggleLanguage() {
    state = IntlHelper.isKorean ? IntlHelper.en : IntlHelper.ko;
  }
}
