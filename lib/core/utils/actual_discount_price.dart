import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:memee/core/extensions/theme_extension.dart';
import 'package:memee/core/utils/app_colors.dart';
import 'package:memee/core/utils/app_strings.dart';
import 'package:memee/core/extensions/widget_extensions.dart';

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
          '$units',
          style: Theme.of(context).textTheme.textSMBold,
        ),
        Text(
          ' *\t ${AppStrings.rupee}${discountedPrice ?? ''} \t',
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context)
              .textTheme
              .textMDBold
              .copyWith(color: AppColors.accentDarkColor),
        ),
        Text(
          '${AppStrings.rupee}$price',
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.textMDBold.copyWith(
                color: Colors.red,
                fontWeight: FontWeight.w900,
                decoration: TextDecoration.lineThrough,
                decorationThickness: 2,
              ),
        ),
      ],
    ).gapTop(12.h);
  }
}
