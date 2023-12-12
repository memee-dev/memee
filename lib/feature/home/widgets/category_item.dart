import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:memee/core/extensions/theme_extension.dart';
import 'package:memee/core/extensions/widget_extensions.dart';
import 'package:memee/core/widgets/cache_image_widget.dart';

class CategoryItem extends StatelessWidget {
  final String imageUrl, title;

  final GestureTapCallback? onTap;

  const CategoryItem({
    super.key,
    required this.imageUrl,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          CacheImageWidget(
            imageUrl: imageUrl,
            radius: 48.r,
            height: 48.h,
            width: 56.w,
            fit: BoxFit.cover,
          ).gapBottom(8.h),
          Text(
            title,
            style: Theme.of(context).textTheme.textSMMedium,
          ),
        ],
      ),
    );
  }
}
