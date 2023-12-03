import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:memee/core/extensions/theme_extension.dart';
import 'package:memee/core/utils/app_asset.dart';
import 'package:memee/core/utils/app_colors.dart';
import 'package:memee/core/utils/app_strings.dart';

class AddItemsToCart extends StatelessWidget {
  const AddItemsToCart({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Lottie.asset(AppAsset.cartEmpty),
        Text(
          AppStrings.addItemsToCart,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.textLGBold.copyWith(
                color: AppColors.accentDarkColor,
              ),
        ),
      ],
    );
  }
}
