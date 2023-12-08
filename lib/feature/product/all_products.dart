import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:memee/blocs/product_cubit/product_cubit.dart';
import 'package:memee/core/extensions/widget_extensions.dart';
import 'package:memee/core/utils/app_bar.dart';
import 'package:memee/core/utils/app_di.dart';
import 'package:memee/core/utils/app_router.dart';
import 'package:memee/core/utils/app_strings.dart';
import 'package:memee/feature/home/widgets/product_item.dart';
import 'package:memee/feature/home/widgets/product_item_shimmer.dart';

class AllProducts extends StatelessWidget {
  const AllProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarTemplate(
        title: AppStrings.allProducts,
      ),
      body: BlocBuilder<ProductCubit, ProductState>(
        bloc: locator.get<ProductCubit>()..fetchProducts(),
        builder: (context, state) {
          if (state is ProductLoading) {
            return const ProductItemShimmer();
          } else if (state is ProductSuccess) {
            return ListView.separated(
              padding: EdgeInsets.symmetric(
                vertical: 16.h,
                horizontal: 16.w,
              ),
              shrinkWrap: true,
              itemBuilder: (_, i) {
                final e = state.products[i];
                return HomeProductItem(
                  product: state.products[i],
                  width: MediaQuery.of(context).size.width.w,
                  onTap: () {
                    Routes.push(
                      context,
                      Routes.productDetails,
                      extra: e,
                    );
                  },
                ).gapBottom(16.h);
              },
              itemCount: state.products.length,
              separatorBuilder: (BuildContext context, int index) => SizedBox(
                height: 8.h,
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
