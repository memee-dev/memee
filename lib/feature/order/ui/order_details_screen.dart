import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:memee/core/extensions/string_extension.dart';
import 'package:memee/core/extensions/theme_extension.dart';
import 'package:memee/core/extensions/widget_extensions.dart';
import 'package:memee/core/utils/app_bar.dart';
import 'package:memee/core/utils/app_colors.dart';
import 'package:memee/core/utils/app_divider.dart';
import 'package:memee/core/utils/app_strings.dart';
import 'package:memee/models/order_model.dart';

class OrderDetailsScreen extends StatelessWidget {
  final OrderModel order;

  const OrderDetailsScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarTemplate(
        title: AppStrings.orderDetails,
      ),
      body: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              blurStyle: BlurStyle.outer,
              blurRadius: 24.r,
              color: AppColors.textLightColor.withOpacity(0.36),
            ),
          ],
          borderRadius: BorderRadius.circular(
            12.r,
          ),
        ),
        margin: EdgeInsets.symmetric(
          horizontal: 12.w,
          vertical: 12.h,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(child: _rowText(context, 'Order Dd: ', order.id)),
                Text(
                  order.orderedTime,
                  style: Theme.of(context)
                      .textTheme
                      .textSMBold
                      .copyWith(color: AppColors.textRegularColor),
                ),
              ],
            ).gapBottom(8.h),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  12.r,
                ),
                boxShadow: [
                  BoxShadow(
                    blurStyle: BlurStyle.outer,
                    blurRadius: 16.r,
                    color: AppColors.textLightColor.withOpacity(0.24),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Column(
                    children: order.orders
                        .map(
                          (e) => Column(
                            children: e.selectedItems
                                .map(
                                  (s) => Row(
                                    children: [
                                      Text(
                                        toBeginningOfSentenceCase(
                                                e.name ?? '') ??
                                            '',
                                        style: Theme.of(context)
                                            .textTheme
                                            .textSMBold
                                            .copyWith(
                                              color: AppColors.textLightColor,
                                            ),
                                      ),
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              '${s.units} x\t',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .textMDBold,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  '(${AppStrings.rupee}${s.productDetails.discountedPrice} \tper ',
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .textMDBold
                                                      .copyWith(
                                                          color: AppColors
                                                              .textAccentDarkColor),
                                                ),
                                                Text(
                                                  '${s.productDetails.qty} ${s.productDetails.type.name})',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .textSMBold
                                                      .copyWith(
                                                          color: AppColors
                                                              .textAccentDarkColor),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ).paddingS(),
                                )
                                .toList(),
                          ),
                        )
                        .toList(),
                  ).gapBottom(4.h),
                  const AppDivider(),
                  Align(
                    alignment: Alignment.centerRight,
                    child:
                        _rowText(context, 'Total Amount: ', order.totalAmount)
                            .paddingS(),
                  ),
                ],
              ),
            ).paddingV(16.h),
            _rowText(
              context,
              'Order Status: ',
              order.orderStatus.toUpperCase(),
              color: getColor(order.orderStatus),
            ).gapBottom(8.h),
            _rowText(
              context,
              'Payment Status: ',
              order.paymentStatus,
              color: getPaymentStatus(order.paymentStatus),
            ).gapBottom(8.h),
            _rowText(
              context,
              'Delivered to: ',
              order.address,
            ),
          ],
        ).paddingS(),
      ),
    );
  }

  getColor(String orderStatus) {
    return orderStatus.equals(AppStrings.orderDelivered)
        ? AppColors.successColor
        : orderStatus.equals(AppStrings.orderConfirmed)
            ? AppColors.primaryButtonColor
            : AppColors.errorColor;
  }

  getPaymentStatus(String status) {
    return status.equals(AppStrings.success)
        ? AppColors.successColor
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
