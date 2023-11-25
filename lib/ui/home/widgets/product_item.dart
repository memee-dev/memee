import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:memee/ui/__shared/extensions/widget_extensions.dart';
import 'package:memee/ui/__shared/widgets/cache_image_widget.dart';

class HomeProductItem extends StatelessWidget {
  final String name, description, image;
  final GestureTapCallback? onTap;
  final double? height, width;
  final bool? carousel;

  const HomeProductItem({
    Key? key,
    required this.name,
    required this.description,
    this.height,
    this.width,
    required this.image,
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
        padding: EdgeInsets.symmetric(
          horizontal: 4.w,
          vertical: 4.h,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            12.r,
          ),
          boxShadow: [
            BoxShadow(
              blurStyle: BlurStyle.outer,
              blurRadius: 24.r,
              offset: const Offset(10, 10),
            )
          ],
          color: Theme.of(context).colorScheme.primary,
        ),
        child: ListTile(
          title: carousel ?? false
              ? Image.asset(
                  image,
                  height: height ?? 36.h,
                  width: width ?? 36.w,
                )
              : CacheImageWidget(
                  imageUrl: image,
                  height: height ?? 36.h,
                  width: width ?? 36.w,
                ),
          subtitle: Column(
            children: [
              Text(
                name,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.black,
                    ),
              ).paddingV(
                v: 4.h,
              ),
              Text(
                description,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
