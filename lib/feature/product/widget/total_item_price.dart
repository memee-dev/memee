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
                        color: AppColors.textLightColor.withOpacity(0.36),
                        blurStyle: BlurStyle.outer,
                        blurRadius: 16.r,
                      )
                    ],
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: 8.h,
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
                                    Text(
                                      '⦿',
                                      style: Theme.of(context)
                                          .textTheme
                                          .textXLBold
                                          .copyWith(
                                            color: AppColors.primaryButtonColor,
                                          ),
                                    ).gapRight(4.w),
                                    Text(
                                      '${e.productDetails.qty} ${e.productDetails.type.name} ',
                                      style: Theme.of(context)
                                          .textTheme
                                          .textMDBold,
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
                      const AppDivider(
                        width: double.infinity,
                      ).paddingV(8.h),
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
