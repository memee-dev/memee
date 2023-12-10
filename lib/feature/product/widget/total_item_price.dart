import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:memee/core/extensions/theme_extension.dart';
import 'package:memee/core/utils/app_colors.dart';
import 'package:memee/core/utils/app_router.dart';
import 'package:memee/feature/cart/bloc/cart_bloc/cart_cubit.dart';
import 'package:memee/core/utils/app_di.dart';
import 'package:memee/core/utils/actual_discount_price.dart';
import 'package:memee/core/widgets/app_divider.dart';
import 'package:memee/core/utils/app_strings.dart';
import 'package:memee/core/extensions/widget_extensions.dart';
import 'package:memee/core/widgets/app_button.dart';

class TotalItemPrice extends StatelessWidget {
  final String productId;

  const TotalItemPrice({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    final _cartCubit = locator.get<CartCubit>();
    return BlocBuilder<CartCubit, CartState>(
      bloc: _cartCubit,
      builder: (context, state) {
        if (state is CartSuccess) {
          int index = state.cartItems
              .indexWhere((element) => element.productId == productId);
          return (state.cartItems.isNotEmpty && index != -1)
              ? Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      12.r,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurStyle: BlurStyle.outer,
                        blurRadius: 24.r,
                      )
                    ],
                    color: AppColors.bgColor,
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: 12.h,
                    horizontal: 12.w,
                  ),
                  child: Column(
                    children: [
                      Column(
                        children: state.cartItems[index].selectedItems.map((e) {
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.deblur,
                                      size: 16.r,
                                      color: AppColors.textAccentDarkColor,
                                    ).gapRight(4.w),
                                    Text(
                                      '${e.productDetails.qty} ${e.productDetails.type.name} ',
                                      style: Theme.of(context)
                                          .textTheme
                                          .textMDSemibold,
                                    ),
                                  ],
                                ).gapBottom(8.h),
                              ),
                              ActualDiscountPrice(
                                units: e.units,
                                discountedPrice:
                                    e.productDetails.discountedPrice,
                                price: e.productDetails.price,
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Column(
                          children: [
                            AppDivider(
                              width: MediaQuery.of(context).size.width * .30,
                              color: AppColors.textAccentDarkColor,
                            ).gapBottom(
                              8.h,
                            ),
                            _rowText(context, AppStrings.amount,
                                '${AppStrings.rupee} ${_cartCubit.getTotalAmount(productId)}'),
                          ],
                        ),
                      ).gapBottom(4.h),
                      AppButton.primary(
                        text: AppStrings.goToCart,
                        onPressed: () => Routes.push(context, Routes.cart),
                      ),
                    ],
                  ),
                )
              : const SizedBox.shrink();
        }
        return const SizedBox.shrink();
      },
    );
  }
}

Widget _rowText(context, String title, subtitle, {Color? color}) {
  return RichText(
    text: TextSpan(
      children: [
        TextSpan(
          text: '$title:\t\t',
          style: Theme.of(context).textTheme.textSMSemibold.copyWith(
                color: AppColors.textLightColor,
              ),
        ),
        TextSpan(
          text: subtitle,
          style: Theme.of(context).textTheme.textSMBold.copyWith(
                color: color ?? AppColors.textAccentDarkColor,
              ),
        ),
      ],
    ),
  );
}
