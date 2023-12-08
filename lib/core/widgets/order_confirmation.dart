import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:memee/core/extensions/theme_extension.dart';
import 'package:memee/core/extensions/widget_extensions.dart';
import 'package:memee/core/utils/app_asset.dart';
import 'package:memee/core/utils/app_colors.dart';
import 'package:memee/core/utils/app_router.dart';
import 'package:memee/core/widgets/app_button.dart';

class OrderConfirmation extends StatelessWidget {
  final bool? success;

  const OrderConfirmation({super.key, this.success});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          success ?? false ? AppColors.successColor : AppColors.errorColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            success ?? false
                ? AppAsset.paymentSuccess
                : AppAsset.paymentFailure,
            repeat: true,
          ),
          Text(
            success ?? false ? 'Payment Successful' : 'Payment Failed !!!',
            style: Theme.of(context).textTheme.textXLBold.copyWith(
                  color: AppColors.bgColor,
                ),
          ).paddingV(16.h),
          AppButton.primary(
            text: 'Return Home',
            color: AppColors.bgColor,
            onPressed: () {
              Routes.push(context, Routes.landing);
            },
          ).paddingH(48.w)
        ],
      ),
    );
  }
}
