import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class CacheImageWidget extends StatelessWidget {
  final double? height, width;
  final String imageUrl;
  final BoxFit? fit;
  final double? radius;

  const CacheImageWidget({
    super.key,
    this.height,
    this.width,
    required this.imageUrl,
    this.fit,
    this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(
        radius ?? 12.r,
      ),
      child: CachedNetworkImage(
        height: height,
        width: width,
        alignment: Alignment.center,
        color: Theme.of(context).colorScheme.secondary,
        colorBlendMode: BlendMode.darken,
        fit: fit ?? BoxFit.contain,
        imageUrl: imageUrl,
        fadeInCurve: Curves.ease,
        progressIndicatorBuilder: (context, url, downloadProgress) =>
            Shimmer.fromColors(
          baseColor: Colors.grey[600]!, // Change these colors as desired
          highlightColor: Colors.grey[200]!,
          child: Container(
            color: Colors.white, // Ensure this color matches your background
          ),
        ),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    );
  }
}
