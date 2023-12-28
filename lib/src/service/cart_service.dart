// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:house_of_tomorrow/src/model/cart_item.dart';

final cartServiceProvider =
    NotifierProvider<CartService, CartState>(CartService.new);

class CartState {
  final List<CartItem> cartItemList;

  CartState({required this.cartItemList});

  factory CartState.init() {
    return CartState(cartItemList: List<CartItem>.empty(growable: true));
  }

  CartState copyWith({
    List<CartItem>? cartItemList,
  }) {
    return CartState(
      cartItemList: cartItemList ?? this.cartItemList,
    );
  }
}

class CartService extends Notifier<CartState> {
  @override
  CartState build() {
    return CartState.init();
  }

  /// Add Item in Cart
  void add(CartItem item) {
    state = state.copyWith(cartItemList: [...state.cartItemList, item]);
  }

  /// Update Item in Cart
  void update(int selectedIdx, CartItem newItem) {
    final res = state.cartItemList
        .asMap()
        .entries
        .map((entry) => entry.key == selectedIdx ? newItem : entry.value)
        .toList();
    state = state.copyWith(cartItemList: res);
  }

  /// Delete Item in Cart
  // 복수의 항목을 받아 삭제할 수 있도록 구현
  void delete(List<CartItem> targetList) {
    final res = state.cartItemList
        .where((element) => !targetList.contains(element))
        .toList();
    state = state.copyWith(cartItemList: res);
  }

  List<CartItem> get selectedCartItemList =>
      state.cartItemList.where((element) => element.isSelected).toList();
}
