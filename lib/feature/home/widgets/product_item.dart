import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:memee/core/extensions/widget_extensions.dart';
import 'package:memee/models/product_model.dart';
import 'package:memee/core/widgets/cache_image_widget.dart';
import 'package:memee/feature/home/widgets/product_item_footer.dart';

class HomeProductItem extends StatelessWidget {
  final ProductModel product;
  final GestureTapCallback? onTap;
  final double? height, width;
  final bool? carousel;

  const HomeProductItem({
    Key? key,
    this.height,
    this.width,
    required this.product,
    this.onTap,
    this.carousel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            12.r,
          ),
          boxShadow: [
            BoxShadow(
              blurStyle: BlurStyle.outer,
              color: Colors.black12,
              blurRadius: 24.r,
              offset: const Offset(5, 5),
            )
          ],
          color: Colors.white38,
        ),
        child: ListTile(
          title: CacheImageWidget(
            imageUrl: (product.images ?? []).isNotEmpty
                ? (product.images ?? []).first
                : '',
            width: 64.w,
          ),
          contentPadding: EdgeInsets.zero,
          subtitle: Column(
            children: [
              ProductItemFooter(
                name: product.name,
                description: product.description,
                type:
                    'Per ${product.productDetails.first.type.name.toUpperCase()}',
                normalPrice:
                    product.productDetails.first.price.toStringAsFixed(2),
                discountPrice: product.productDetails.first.discountedPrice
                    .toStringAsFixed(2),
              ),
            ],
          ).paddingH(4),
        ),
      ),
    );
  }
}
