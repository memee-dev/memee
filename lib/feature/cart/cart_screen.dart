import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:memee/blocs/cart/cart_cubit.dart';
import 'package:memee/blocs/payment/payment_cubit.dart';
import 'package:memee/blocs/user/user_cubit.dart';
import 'package:memee/core/extensions/widget_extensions.dart';
import 'package:memee/core/utils/app_di.dart';
import 'package:memee/core/utils/app_router.dart';
import 'package:memee/feature/cart/cart_address_widget.dart';
import 'package:memee/feature/cart/widgets/cart_item.dart';

import '../../core/widgets/app_button.dart';
import 'widgets/add_items_to_cart.dart';

class CartScreen extends StatelessWidget {
  CartScreen({super.key});

  final _cart = locator.get<CartCubit>();
  final _payment = locator.get<PaymentCubit>();

  @override
  Widget build(BuildContext context) {
    final user = locator.get<UserCubit>();

    return Column(
      children: [
        Expanded(
          child: BlocBuilder<CartCubit, CartState>(
            bloc: _cart..fetchCartItems(),
            builder: (context, state) {
              if (state is CartSuccess) {
                return state.cartItems.isNotEmpty
                    ? ListView.builder(
                        shrinkWrap: true,
                        itemCount: state.cartItems.length,
                        itemBuilder: (context, index) {
                          return CartItem(
                            key: Key('cartItem: $index'),
                            cart: state.cartItems[index],
                          ).gapBottom(16.h);
                        },
                      )
                    : const AddItemsToCart();
              }

              return const AddItemsToCart();
            },
          ).paddingS(
            h: 16.w,
            v: 16.h,
          ),
        ),
        BlocBuilder<CartCubit, CartState>(
          bloc: _cart,
          builder: (context, state) {
            if (state is CartSuccess) {
              String cartItemsNames =
                  state.cartItems.map((e) => e.name ?? '').toList().join(', ');
              return Column(
                children: [
                  if (user.currentUser.defaultAddress != null) ...[
                    CartAddressWidget(
                      address: user.currentUser.defaultAddress!,
                    ),
                  ],
                  BlocListener<PaymentCubit, PaymentState>(
                    bloc: _payment..init(),
                    listener: (_, pState) {
                      if (pState is PaymentSuccess) {
                        Routes.push(context, Routes.orderConfirmation,
                            extra: true);
                      }
                    },
                    child: AppButton.primary(
                      text: 'Pay now ${_cart.getTotalAmount('')}',
                      onPressed: () {
                        final user = locator.get<UserCubit>().currentUser;
                        var options = {
                          'key': 'rzp_test_5XcnJRQ3Lowiw0',
                          'amount':
                              double.parse(_cart.getTotalAmount('')) * 100,
                          'name': cartItemsNames,
                          'description': cartItemsNames,
                          'prefill': {
                            'contact': user.phoneNumber,
                            'email': user.email,
                          }
                        };
                        _payment.openCheckout(options);
                      },
                    ),
                  ),
                ],
              );
            }

            return const SizedBox.shrink();
          },
        ).paddingS(h: 16.w, v: 16.h),
      ],
    );
  }
}
