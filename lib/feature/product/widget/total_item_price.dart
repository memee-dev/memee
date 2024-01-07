import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memee/core/extensions/theme_extension.dart';
import 'package:memee/core/utils/app_colors.dart';
import 'package:memee/core/utils/app_di.dart';
import 'package:memee/core/utils/app_router.dart';
import 'package:memee/core/utils/app_strings.dart';
import 'package:memee/core/widgets/app_button.dart';
import 'package:memee/feature/cart/bloc/cart_bloc/cart_cubit.dart';

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
              ? AppButton.primary(
                  text:
                      '${AppStrings.goToCart} ${AppStrings.rupee} ${_cartCubit.getTotalAmount(productId)}',
                  onPressed: () => Routes.push(context, Routes.cart),
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
