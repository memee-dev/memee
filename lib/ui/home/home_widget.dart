import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:memee/blocs/index/index_cubit.dart';
import 'package:memee/blocs/product_cubit/product_cubit.dart';
import 'package:memee/core/initializer/app_di.dart';
import 'package:memee/core/initializer/app_router.dart';
import 'package:memee/core/shared/app_asset.dart';
import 'package:memee/core/shared/app_strings.dart';
import 'package:memee/models/product_model.dart';
import 'package:memee/ui/__shared/extensions/widget_extensions.dart';
import 'package:memee/ui/__shared/widgets/app_textfield.dart';
import 'package:memee/ui/home/widgets/product_item.dart';

class HomeWidget extends StatelessWidget {
  HomeWidget({Key? key}) : super(key: key);

  final TextEditingController controller = TextEditingController();
  final IndexCubit indexCubit = locator.get<IndexCubit>();
  final IndexCubit carousel = locator.get<IndexCubit>();

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
            'Popular Items',
            style: Theme.of(context).textTheme.titleLarge,
          ).gapBottom(
            16.h,
          ),
          // CarouselSlider.builder(
          //   itemCount: products.length,
          //   itemBuilder: (context, index, realIndex) {
          //     return HomeProductItem(
          //       width: MediaQuery.of(context).size.width * 0.64,
          //       name: products[index].name,
          //       description: products[index].name,
          //       image: products[index].imageUrl,
          //       carousel: true,
          //       onTap: () {
          //         Routes.push(context, Routes.shoppingCart,
          //             extra: products);
          //       },
          //     );
          //   },
          //   options: CarouselOptions(
          //     initialPage: 0,
          //     enableInfiniteScroll: true,
          //     enlargeCenterPage: true,
          //     viewportFraction: 0.8,
          //     autoPlay: true,
          //     height: 112.h,
          //     autoPlayInterval: const Duration(seconds: 3),
          //     autoPlayAnimationDuration: const Duration(milliseconds: 800),
          //     autoPlayCurve: Curves.fastOutSlowIn,
          //   ),
          // ).gapBottom(
          //   16.h,
          // ),
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
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8.w,
                    mainAxisSpacing: 24.h,
                  ),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount:
                      state.products.length >= 4 ? 4 : state.products.length,
                  itemBuilder: (_, i) {
                    final e = state.products[i];
                    return HomeProductItem(
                      name: e.name ?? '',
                      description: e.description  ?? '',
                      image: e.images!.first ,
                      width: MediaQuery.of(context).size.width.w,
                      height: 64.h,
                      onTap: () {
                        Routes.push(
                          context,
                          Routes.productDetails,
                          extra: e,
                        );
                      },
                    );
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
