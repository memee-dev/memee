import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:memee/core/extensions/string_extension.dart';
import 'package:memee/core/extensions/theme_extension.dart';
import 'package:memee/core/extensions/widget_extensions.dart';
import 'package:memee/core/utils/app_bar.dart';
import 'package:memee/core/utils/app_colors.dart';
import 'package:memee/core/utils/app_di.dart';
import 'package:memee/core/utils/app_router.dart';
import 'package:memee/core/utils/app_strings.dart';
import 'package:memee/core/widgets/app_button.dart';
import 'package:memee/core/widgets/app_divider.dart';
import 'package:memee/core/widgets/confirmation_dialog.dart';
import 'package:memee/feature/order/bloc/order_cubit.dart';
import 'package:memee/models/order_model.dart';

class OrderDetailsScreen extends StatelessWidget {
  final OrderModel order;

  const OrderDetailsScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return ScaffoldTemplate(
      title: AppStrings.orderDetails,
      body: Column(
        children: [
          Container(
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
              color: AppColors.bgColor,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(child: _rowText(context, 'Order Id:\t', order.id)),
                    Text(
                      order.orderedTime,
                      style: Theme.of(context)
                          .textTheme
                          .textSMSemibold
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
                                                .textSMSemibold
                                                .copyWith(
                                                  color:
                                                      AppColors.textLightColor,
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
                                                      .textSMSemibold,
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      '(${AppStrings.rupee}${s.productDetails.discountedPrice} \tper ',
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .textSMSemibold
                                                          .copyWith(
                                                              color: AppColors
                                                                  .textAccentDarkColor),
                                                    ),
                                                    Text(
                                                      '${s.productDetails.qty} ${s.productDetails.type.name})',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .textSMSemibold
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
                      ),
                      const AppDivider(),
                      Align(
                        alignment: Alignment.centerRight,
                        child: _rowText(
                                context, 'Total Amount: ', order.totalAmount)
                            .paddingS(),
                      ),
                    ],
                  ),
                ).paddingV(16.h),
                _rowText(
                  context,
                  'Created Time:\t\t',
                  order.orderedTime,
                ).gapBottom(12.h),
                _rowText(
                  context,
                  'Updated time:\t\t',
                  order.updatedTime,
                ).gapBottom(12.h),
                _rowText(
                  context,
                  'Order Status:\t\t',
                  order.orderStatus.toUpperCase(),
                  color: getColor(order.orderStatus),
                ).gapBottom(12.h),
                _rowText(
                  context,
                  'Payment Status:\t\t',
                  order.paymentStatus,
                  color: getPaymentStatus(order.paymentStatus),
                ).gapBottom(12.h),
                _rowText(
                  context,
                  'Delivered to:\t\t',
                  order.address,
                ),
              ],
            ).paddingS(),
          ).gapBottom(16.h),
          if (order.orderStatus.equals(AppStrings.orderPending)) ...[
            AppButton.secondary(
              text: AppStrings.cancelOrder,
              color: AppColors.textAccentDarkColor,
              textColor: AppColors.bgColor,
              onPressed: () {
                showCupertinoDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (_) => ConfirmationDialog(
                    description: AppStrings.cancelOrderDesc,
                    buttonLabel1: AppStrings.dismiss,
                    buttonLabel2: AppStrings.cancelOrder,
                    titleTextColor: AppColors.errorColor,
                    positiveBtn: () {
                      Routes.pop(context);
                      locator.get<OrderCubit>().cancelOder(order);
                    },
                    negativeBtn: () {
                      Routes.pop(context);
                    },
                  ),
                );
              },
            ).paddingH(24.w),
          ],
        ],
      ).paddingS(v: 36.h),
    );
  }

  getColor(String orderStatus) {
    return orderStatus.equals(AppStrings.orderCompleted)
        ? AppColors.successColor
        : orderStatus.equals(AppStrings.orderPending)
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
              .textSMSemibold
              .copyWith(color: color ?? AppColors.textAccentDarkColor),
        ),
      ],
    ),
  );
}
