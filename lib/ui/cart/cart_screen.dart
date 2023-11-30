import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:memee/blocs/cart/cart_cubit.dart';
import 'package:memee/core/initializer/app_di.dart';
import 'package:memee/models/product_model.dart';
import 'package:memee/ui/__shared/extensions/widget_extensions.dart';
import 'package:memee/ui/__shared/widgets/app_button.dart';
import 'package:memee/ui/cart/widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  CartScreen({super.key});

  final _cart = locator.get<CartCubit>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Container(
        //   decoration: BoxDecoration(
        //     borderRadius: BorderRadius.only(
        //       bottomLeft: Radius.circular(
        //         12.r,
        //       ),
        //       bottomRight: Radius.circular(
        //         12.r,
        //       ),
        //     ),
        //     color: Theme.of(context).colorScheme.primary,
        //   ),
        //   child: const CartAddressWidget(),
        // ),
        Expanded(
          child: BlocBuilder<CartCubit, CartState>(
            bloc: _cart..fetchCartItems(),
            builder: (context, state) {
              if (state is CartSuccess) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.cartItems.length,
                  itemBuilder: (context, index) {
                    return CartItem(
                      key: Key('cartItem: $index'),
                      cart: state.cartItems[index],
                    ).gapBottom(16.h);
                  },
                );
              }

              return const SizedBox.shrink();
            },
          ).paddingS(
            h: 16.w,
            v: 16.h,
          ),
        ),
        BlocBuilder<CartCubit, CartState>(
          bloc: _cart,
          builder: (context, state) {
            return AppButton(
              label: 'Pay now ${_cart.getTotalAmount('')}',
              onTap: () {},
              fontSize: 12.sp,
              fontWeight: FontWeight.w900,
            );
          },
        ).paddingS(
          h: 16.w,
          v: 16.h,
        ),
      ],
    );
  }

  void removeFromCart(ProductModel product) {
    // Remove the product from the cart
    // You can add any additional logic here, such as updating the total price.
  }
}
