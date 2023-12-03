import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:memee/core/extensions/theme_extension.dart';
import 'package:memee/core/extensions/widget_extensions.dart';
import 'package:memee/core/widgets/cache_image_widget.dart';

class CategoryItem extends StatelessWidget {
  final String imageUrl, title;

  const CategoryItem({super.key, required this.imageUrl, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
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
          style: Theme.of(context).textTheme.textSMSemibold,
        ),
      ],
    );
  }
}
