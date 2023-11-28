import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:memee/blocs/categories/categories_cubit.dart';
import 'package:memee/blocs/index/index_cubit.dart';
import 'package:memee/blocs/product_cubit/product_cubit.dart';
import 'package:memee/core/initializer/app_di.dart';
import 'package:memee/core/initializer/app_router.dart';
import 'package:memee/ui/__shared/extensions/widget_extensions.dart';
import 'package:memee/ui/__shared/widgets/app_textfield.dart';
import 'package:memee/ui/home/widgets/category_item.dart';
import 'package:memee/ui/home/widgets/product_item.dart';

class HomeWidget extends StatelessWidget {
  HomeWidget({Key? key}) : super(key: key);

  final TextEditingController controller = TextEditingController();
  final IndexCubit indexCubit = locator.get<IndexCubit>();
  final _categoryCubit = locator.get<CategoriesCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProductCubit>(
      create: (context) => locator.get<ProductCubit>()..fetchProducts(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppTextField(
            controller: controller,
            label: 'Search Here',
            prefixIcon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
          ).paddingS(
            v: 24.h,
            h: 0,
          ),
          Text(
            'Categories',
            style: Theme.of(context).textTheme.titleLarge,
          ).gapBottom(
            4.h,
          ),
          BlocBuilder<CategoriesCubit, CategoriesState>(
            bloc: _categoryCubit..fetchCategories(),
            builder: (context, state) {
              if (state is CategoriesLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
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
          ).paddingV(v: 16.h),
          Row(
            children: [
              Expanded(
                child: Text(
                  'Products',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              InkWell(
                onTap: () {
                  Routes.push(context, Routes.allProducts);
                },
                child: Text(
                  'View More',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
            ],
          ).gapBottom(
            16.h,
          ),
          BlocConsumer<ProductCubit, ProductState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is ProductLoading) {
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              } else if (state is ProductFailure) {
                return Text(state.message);
              } else if (state is ProductSuccess) {
                return ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
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
    );
  }
}
