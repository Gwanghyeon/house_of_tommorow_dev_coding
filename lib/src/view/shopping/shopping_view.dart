import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:house_of_tomorrow/src/model/product.dart';
import 'package:house_of_tomorrow/src/view/shopping/widget/product_card_grid.dart';
import 'package:house_of_tomorrow/src/view/shopping/widget/product_empty.dart';
import 'package:house_of_tomorrow/theme/component/bottom_sheet/setting_bottom_sheet.dart';
import 'package:house_of_tomorrow/theme/component/button/button.dart';
import 'package:house_of_tomorrow/theme/component/hide_keyboard.dart';
import 'package:house_of_tomorrow/theme/component/input_field.dart';
import 'package:house_of_tomorrow/util/helper/network_helper.dart';
import 'package:house_of_tomorrow/util/lang/generated/l10n.dart';

class ShoppingView extends ConsumerStatefulWidget {
  const ShoppingView({super.key});
  @override
  ConsumerState<ShoppingView> createState() => _ShoppingViewState();
}

class _ShoppingViewState extends ConsumerState<ShoppingView> {
  List<Product> productList = [];
  final textController = TextEditingController();

  // 검색 키워드 반환
  String get keyword => textController.text.trim();

  Future<void> searchProductList() async {
    try {
      final res = await NetworkHelper.dio.get(
        'https://gist.githubusercontent.com/nero-angela/d16a5078c7959bf5abf6a9e0f8c2851a/raw/04fb4d21ddd1ba06f0349a890f5e5347d94d677e/ikeaSofaDataIBB.json',
      );

      productList = jsonDecode(res.data)
          .map<Product>((json) => Product.fromJson(json))

          // * 검색 실시
          .where((Product product) {
        // 키워드가 없는 경우 모든 상품 반환
        if (keyword.isEmpty) return true;

        // name, keyword를 포함하고 있는 상품을 반환
        return "${product.name}${product.brand}"
            .toLowerCase()
            .contains(keyword.toLowerCase());
      }).toList();
      setState(() {});
    } catch (e, s) {
      log(
        'Failed to search the list',
        error: e,
        stackTrace: s, // 오류 파일과 위치를 확인할 수 있음
      );
    }
  }

  @override
  void initState() {
    super.initState();
    // 앱이 시작될때 상품 정보를 읽어오도록
    searchProductList();
  }

  @override
  Widget build(context) {
    return HideKeyboard(
      // for hiding keyboard when unfocusing
      child: Scaffold(
        appBar: AppBar(
          title: Text(S.current.shopping),
          actions: [
            Button(
              icon: 'option',
              type: ButtonType.flat,
              onPressed: () {
                showModalBottomSheet(
                    context: context,

                    /// BottomShee 크기를 최대화 가능
                    /// 스크롤하여 닫을 수 있도록 하기에 크기가 화면을 가득 채움
                    // isScrollControlled: true,
                    builder: (context) => const SettingBottomSheet());
              },
            )
          ],
        ),
        body: Column(
          children: [
            /// Search Container
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              child: Row(
                children: [
                  /// User Input Field
                  Expanded(
                    child: InputField(
                      controller: textController,
                      onClear: searchProductList, // 검색어가 없을 경우 모든 상품 표시
                      onSubmitted: (text) => searchProductList(),
                      hint: S.current.searchProduct,
                    ),
                  ),
                  const SizedBox(width: 16),

                  /// Search Button
                  Button(
                    icon: 'search',
                    onPressed: searchProductList,
                  )
                ],
              ),
            ),

            /// ProductCardList
            Expanded(
              child: productList.isEmpty
                  ? const ProductEmpty()
                  : ProductCardGrid(productList: productList),
            ),
          ],
        ),
      ),
    );
  }
}
