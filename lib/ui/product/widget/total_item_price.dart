import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:memee/blocs/cart/cart_cubit.dart';
import 'package:memee/core/initializer/app_di.dart';
import 'package:memee/core/shared/actual_discout_price.dart';
import 'package:memee/core/shared/app_divider.dart';
import 'package:memee/core/shared/app_strings.dart';
import 'package:memee/ui/__shared/extensions/widget_extensions.dart';
import 'package:memee/ui/__shared/widgets/app_button.dart';

class TotalItemPrice extends StatelessWidget {
  final String productId;

  const TotalItemPrice({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    final _cartCubit = locator.get<CartCubit>();
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          12.r,
        ),
        color: Colors.white12,
      ),
      padding: EdgeInsets.symmetric(
        vertical: 8.h,
      ),
      child: BlocBuilder<CartCubit, CartState>(
        bloc: _cartCubit,
        builder: (context, state) {
          if (state is CartSuccess) {
            int index = state.cartItems
                .indexWhere((element) => element.productId == productId);
            return (state.cartItems.isNotEmpty && index != -1)
                ? ListTile(
                    title: Text(
                      'Mini Cart',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ).gapBottom(8.h),
                    subtitle: Column(
                      children: [
                        Column(
                          children:
                              state.cartItems[index].selectedItems.map((e) {
                            return Row(
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      const Text(
                                        '⦿',
                                        style: TextStyle(
                                          color: Colors.amber,
                                        ),
                                      ).gapRight(8.w),
                                      Text(
                                        e.productDetails.qty.toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                      ),
                                      Text(
                                        ' ${e.productDetails.type.name} ',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
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
                        ).paddingV(v: 8.h),
                        AppButton(
                          label:
                              'Pay ${AppStrings.rupee} ${_cartCubit.getTotalAmount(productId).toString()}',
                          onTap: () {},
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w900,
                        ),
                      ],
                    ),
                  )
                : const SizedBox.shrink();
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
