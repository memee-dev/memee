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

    return ScaffoldTemplate(
      title: map?['title'] ?? AppStrings.allProducts,
      body: Column(
        children: [
          GestureDetector(
            onTap: () => Routes.push(context, Routes.search),
            child: AbsorbPointer(
              absorbing: true,
              child: const AppSearchField().paddingS(v: 16.h),
            ),
          ),
          BlocBuilder<ProductCubit, ProductState>(
            bloc: map?['categoryId'] != null
                ? _product
                    .fetchProductsBasedCategories(map?['categoryId'] ?? '')
                : _product,
            builder: (context, state) {
              if (state == ProductState.loading) {
                return const ProductItemShimmer().paddingS();
              } else if (state == ProductState.success) {
                var list = map?['categoryId'] != null
                    ? _product.filteredProducts
                    : _product.products;
                return Expanded(
                  child: ListView.separated(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    itemBuilder: (_, i) {
                      return HomeProductItem(
                        product: list[i],
                        width: MediaQuery.of(context).size.width.w,
                        onTap: () {
                          Routes.push(
                            context,
                            Routes.productDetails,
                            extra: list[i],
                          );
                        },
                      );
                    },
                    itemCount: list.length,
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
