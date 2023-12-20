import 'package:flutter/material.dart';

abstract class Typo {
  const Typo({
    required this.name,
    required this.light,
    required this.regular,
    required this.semiBold,
  });

  final String name;
  final FontWeight light;
  final FontWeight regular;
  final FontWeight semiBold;
}

class NotoSans implements Typo {
  const NotoSans();

  @override
  final String name = 'noto_sans';

  @override
  // NotoSans-Light
  final FontWeight light = FontWeight.w300;

  @override
  // NotoSans-Regular
  final FontWeight regular = FontWeight.w400;

  @override
  // NotoSans-SemiBold
  final FontWeight semiBold = FontWeight.w600;
}
