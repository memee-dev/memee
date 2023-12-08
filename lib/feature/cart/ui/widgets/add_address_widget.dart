import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:memee/core/extensions/theme_extension.dart';
import 'package:memee/core/extensions/widget_extensions.dart';
import 'package:memee/core/utils/app_assets.dart';
import 'package:memee/core/utils/app_colors.dart';
import 'package:memee/core/utils/app_strings.dart';

class AddAddressWidget extends StatelessWidget {
  const AddAddressWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          12.r,
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: 16.r,
            color: AppColors.displayColor.withOpacity(0.24),
            blurStyle: BlurStyle.outer,
          ),
        ],
      ),
      margin: EdgeInsets.symmetric(
        horizontal: 16.w,
      ),
      padding: EdgeInsets.all(
        8.r,
      ),
      child: ListTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              AppAssets.noAddress,
              height: 36.h,
            ),
            Text(
              AppStrings.noAddressFound,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.textMDBold,
            ),
          ],
        ).gapBottom(8.h),
        subtitle: Column(
          children: [
            Text(
              AppStrings.addDeliveryAddress,
              style: Theme.of(context).textTheme.textSMBold.copyWith(
                    color: AppColors.displayColor.withOpacity(0.5),
                  ),
            ),
            TextButton.icon(
              style: const ButtonStyle(
                  padding: MaterialStatePropertyAll(EdgeInsets.zero)),
              icon: const Icon(Icons.edit_note),
              label: Text(
                AppStrings.addAddress,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.textMDBold,
              ),
              onPressed: null,
            ).gapRight(8.w),
          ],
        ),
        contentPadding: EdgeInsets.zero,
      ),
    );
  }
}
