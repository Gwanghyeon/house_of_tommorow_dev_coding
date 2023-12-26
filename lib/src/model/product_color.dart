// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class ProductColor {
  final String imageUrl;
  final Color color;

  const ProductColor({
    required this.imageUrl,
    required this.color,
  });

  factory ProductColor.fromJson(Map<String, dynamic> json) {
    return ProductColor(
      imageUrl: json['imageUrl'] ?? '',
      color: Color(
        // tryParse: parse가 불가능할때엔 null 반환
        int.tryParse(json['hexColor']) ?? 0xFF000000,
      ),
    );
  }
}
