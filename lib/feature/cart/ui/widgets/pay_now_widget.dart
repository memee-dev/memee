import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:memee/core/extensions/theme_extension.dart';
import 'package:memee/core/extensions/widget_extensions.dart';
import 'package:memee/core/utils/app_colors.dart';
import 'package:memee/core/utils/app_strings.dart';
import 'package:memee/core/widgets/app_button.dart';
import 'package:memee/feature/cart/ui/widgets/cart_address_widget.dart';
import 'package:memee/models/user_model.dart';

class PayNowWidget extends StatelessWidget {
  final AddressModel? address;
  final bool isEmpty;
  final bool slotAvailableToday;
  final Function() onPressed;
  final String totalAmount;

  const PayNowWidget({
    super.key,
    this.address,
    required this.isEmpty,
    required this.slotAvailableToday,
    required this.onPressed,
    required this.totalAmount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
        color: AppColors.bgColor,
      ),
      child: Column(
        children: [
          CartAddressWidget(
            address: address,
            isEmpty: isEmpty,
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      12.r,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 16.r,
                        blurStyle: BlurStyle.outer,
                      ),
                    ],
                    color: AppColors.bgColor,
                  ),
                  child: Text(
                    'CASH',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.textMDSemibold,
                  ).paddingS(),
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: AppButton.primary(
                  text: 'Pay ${AppStrings.rupee}$totalAmount',
                  onPressed: onPressed,
                ),
              )
            ],
          ).paddingS(v: 4.h),
        ],
      ),
    );
  }
}
