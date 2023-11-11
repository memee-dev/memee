import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:memee/ui/__shared/extensions/widget_extensions.dart';

class HomeProductItem extends StatelessWidget {
  final String name, description, image;
  final GestureTapCallback? onTap;
  final double? height, width;

  const HomeProductItem({
    Key? key,
    required this.name,
    required this.description,
    this.height,
    this.width,
    required this.image,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height ?? MediaQuery.of(context).size.height * .16.h,
        width: width ?? MediaQuery.of(context).size.width * .32.w,
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              image,
              height: 36.h,
              width: 36.w,
            ),
            Text(
              name,
              style: Theme.of(context).textTheme.titleLarge,
            ).gapBottom(
              4.h,
            ),
            Text(
              description,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
