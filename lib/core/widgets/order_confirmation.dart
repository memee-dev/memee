import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:memee/blocs/hide/hide_cubit.dart';
import 'package:memee/core/extensions/theme_extension.dart';
import 'package:memee/core/extensions/widget_extensions.dart';
import 'package:memee/core/utils/app_assets.dart';
import 'package:memee/core/utils/app_colors.dart';
import 'package:memee/core/utils/app_di.dart';
import 'package:memee/core/utils/app_router.dart';
import 'package:memee/core/utils/app_strings.dart';

class OrderConfirmation extends StatelessWidget {
  final bool success;

  OrderConfirmation({super.key, required this.success});

  final _hide = locator.get<HideCubit>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          success ? AppColors.accentLightColor : AppColors.errorColor,
      body: Stack(
        children: [
          if (success) ...[
            Align(
              alignment: Alignment.center,
              child: Lottie.asset(
                AppAssets.glitter,
                repeat: false,
              ).paddingH(),
            ),
          ],
          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Lottie.asset(
                  success ? AppAssets.paymentSuccess : AppAssets.paymentFailure,
                  repeat: true,
                ),
                BlocBuilder<HideCubit, bool>(
                  bloc: _hide..show(true),
                  builder: (context, state) {
                    return AnimatedOpacity(
                      opacity: !state ? 0 : 1,
                      duration: const Duration(seconds: 1),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            success
                                ? AppStrings.orderPlaceSuccess
                                : AppStrings.orderCannotBePlaced,
                            textAlign: TextAlign.center,
                            style:
                                Theme.of(context).textTheme.textXLBold.copyWith(
                                      color: success
                                          ? AppColors.accentPinkColor
                                          : AppColors.bgColor,
                                    ),
                          ).paddingV(16.h),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: success
                                  ? AppColors.primaryButtonColor
                                  : AppColors.bgColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  24.r,
                                ),
                              ),
                              padding: EdgeInsets.all(12.r),
                              elevation: 0.0,
                            ),
                            onPressed: () {
                              _hide.show(false);
                              Routes.pushReplacement(context, Routes.orders);
                            },
                            child: Text(
                              AppStrings.viewOrders,
                              style: Theme.of(context)
                                  .textTheme
                                  .textMDBold
                                  .copyWith(
                                    color: success
                                        ? AppColors.bgColor
                                        : AppColors.errorColor,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ).paddingH(48.w)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
