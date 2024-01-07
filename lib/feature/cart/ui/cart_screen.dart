import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:memee/blocs/user/user_cubit.dart';
import 'package:memee/blocs/utility/utility_cubit.dart';
import 'package:memee/core/extensions/widget_extensions.dart';
import 'package:memee/core/utils/app_assets.dart';
import 'package:memee/core/utils/app_colors.dart';
import 'package:memee/core/utils/app_di.dart';
import 'package:memee/core/utils/app_router.dart';
import 'package:memee/core/utils/app_strings.dart';
import 'package:memee/core/widgets/confirmation_dialog.dart';
import 'package:memee/core/widgets/empty_widget.dart';
import 'package:memee/feature/cart/bloc/cart_bloc/cart_cubit.dart';
import 'package:memee/feature/cart/bloc/payment/payment_cubit.dart';
import 'package:memee/feature/cart/ui/widgets/cart_item.dart';
import 'package:memee/feature/cart/ui/widgets/pay_now_widget.dart';
import 'package:memee/feature/cart/ui/widgets/selected_time_slots.dart';

class CartWidget extends StatelessWidget {
  const CartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final _cart = locator.get<CartCubit>();
    final _payment = locator.get<PaymentCubit>();
    final _user = locator.get<UserCubit>();
    final _slots = locator.get<UtilityCubit>();

    return Column(
      children: [
        Expanded(
          child: BlocBuilder<CartCubit, CartState>(
            bloc: _cart,
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
                    : const EmptyWidget(
                        lottieAsset: AppAssets.cartEmpty,
                        content: AppStrings.addItemsToCart,
                      );
              }

              if (state is! CartLoading) {
                return const EmptyWidget(
                  lottieAsset: AppAssets.cartEmpty,
                  content: AppStrings.addItemsToCart,
                );
              }

              return const SizedBox();
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
              if (state.cartItems.isNotEmpty) {
                String cartItemsNames = state.cartItems
                    .map((e) => e.name ?? '')
                    .toList()
                    .join(', ');
                return Column(
                  children: [
                    BlocBuilder<UserCubit, UserState>(
                      bloc: _user,
                      builder: (context, state) {
                        if (state == UserState.success) {
                          return Column(
                            children: [
                              const SelectedTimeSlots(),
                              if (_user.currentUser?.defaultAddress != null)
                                BlocListener<PaymentCubit, PaymentState>(
                                  bloc: _payment..init(),
                                  listener: (_, pState) {
                                    if (pState is PaymentSuccess) {
                                      Routes.push(
                                          context, Routes.orderConfirmation,
                                          extra: true);
                                    } else if (pState is PaymentFailure) {
                                      Routes.push(
                                          context, Routes.orderConfirmation);
                                    } else if (pState is PaymentWalletFailure) {
                                      showFailureMessage(
                                          context, pState.message);
                                    }
                                  },
                                  child:
                                      BlocBuilder<UtilityCubit, UtilityState>(
                                    bloc: _slots,
                                    builder: (context, state) {
                                      return ((_slots.selectedTime ?? '')
                                                  .isNotEmpty ||
                                              _slots.instantDelivery)
                                          ? PayNowWidget(
                                              totalAmount:
                                                  _cart.getTotalAmount(''),
                                              onCashPayment: () =>
                                                  _payment.cashOnDelivery(),
                                              address: _user
                                                  .currentUser?.defaultAddress,
                                              isEmpty:
                                                  (_user.currentUser?.address ??
                                                          [])
                                                      .isEmpty,
                                              slotAvailableToday: true,
                                              onOnlinePayment: () {
                                                final user = locator
                                                    .get<UserCubit>()
                                                    .currentUser;
                                                var options = {
                                                  'key':
                                                      'rzp_test_5XcnJRQ3Lowiw0',
                                                  'amount': double.parse(_cart
                                                          .getTotalAmount('')) *
                                                      100,
                                                  'name': cartItemsNames,
                                                  'description': cartItemsNames,
                                                  'prefill': {
                                                    'contact':
                                                        user?.phoneNumber,
                                                    'email': user?.email,
                                                  }
                                                };
                                                _payment.openCheckout(options);
                                              },
                                            )
                                          : const SizedBox.shrink();
                                    },
                                  ),
                                ),
                            ],
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                  ],
                );
              }
            }

            return const SizedBox.shrink();
          },
        ).paddingS(h: 16.w, v: 16.h),
      ],
    );
  }

  void showFailureMessage(context, message) {
    showCupertinoDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return ConfirmationDialog(
          title: AppStrings.paymentFailed,
          description: message,
          buttonLabel1: AppStrings.dismiss,
          titleTextColor: AppColors.errorColor,
          negativeBtn: () => Routes.pop(context),
        );
      },
    );
  }
}
