// ignore_for_file: public_member_api_docs, sort_constructors_first
// 장바구니 안에서 보여지는 데이터
import 'package:house_of_tomorrow/src/model/product.dart';

class CartItem {
  final Product product;
  final int colorIdx;
  final int count; // 선택수량
  final bool isSelected; // 장바구니내에서 선택여부

  const CartItem({
    required this.product,
    required this.colorIdx,
    required this.count,
    required this.isSelected,
  });
}
