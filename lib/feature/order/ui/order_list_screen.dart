import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:memee/core/utils/app_assets.dart';
import 'package:memee/core/utils/app_bar.dart';
import 'package:memee/core/utils/app_di.dart';
import 'package:memee/core/utils/app_router.dart';
import 'package:memee/core/utils/app_strings.dart';
import 'package:memee/core/widgets/empty_widget.dart';
import 'package:memee/feature/order/bloc/order_cubit.dart';
import 'package:memee/feature/order/ui/widgets/order_item.dart';

class OrderListScreen extends StatelessWidget {
  const OrderListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldTemplate(
      title: AppStrings.orders,
      body: BlocConsumer<OrderCubit, OrderState>(
        bloc: locator.get<OrderCubit>()..getOrders(),
        listener: (_, state) {
          if (state is OrderSuccess) {
            if (state.updated ?? false) {
              Routes.pop(context);
            }
          }
        },
        builder: (context, state) {
          if (state is OrderLoading) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          } else if (state is OrderSuccess) {
            return state.orders.isNotEmpty
                ? ListView.separated(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 24.h,
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
      ),
    );
  }
}