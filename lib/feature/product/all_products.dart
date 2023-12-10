import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:memee/core/extensions/widget_extensions.dart';
import 'package:memee/core/utils/app_bar.dart';
import 'package:memee/core/utils/app_di.dart';
import 'package:memee/core/utils/app_router.dart';
import 'package:memee/core/utils/app_strings.dart';
import 'package:memee/feature/home/widgets/product_item.dart';
import 'package:memee/feature/home/widgets/product_item_shimmer.dart';
import 'package:memee/feature/product/bloc/product_cubit/product_cubit.dart';

import '../../core/widgets/textfields/app_searchfiled.dart';

class AllProductsScreen extends StatelessWidget {
  const AllProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final searchController = TextEditingController();
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
            return Column(
              children: [
                AppSearchField(controller: searchController).gapBottom(12.h),
                Expanded(
                  child: ListView.separated(
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
                    separatorBuilder: (BuildContext context, int index) =>
                        SizedBox(
                      height: 8.h,
                    ),
                  ),
                ),
              ],
            ).paddingS();
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
