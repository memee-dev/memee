import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:memee/models/product_model.dart';
import 'package:memee/ui/__shared/extensions/widget_extensions.dart';

class ProductDescriptionScreen extends StatelessWidget {
  final ProductModel? product;

  const ProductDescriptionScreen({
    super.key,
    this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          ' Description',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 16.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  12.r,
                ),
                color: Theme.of(context).colorScheme.primary,
                boxShadow: const [
                  BoxShadow(
                    offset: Offset(10, 10),
                  ),
                ],
              ),
              padding: EdgeInsets.all(
                16.r,
              ),
              child: Container(),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '',
                  style: Theme.of(context).textTheme.titleLarge,
                ).paddingV(
                  v: 16.h,
                ),
                Text(
                  product?.description ?? '',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    // Expanded(
                    //   child: Text(
                    //     '\$${(product?.details?.first.dPrice ?? '0')}',
                    //     style:
                    //         Theme.of(context).textTheme.titleMedium?.copyWith(
                    //               fontWeight: FontWeight.bold,
                    //               color: Colors.green,
                    //             ),
                    //   ),
                    // ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            //addToCart(product);
                          },
                          icon: const Icon(Icons.add),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.remove),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigateToCart();
        },
        child: const Icon(Icons.shopping_cart),
      ),
    );
  }

  void addToCart(ProductModel product) {}

  void navigateToCart() {}
}
