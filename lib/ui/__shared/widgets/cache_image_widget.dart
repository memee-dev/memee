import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CacheImageWidget extends StatelessWidget {
  final double? height, width;
  final String imageUrl;

  const CacheImageWidget(
      {super.key, this.height, this.width, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(
        12.r,
      ),
      child: CachedNetworkImage(
        height: height ?? 36.h,
        width: width ?? 36.w,
        imageUrl: imageUrl,
        fadeInCurve: Curves.ease,
        progressIndicatorBuilder: (context, url, downloadProgress) => Center(
            child: CircularProgressIndicator(value: downloadProgress.progress)),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    );
  }
}
