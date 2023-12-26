import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:house_of_tomorrow/src/model/product.dart';
import 'package:house_of_tomorrow/src/service/theme_service_revised.dart';
import 'package:house_of_tomorrow/util/helper/intl_helper.dart';

class ProductColorPreview extends ConsumerWidget {
  const ProductColorPreview(
      {super.key, required this.colorIndex, required this.product});

  final int colorIndex;
  final Product product;

  @override
  Widget build(context, ref) {
    final theme = ref.watch(themeServiceProvider);
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 32),
      decoration: BoxDecoration(
        color: theme.color.surface,
        boxShadow: theme.deco.shadow,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Image
          AspectRatio(
            aspectRatio: 1 / 0.8, // 폭/높이: 고정된 비율로 표시: 이미지 로딩 중
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              // vs Image.network : 이미지 로딩 중과 이미지를 임시 저장하여 처리
              // Missing Plugin Exception: 에뮬레이터 종료 후 적용이 필요
              child: CachedNetworkImage(
                imageUrl: product.productColorList[colorIndex].imageUrl,
                fit: BoxFit.cover,
                width: double.infinity, // 화면을 가득 채우는 폭을 기준으로 높이를 가짐
              ),
            ),
          ),
          const SizedBox(height: 16),

          /// name
          Text(
            product.name.toString(),
            style:
                theme.typo.headline1.copyWith(fontWeight: theme.typo.semiBold),
          ),
          const SizedBox(height: 4),

          /// brand & price
          Row(
            children: [
              Text(
                product.brand.toString(),
                style: theme.typo.subtitle1.copyWith(
                  fontWeight: theme.typo.light,
                  color: theme.color.subtext,
                ),
              ),
              const Spacer(),
              Text(
                IntlHelper.currency(
                  symbol: product.priceUnit,
                  number: product.price,
                ),
                style: theme.typo.headline6.copyWith(
                  color: theme.color.primary,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
