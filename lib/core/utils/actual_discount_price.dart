import 'package:flutter/material.dart';
import 'package:memee/core/extensions/theme_extension.dart';
import 'package:memee/core/utils/app_colors.dart';
import 'package:memee/core/utils/app_strings.dart';

class ActualDiscountPrice extends StatelessWidget {
  final int units;
  final int? discountedPrice;
  final int price;

  const ActualDiscountPrice({
    super.key,
    required this.units,
    this.discountedPrice,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '$units *\t',
          style: Theme.of(context).textTheme.textSMMedium,
        ),
        Text(
          '${AppStrings.rupee} ${discountedPrice ?? ''} \t',
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.textSMMedium.copyWith(
                color: AppColors.textAccentDarkColor,
              ),
        ),
        Text(
          '${AppStrings.rupee} $price',
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.textSMMedium.copyWith(
                color: AppColors.textLightColor,
                decoration: TextDecoration.lineThrough,
                decorationThickness: 2,
              ),
        ),
      ],
    );
  }
}
