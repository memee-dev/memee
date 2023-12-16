import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:memee/core/extensions/string_extension.dart';
import 'package:memee/core/extensions/theme_extension.dart';
import 'package:memee/core/extensions/widget_extensions.dart';
import 'package:memee/core/utils/app_colors.dart';
import 'package:memee/core/utils/app_router.dart';
import 'package:memee/core/utils/app_strings.dart';
import 'package:memee/models/order_model.dart';

class OrderItem extends StatelessWidget {
  final OrderModel order;

  const OrderItem({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 24.r,
            blurStyle: BlurStyle.outer,
          ),
        ],
        color: AppColors.bgColor,
        borderRadius: BorderRadius.circular(
          12.r,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: _rowText(context, 'Order ID: ', '${order.id}'),
              ),
              Text(
                order.timeSlot ?? order.orderedTime,
                style: Theme.of(context).textTheme.textSMMedium,
              ),
            ],
          ).gapBottom(12.h),
          _rowText(context, 'Total Amount: ', order.totalAmount)
              .gapBottom(12.h),
          _rowText(
            context,
            'Order Status: ',
            order.orderStatus.toUpperCase(),
            color: getColor(order.orderStatus),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () =>
                    Routes.push(context, Routes.orderDetails, extra: order),
                style: ButtonStyle(
                    padding: MaterialStatePropertyAll(EdgeInsets.all(8.r)),
                    shape: MaterialStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          8.r,
                        ),
                      ),
                    ),
                    backgroundColor: const MaterialStatePropertyAll(
                      AppColors.textAccentDarkColor,
                    ),
                    elevation: const MaterialStatePropertyAll(8)),
                child: Row(
                  children: [
                    Text(
                      AppStrings.viewDetail,
                      style:
                          Theme.of(context).textTheme.textXSSemibold.copyWith(
                                color: AppColors.bgColor,
                              ),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ).paddingS(),
    ).gapBottom(8.h);
  }

  getColor(String orderStatus) {
    return orderStatus.equals(AppStrings.orderCompleted)
        ? AppColors.successColor
        : orderStatus.equals(AppStrings.orderPending)
            ? AppColors.primaryButtonColor
            : AppColors.errorColor;
  }
}

Widget _rowText(context, String title, subtitle, {Color? color}) {
  return RichText(
    text: TextSpan(
      children: [
        TextSpan(
          text: title,
          style: Theme.of(context).textTheme.textSMBold.copyWith(
                color: AppColors.textLightColor,
              ),
        ),
        TextSpan(
          text: subtitle,
          style: Theme.of(context)
              .textTheme
              .textSMBold
              .copyWith(color: color ?? AppColors.textAccentDarkColor),
        ),
      ],
    ),
  );
}
