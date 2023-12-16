import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:memee/core/extensions/widget_extensions.dart';
import 'package:memee/core/utils/app_bar.dart';
import 'package:memee/core/utils/app_di.dart';
import 'package:memee/core/utils/app_router.dart';
import 'package:memee/core/widgets/textfields/app_searchfiled.dart';
import 'package:memee/feature/home/widgets/product_item.dart';
import 'package:memee/feature/home/widgets/product_item_shimmer.dart';
import 'package:memee/feature/product/bloc/product_cubit/product_cubit.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _product = locator.get<ProductCubit>();
    return ScaffoldTemplate(
      title: 'Search',
      body: Column(
        children: [
          const AppSearchField().paddingS(v: 16.h),
          BlocBuilder<ProductCubit, ProductState>(
            bloc: _product,
            builder: (context, state) {
              if (state == ProductState.loading) {
                return const ProductItemShimmer().paddingH();
              } else if (state == ProductState.error) {
                return Text(_product.error);
              } else if (state == ProductState.success) {
                return Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemCount: _product.filteredProducts.length >= 4
                        ? 4
                        : _product.filteredProducts.length,
                    itemBuilder: (_, i) {
                      final e = _product.filteredProducts[i];
                      return HomeProductItem(
                        product: _product.filteredProducts[i],
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
                  ),
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
