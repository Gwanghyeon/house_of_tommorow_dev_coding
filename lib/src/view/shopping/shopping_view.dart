import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:house_of_tomorrow/src/service/theme_service_revised.dart';
import 'package:house_of_tomorrow/theme/component/bottom_sheet/setting_bottom_sheet.dart';
import 'package:house_of_tomorrow/theme/component/button/button.dart';
import 'package:house_of_tomorrow/theme/component/input_field.dart';
import 'package:house_of_tomorrow/util/lang/generated/l10n.dart';

class ShoppingView extends ConsumerWidget {
  const ShoppingView({super.key});

  @override
  Widget build(context, ref) {
    final themeService = ref.watch(themeServiceProvider);

    return Scaffold(
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                /// 검색
                Expanded(
                  child: InputField(
                    hint: S.current.searchProduct,
                  ),
                ),
                const SizedBox(width: 8),

                /// 검색 버튼
                Button(
                  icon: 'search',
                  onPressed: () {},
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
