import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:memee/core/extensions/theme_extension.dart';
import 'package:memee/core/extensions/widget_extensions.dart';
import 'package:memee/core/utils/app_di.dart';
import 'package:memee/core/utils/app_router.dart';
import 'package:memee/core/utils/app_strings.dart';
import 'package:memee/feature/home/widgets/category_item.dart';
import 'package:memee/feature/home/widgets/product_item.dart';
import 'package:memee/feature/home/widgets/product_item_shimmer.dart';
import 'package:memee/feature/product/bloc/categories/categories_cubit.dart';
import 'package:memee/feature/product/bloc/product_cubit/product_cubit.dart';

import '../../core/widgets/textfields/app_searchfiled.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _categoryCubit = locator.get<CategoriesCubit>();
    final _product = locator.get<ProductCubit>();
    return SingleChildScrollView(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => Routes.push(context, Routes.search),
            child: AbsorbPointer(
              absorbing: true,
              child: const AppSearchField().paddingS(v: 16.h),
            ),
          ),
          Text(
            AppStrings.categories,
            style: Theme.of(context).textTheme.textXLMedium,
          ).paddingS(v: 4.h),
          BlocBuilder<CategoriesCubit, CategoriesState>(
            bloc: _categoryCubit..fetchCategories(),
            builder: (context, state) {
              if (state is CategoriesResponseState) {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: state.categories
                        .map(
                          (e) => CategoryItem(
                            imageUrl: e.image,
                            title: e.name,
                            onTap: () {
                              Routes.push(context, Routes.allProducts, extra: {
                                'title': e.name,
                                'categoryId': e.id,
                              });
                            },
                          ).gapRight(
                            8.w,
                          ),
                        )
                        .toList(),
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ).paddingS(v: 8.h),
          SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(
                child: Text(
                  AppStrings.products,
                  style: Theme.of(context).textTheme.textXLMedium,
                ),
              ),
              InkWell(
                onTap: () {
                  Routes.push(context, Routes.allProducts, extra: {
                    'title': null,
                    'categoryId': null,
                  });
                },
                child: Text(
                  AppStrings.viewMore,
                  style: Theme.of(context).textTheme.textMDMedium,
                ),
              ),
            ],
          ).paddingH(),
          BlocBuilder<ProductCubit, ProductState>(
            builder: (context, state) {
              if (state == ProductState.loading) {
                return const ProductItemShimmer().paddingH();
              } else if (state == ProductState.error) {
                return Text(_product.error);
              } else if (state == ProductState.success) {
                return ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemCount: _product.products.length >= 4
                      ? 4
                      : _product.products.length,
                  itemBuilder: (_, i) {
                    final e = _product.products[i];
                    return HomeProductItem(
                      product: _product.products[i],
                      width: MediaQuery.of(context).size.width.w,
                      onTap: () {
                        Routes.push(
                          context,
                          Routes.productDetails,
                          extra: e,
                        );
                      },
                    ).paddingS();
                  },
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
