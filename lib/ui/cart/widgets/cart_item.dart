import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:memee/blocs/cart/cart_cubit.dart';
import 'package:memee/core/initializer/app_di.dart';
import 'package:memee/core/shared/actual_discout_price.dart';
import 'package:memee/models/cart_model.dart';
import 'package:memee/ui/__shared/extensions/widget_extensions.dart';
import 'package:memee/ui/__shared/widgets/add_remove_button.dart';

class CartItem extends StatelessWidget {
  final CartModel cart;

  CartItem({super.key, required this.cart});

  final _cartCubit = locator.get<CartCubit>();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          12.r,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.amber,
            blurRadius: 12.r,
            blurStyle: BlurStyle.outer,
          )
        ],
        color: Colors.white24,
      ),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: cart.selectedItems.length,
        itemBuilder: (_, index) {
          final e = cart.selectedItems[index];
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${cart.name}',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(color: Colors.amber),
                        ).paddingS(h: 16.w, v: 8.h),
                        Row(
                          children: [
                            Icon(
                              Icons.set_meal,
                              size: 16.r,
                            ).gapRight(8.w),
                            Text(
                              '${e.productDetails.qty} ${e.productDetails.type.name}',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ).paddingH(h: 16.w),
                        SizedBox(height: 8.h),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      ActualDiscountPrice(
                        units: e.units,
                        discountedPrice: e.productDetails.discountedPrice,
                        price: e.productDetails.price,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          BlocBuilder<CartCubit, CartState>(
                            bloc: _cartCubit,
                            builder: (_, state) {
                              return AddRemoveWidget(
                                onAdd: () => _cartCubit.addProduct(
                                  e.productDetails,
                                  cart.productId,
                                  cart.name ?? '',
                                  cart.image ?? '',
                                ),
                                onRemove: () => _cartCubit.removeProduct(
                                    e.productDetails, cart.productId),
                                quantity: _cartCubit.showQty(
                                    e.productDetails, cart.productId),
                              );
                            },
                          ),
                        ],
                      ).paddingS(h: 16.w, v: 8.h),
                    ],
                  ),
                ],
              )
            ],
          );
        },
      ),
    );
  }
}
