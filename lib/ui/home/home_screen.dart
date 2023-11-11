import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:memee/blocs/index/index_cubit.dart';
import 'package:memee/core/initializer/app_di.dart';
import 'package:memee/core/shared/app_asset.dart';
import 'package:memee/core/shared/app_strings.dart';
import 'package:memee/models/product_model.dart';
import 'package:memee/ui/__shared/extensions/widget_extensions.dart';
import 'package:memee/ui/__shared/widgets/app_textfield.dart';
import 'package:memee/ui/home/widgets/product_item.dart';
import 'package:memee/ui/product_detail/product_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final TextEditingController controller = TextEditingController();
  final IndexCubit indexCubit = locator.get<IndexCubit>();
  final IndexCubit carousel = locator.get<IndexCubit>();

  @override
  Widget build(BuildContext context) {
    return Column(
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
        CarouselSlider.builder(
          itemCount: products.length,
          itemBuilder: (context, index, realIndex) {
            return HomeProductItem(
              width: MediaQuery.of(context).size.width * 0.64,
              name: products[index].name,
              description: products[index].name,
              image: products[index].imageUrl,
              onTap: () {
                context.go(
                  '/productDetails',
                  extra: products[index],
                );
              },
            );
          },
          options: CarouselOptions(
            initialPage: 0,
            enableInfiniteScroll: true,
            enlargeCenterPage: true,
            viewportFraction: 0.8,
            autoPlay: true,
            height: 112.h,
            autoPlayInterval: const Duration(seconds: 3),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
          ),
        ).gapBottom(
          16.h,
        ),
        Row(
          children: [
            Expanded(
              child: Text(
                'Products',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            Text(
              'View More',
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ],
        ).gapBottom(
          16.h,
        ),
        GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8.w,
            mainAxisSpacing: 24.h,
          ),
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: products.length,
          itemBuilder: (_, i) {
            final e = products[i];
            return HomeProductItem(
              name: e.name,
              description: e.shortDescription,
              image: e.imageUrl,
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => ProductDescriptionScreen(
                          product: e,
                        )));
                // context.go(
                //   '/productDetails',
                //   extra: e,
                // );
              },
            );
          },
        ),
      ],
    );
  }
}

List<Product> products = [
  Product(
    name: 'Chicken',
    shortDescription: 'High in Protein',
    fullDescription: AppStrings.chickenBenefits,
    price: 19.99,
    imageUrl: AppAsset.chicken,
  ),
  Product(
    name: 'Broccoli',
    shortDescription: 'High in protein',
    fullDescription: AppStrings.broccoliContent,
    price: 29.99,
    imageUrl: AppAsset.broccoli,
  ),
  Product(
    name: 'Beef',
    shortDescription: 'Rich in vitamins',
    fullDescription: AppStrings.beefContent,
    price: 29.99,
    imageUrl: AppAsset.beef,
  ),
  Product(
    name: 'Carrot',
    shortDescription: 'Good source of iron',
    fullDescription: AppStrings.carrotContent,
    price: 29.99,
    imageUrl: AppAsset.carrot,
  ),
];
