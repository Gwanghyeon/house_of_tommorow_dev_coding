import 'package:flutter/material.dart';
import 'package:house_of_tomorrow/src/model/product.dart';
import 'package:house_of_tomorrow/src/view/product/widget/product_bottom_sheet.dart';
import 'package:house_of_tomorrow/src/view/product/widget/product_color_preview.dart';
import 'package:house_of_tomorrow/src/view/product/widget/product_desc.dart';
import 'package:house_of_tomorrow/theme/component/color_picker.dart';
import 'package:house_of_tomorrow/theme/component/pop_button.dart';
import 'package:house_of_tomorrow/util/lang/generated/l10n.dart';

class ProductView extends StatefulWidget {
  const ProductView({super.key, required this.product});

  final Product product;

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  // 수량
  int count = 1;
  // 선택한 색상
  int colorIndex = 0;

  // 수량 업데이트 이벤트
  void onCountChanged(int newCount) {
    setState(() {
      count = newCount;
    });
  }

  // 색상 업데이트 이벤트
  void onColorIndexChanged(int newIdx) {
    setState(() {
      colorIndex = newIdx;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.current.product),
        leading: const PopButton(),
        titleSpacing: 0, // 타이틀 앞의 여백값
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
                    colorIndex: colorIndex,
                    product: widget.product,
                  ),

                  // Color Picker
                  ColorPicker(
                    colorIdx: colorIndex,
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
              onAddToCartPressed: () {}),
        ],
      ),
    );
  }
}
