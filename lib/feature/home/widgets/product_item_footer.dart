import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:memee/core/extensions/theme_extension.dart';
import 'package:memee/core/extensions/widget_extensions.dart';
import 'package:memee/core/utils/app_colors.dart';
import 'package:memee/core/utils/app_strings.dart';

class ProductItemFooter extends StatelessWidget {
  final String normalPrice, discountPrice, name, type, description;

  const ProductItemFooter({
    super.key,
    required this.normalPrice,
    required this.name,
    required this.description,
    required this.type,
    required this.discountPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: Theme.of(context).textTheme.textMDBold,
        ),
        Text(
          description,
          style: Theme.of(context).textTheme.textMDMedium,
        ).paddingV(6.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              '$type / ',
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.black54,
                    fontWeight: FontWeight.w900,
                  ),
            ),
            Text(
              '${AppStrings.rupee}$normalPrice \t',
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context)
                  .textTheme
                  .textMDBold
                  .copyWith(color: AppColors.accentDarkColor),
            ),
            Text(
              '${AppStrings.rupee}$discountPrice',
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.textMDBold.copyWith(
                    color: Colors.red,
                    decoration: TextDecoration.lineThrough,
                    decorationThickness: 2,
                  ),
            ),
            const Spacer(),
            Text(
              'View',
              style: Theme.of(context).textTheme.textMDBold.copyWith(
                    color: AppColors.accentPinkColor,
                  ),
            )
          ],
        ),
      ],
    ).paddingS(
      v: 4.h,
      h: 12.w,
    );
  }
}
