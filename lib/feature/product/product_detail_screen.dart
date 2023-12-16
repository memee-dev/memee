import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:memee/blocs/user/user_cubit.dart';
import 'package:memee/core/extensions/theme_extension.dart';
import 'package:memee/core/extensions/widget_extensions.dart';
import 'package:memee/core/utils/app_bar.dart';
import 'package:memee/core/utils/app_colors.dart';
import 'package:memee/core/utils/app_di.dart';
import 'package:memee/core/utils/app_strings.dart';
import 'package:memee/core/widgets/cache_image_widget.dart';
import 'package:memee/feature/cart/bloc/cart_bloc/cart_cubit.dart';
import 'package:memee/feature/product/bloc/product_cubit/product_cubit.dart';
import 'package:memee/feature/product/widget/total_item_price.dart';
import 'package:memee/models/product_model.dart';

import '../../core/widgets/add_remove_button.dart';

class ProductDetailScreen extends StatelessWidget {
  final ProductModel product;

  const ProductDetailScreen({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    final _cartCubit = locator.get<CartCubit>();
    final _user = locator.get<UserCubit>();
    return ScaffoldTemplate(
      title: product.name,
      actions: [
        BlocBuilder<UserCubit, UserState>(
          bloc: _user,
          builder: (context, state) {
            return IconButton(
              onPressed: () {
                product.favourite = !product.favourite;
                locator.get<ProductCubit>().updateFavourite(product);
                _user.addRemoveFavourites(product);
              },
              icon: Icon(
                product.favourite ? Icons.favorite : Icons.favorite_border,
                size: 24.r,
                color: AppColors.errorColor,
              ),
            );
          },
        ),
      ],
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 16.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  12.r,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.textLightColor.withOpacity(0.5),
                    blurRadius: 16.r,
                    blurStyle: BlurStyle.outer,
                  ),
                ],
              ),
              child: CacheImageWidget(
                imageUrl: (product.images ?? []).isNotEmpty
                    ? (product.images ?? []).first
                    : '',
                fit: BoxFit.cover,
              ),
            ).gapBottom(16.h),
            Text(
              product.description,
              style: Theme.of(context).textTheme.textMDMedium,
            ).gapBottom(8.h),
            SizedBox(height: 8.h),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: product.productDetails
                    .map(
                      (e) => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
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
                                      .textMDSemibold
                                      .copyWith(
                                        color: AppColors.textAccentDarkColor,
                                      ),
                                ),
                                Text(
                                  ' / ${AppStrings.rupee}${e.discountedPrice} \t',
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .textMDSemibold
                                      .copyWith(color: AppColors.displayColor),
                                ),
                                Text(
                                  '${AppStrings.rupee}${e.price}',
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .textMDSemibold
                                      .copyWith(
                                        color: AppColors.textLightColor,
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
                                  ((product.images ?? []).isNotEmpty)
                                      ? (product.images ?? []).first
                                      : '',
                                ),
                                onRemove: () =>
                                    _cartCubit.removeProduct(e, product.id),
                                quantity: _cartCubit.showQty(e, product.id),
                              );
                            },
                          ),
                        ],
                      ).gapTop(8.h),
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
