import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:memee/models/product_model.dart';
import 'package:memee/ui/__shared/widgets/cache_image_widget.dart';
import 'package:memee/ui/home/widgets/product_item_footer.dart';

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
        height: height,
        width: width,
        margin: EdgeInsets.only(
          right: 12.w,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            12.r,
          ),
          boxShadow: const [
            BoxShadow(
              blurStyle: BlurStyle.outer,
              color: Colors.white,
            )
          ],
          color: Colors.white38,
        ),
        child: ListTile(
          title: CacheImageWidget(
            imageUrl: (product.images ?? []).isNotEmpty
                ? (product.images ?? []).first
                : '',
            width: MediaQuery.of(context).size.width,
          ),
          contentPadding: EdgeInsets.zero,
          subtitle: Column(
            children: [
              ProductItemFooter(
                name: product.name,
                description: product.description,
                type: product.productDetails.first.type == ProductType.kg
                    ? 'Per KG'
                    : 'Per Piece',
                normalPrice:
                    product.productDetails.first.price.toStringAsFixed(2),
                discountPrice: product.productDetails.first.discountedPrice
                    .toStringAsFixed(2),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
