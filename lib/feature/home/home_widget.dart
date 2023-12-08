import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:memee/blocs/categories/categories_cubit.dart';
import 'package:memee/blocs/index/index_cubit.dart';
import 'package:memee/blocs/product_cubit/product_cubit.dart';
import 'package:memee/core/extensions/theme_extension.dart';
import 'package:memee/core/extensions/widget_extensions.dart';
import 'package:memee/core/utils/app_di.dart';
import 'package:memee/core/utils/app_router.dart';
import 'package:memee/core/utils/app_strings.dart';
import 'package:memee/feature/home/widgets/category_item.dart';
import 'package:memee/feature/home/widgets/product_item.dart';
import 'package:memee/feature/home/widgets/product_item_shimmer.dart';

class HomeWidget extends StatelessWidget {
  HomeWidget({Key? key}) : super(key: key);

  final TextEditingController controller = TextEditingController();
  final IndexCubit indexCubit = locator.get<IndexCubit>();
  final _categoryCubit = locator.get<CategoriesCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProductCubit>(
      create: (context) => locator.get<ProductCubit>()..fetchProducts(),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // AppTextField(
            //   controller: controller,
            //   label: 'Search Here',
            //   prefixIcon: const Icon(
            //     Icons.search,
            //     color: Colors.white,
            //   ),
            // ).paddingS(
            //   v: 24.h,
            //   h: 0,
            // ),
            SizedBox(height: 16.h),
            Text(
              AppStrings.categories,
              style: Theme.of(context).textTheme.textXLBold,
            ).gapBottom(
              8.h,
            ),
            BlocBuilder<CategoriesCubit, CategoriesState>(
              bloc: _categoryCubit..fetchCategories(),
              builder: (context, state) {
                if (state is CategoriesResponseState) {
                  return Row(
                    children: state.categories
                        .map(
                          (e) => Expanded(
                            child: CategoryItem(
                              imageUrl: e.image,
                              title: e.name,
                            ).gapRight(
                              8.w,
                            ),
                          ),
                        )
                        .toList(),
                  );
                }
                return const SizedBox.shrink();
              },
            ).gapBottom(24.h),
            Row(
              children: [
                Expanded(
                  child: Text(
                    AppStrings.products,
                    style: Theme.of(context).textTheme.textXLBold,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Routes.push(context, Routes.allProducts);
                  },
                  child: Text(
                    AppStrings.viewMore,
                    style: Theme.of(context).textTheme.textMDBold,
                  ),
                ),
              ],
            ).gapBottom(8.h),
            BlocConsumer<ProductCubit, ProductState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is ProductLoading) {
                  return const ProductItemShimmer();
                } else if (state is ProductFailure) {
                  return Text(state.message);
                } else if (state is ProductSuccess) {
                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    itemCount:
                        state.products.length >= 4 ? 4 : state.products.length,
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
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ).paddingS(h: 16.w, v: 16.h),
    );
  }
}
