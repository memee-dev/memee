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
  final Map<String, dynamic>? map;

  const AllProductsScreen({
    super.key,
    this.map,
  });

  @override
  Widget build(BuildContext context) {
    final _product = locator.get<ProductCubit>();
    final searchController = TextEditingController();
    return ScaffoldTemplate(
      title: map?['title'] ?? AppStrings.allProducts,
      body: Column(
        children: [
          AppSearchField(
            controller: searchController,
            productCubit: _product,
          ).paddingS(),
          BlocBuilder<ProductCubit, ProductState>(
            bloc: _product..fetchProducts(map?['categoryId'] ?? ''),
            builder: (context, state) {
              if (state is ProductLoading) {
                return const ProductItemShimmer().paddingS();
              } else if (state is ProductSuccess) {
                return Expanded(
                  child: ListView.separated(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
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
                      );
                    },
                    itemCount: state.products.length,
                    separatorBuilder: (BuildContext context, int index) =>
                        SizedBox(
                      height: 16.h,
                    ),
                  ).paddingS(v: 12.h),
                );
              }

              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}
