import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:memee/blocs/cart/cart_cubit.dart';
import 'package:memee/core/initializer/app_di.dart';
import 'package:memee/core/shared/app_strings.dart';
import 'package:memee/models/product_model.dart';
import 'package:memee/ui/__shared/extensions/widget_extensions.dart';
import 'package:memee/ui/__shared/widgets/cache_image_widget.dart';
import 'package:memee/ui/product/widget/total_item_price.dart';

import '../__shared/widgets/add_remove_button.dart';

class ProductDescriptionScreen extends StatelessWidget {
  final ProductModel product;

  ProductDescriptionScreen({
    super.key,
    required this.product,
  });

  final _cartCubit = locator.get<CartCubit>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          product.name,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: Padding(
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
              child: CacheImageWidget(
                imageUrl: (product.images ?? []).isNotEmpty
                    ? (product.images ?? []).first
                    : '',
              ),
            ).gapBottom(16.h),
            Text(
              product.description,
              style: Theme.of(context).textTheme.bodySmall,
            ).gapBottom(8.h),
            SizedBox(height: 8.h),
            Expanded(
              child: Column(
                children: product.productDetails
                    .map(
                      (e) => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  '${e.qty} ${e.type.name.toUpperCase()}',
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                        color: Colors.amber,
                                        fontWeight: FontWeight.w900,
                                      ),
                                ),
                                Text(
                                  ' / ${AppStrings.rupee}${e.discountedPrice} \t',
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                        fontWeight: FontWeight.w900,
                                      ),
                                ),
                                Text(
                                  '${AppStrings.rupee}${e.price}',
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                        color: Colors.white12.withOpacity(0.5),
                                        fontWeight: FontWeight.w900,
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          BlocBuilder<CartCubit, CartState>(
                            bloc: _cartCubit,
                            builder: (_, state) {
                              return AddRemoveWidget(
                                onAdd: () => _cartCubit.addProduct(
                                  e,
                                  product.id,
                                  product.name,
                                  (product.images ?? []).first,
                                ),
                                onRemove: () =>
                                    _cartCubit.removeProduct(e, product.id),
                                quantity: _cartCubit.showQty(e, product.id),
                              );
                            },
                          ),
                        ],
                      ),
                    )
                    .toList(),
              ),
            ),
            const SizedBox(height: 16.0),
            TotalItemPrice(productId: product.id)
          ],
        ),
      ),
    );
  }
}
