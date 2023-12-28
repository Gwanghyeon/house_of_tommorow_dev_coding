import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:house_of_tomorrow/src/model/cart_item.dart';
import 'package:house_of_tomorrow/src/model/product.dart';
import 'package:house_of_tomorrow/src/service/cart_service.dart';
import 'package:house_of_tomorrow/src/view/product/widget/product_bottom_sheet.dart';
import 'package:house_of_tomorrow/src/view/product/widget/product_color_preview.dart';
import 'package:house_of_tomorrow/src/view/product/widget/product_desc.dart';
import 'package:house_of_tomorrow/theme/component/cart_button.dart';
import 'package:house_of_tomorrow/theme/component/color_picker.dart';
import 'package:house_of_tomorrow/theme/component/pop_button.dart';
import 'package:house_of_tomorrow/theme/component/toast/toast.dart';
import 'package:house_of_tomorrow/util/lang/generated/l10n.dart';

class ProductView extends ConsumerStatefulWidget {
  const ProductView({super.key, required this.product});

  final Product product;

  @override
  ConsumerState<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends ConsumerState<ProductView> {
  // 수량
  int count = 1;
  // 선택한 색상
  int colorIdx = 0;

  // 수량 업데이트 이벤트
  void onCountChanged(int newCount) {
    setState(() {
      count = newCount;
    });
  }

  // 색상 업데이트 이벤트
  void onColorIndexChanged(int newIdx) {
    setState(() {
      colorIdx = newIdx;
    });
  }

  // 장바구니 상품 추가 이벤트
  void onAddToCartPressed() {
    final newCartItem = CartItem(
        product: widget.product,
        colorIdx: colorIdx,
        count: count,
        isSelected: true);
    ref.read(cartServiceProvider.notifier).add(newCartItem);
    Toast.show(
      context: context,
      text: S.current.productAdded(newCartItem.product.name),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.current.product),
        leading: const PopButton(),
        titleSpacing: 0, // 타이틀 앞의 여백값
        // 장바구니 버튼
        actions: const [CartButton()],
      ),
      body: Column(
        children: [
          Expanded(
            // 아래의 위젯들만 스크롤 가능
            // Expanded 밖의 위젯들은 화면에 고정되어 있음
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 32),
              child: Wrap(
                // 가로정렬: 다음 줄로 넘어가기에 Column과 같이 배치 가능
                runSpacing: 32, // 세로 간격
                alignment: WrapAlignment.center,
                children: [
                  // Product Preview
                  ProductColorPreview(
                    colorIndex: colorIdx,
                    product: widget.product,
                  ),

                  // Color Picker
                  ColorPicker(
                    colorIdx: colorIdx,
                    colorList: widget.product.productColorList
                        .map((item) => item.color)
                        .toList(),
                    onColorSelected: onColorIndexChanged,
                  ),
                  ProductDesc(product: widget.product),
                ],
              ),
            ),
          ),
          ProductBottomSheet(
              count: count,
              product: widget.product,
              onCountChanged: onCountChanged,
              onAddToCartPressed: onAddToCartPressed),
        ],
      ),
    );
  }
}
