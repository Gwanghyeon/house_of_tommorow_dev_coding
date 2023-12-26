// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:house_of_tomorrow/util/helper/intl_helper.dart';

class Lang {
  final String ko;
  final String en;

  const Lang({
    required this.ko,
    required this.en,
  });

  factory Lang.fromJson(Map<String, dynamic> json) {
    return Lang(
      ko: json['ko'] ?? '',
      en: json['en'] ?? '',
    );
  }

  @override
  String toString() => IntlHelper.isKorean ? ko : en;
}
