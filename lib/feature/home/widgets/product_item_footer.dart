import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:memee/core/extensions/string_extension.dart';
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
        Row(
          children: [
            Expanded(
              flex: 2,
              child: Text(
                name.toCapitalize(),
                style: Theme.of(context).textTheme.textMDSemibold,
              ),
            ),
            Expanded(
              flex: 0,
              child: Row(
                children: [
                  Text(
                    '$type / ',
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .textSMSemibold
                        .copyWith(color: AppColors.textHintColor),
                  ),
                  Text(
                    '${AppStrings.rupee}$normalPrice \t',
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .textSMSemibold
                        .copyWith(color: AppColors.textAccentDarkColor),
                  ),
                  Text(
                    '${AppStrings.rupee}$discountPrice',
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.textSMSemibold.copyWith(
                          color: AppColors.textLightColor,
                          decoration: TextDecoration.lineThrough,
                          decorationThickness: 2,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    ).paddingS(
      v: 4.h,
      h: 8.w,
    );
  }
}
