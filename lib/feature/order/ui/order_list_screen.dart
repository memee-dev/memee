import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:memee/core/utils/app_assets.dart';
import 'package:memee/core/utils/app_bar.dart';
import 'package:memee/core/utils/app_di.dart';
import 'package:memee/core/utils/app_strings.dart';
import 'package:memee/core/widgets/empty_widget.dart';
import 'package:memee/feature/order/bloc/order_cubit.dart';
import 'package:memee/feature/order/ui/widgets/order_item.dart';

class OrderListScreen extends StatelessWidget {
  const OrderListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarTemplate(
        title: AppStrings.orders,
      ),
      body: BlocProvider<OrderCubit>.value(
        value: locator.get<OrderCubit>()..getOrders(),
        child: _Orders(),
      ),
    );
  }
}

class _Orders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderCubit, OrderState>(
      bloc: locator.get<OrderCubit>(),
      builder: (context, state) {
        if (state is OrderSuccess) {
          return state.orders.isNotEmpty
              ? ListView.separated(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 12.h,
                  ),
                  shrinkWrap: true,
                  itemBuilder: (_, i) {
                    return OrderItem(
                      order: state.orders[i],
                    );
                  },
                  separatorBuilder: (_, i) {
                    return SizedBox(
                      height: 8.h,
                    );
                  },
                  itemCount: state.orders.length,
                )
              : const EmptyWidget(
                  lottieAsset: AppAssets.orderEmpty,
                  content: AppStrings.ordersAreEmpty,
                );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
