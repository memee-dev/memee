import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:memee/core/extensions/theme_extension.dart';
import 'package:memee/core/extensions/widget_extensions.dart';
import 'package:memee/core/utils/app_colors.dart';
import 'package:memee/core/utils/app_router.dart';
import 'package:memee/core/utils/app_strings.dart';
import 'package:memee/models/user_model.dart';

class CartAddressWidget extends StatelessWidget {
  final AddressModel address;
  final bool isEmpty;

  const CartAddressWidget({
    super.key,
    required this.address,
    required this.isEmpty,
  });

  @override
  Widget build(BuildContext context) {
    String userAddress =
        '${address.no},${address.street},${address.area},${address.city},${address.pincode},${address.landmark}';

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Text(
                AppStrings.orderWillBeDeliveredTo,
                style: Theme.of(context).textTheme.textSMBold.copyWith(
                      color: AppColors.textLightColor,
                    ),
              ),
            ),
            InkWell(
              onTap: () {
                if (isEmpty) {
                  Routes.push(context, Routes.addEditAddress);
                } else {
                  Routes.push(context, Routes.savedAddress);
                }
              },
              child: Text(
                AppStrings.change,
                style: Theme.of(context).textTheme.textMDBold.copyWith(
                      color: AppColors.accentPinkColor,
                    ),
              ),
            )
          ],
        ).gapBottom(8.h),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              12.r,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.displayColor.withOpacity(
                  0.25,
                ),
                blurRadius: 16.r,
                blurStyle: BlurStyle.outer,
              ),
            ],
          ),
          child: Row(
            children: [
              Icon(
                Icons.home_filled,
                size: 16.sp,
                color: AppColors.accentPinkColor,
              ).gapRight(
                4.w,
              ),
              Expanded(
                flex: 1,
                child: Text(
                  'Home',
                  maxLines: 2,
                  style: Theme.of(context).textTheme.textSMBold,
                ).gapRight(
                  4.w,
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  userAddress,
                  maxLines: 2,
                  style: Theme.of(context).textTheme.textSMSemibold,
                ).paddingV(4.h),
              )
            ],
          ).paddingS(),
        ),
      ],
    ).gapBottom(16.h);
  }
}
