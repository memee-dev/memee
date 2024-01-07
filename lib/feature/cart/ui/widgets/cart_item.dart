import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:memee/core/extensions/string_extension.dart';
import 'package:memee/core/extensions/theme_extension.dart';
import 'package:memee/core/extensions/widget_extensions.dart';
import 'package:memee/core/utils/actual_discount_price.dart';
import 'package:memee/core/utils/app_colors.dart';
import 'package:memee/core/utils/app_di.dart';
import 'package:memee/core/widgets/add_remove_button.dart';
import 'package:memee/feature/cart/bloc/cart_bloc/cart_cubit.dart';
import 'package:memee/models/cart_model.dart';

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
            color: Colors.black12,
            blurRadius: 16.r,
            blurStyle: BlurStyle.outer,
          )
        ],
        color: AppColors.bgColor,
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
                          '${cart.name}'.toCapitalize(),
                          style: Theme.of(context).textTheme.textMDMedium,
                        ),
                        Text(
                          '${e.productDetails.qty} ${e.productDetails.type.name}',
                          style: Theme.of(context).textTheme.textMDMedium,
                        ),
                        ActualDiscountPrice(
                          units: e.units,
                          discountedPrice: e.productDetails.discountedPrice,
                          price: e.productDetails.price,
                        ),
                        SizedBox(height: 8.h),
                      ],
                    ).paddingS(),
                  ),
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
                  ).paddingS(h: 16.w, v: 8.h),
                ],
              )
            ],
          );
        },
      ),
    );
  }
}
