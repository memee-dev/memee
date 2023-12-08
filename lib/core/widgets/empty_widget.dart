import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:memee/core/extensions/theme_extension.dart';
import 'package:memee/core/utils/app_colors.dart';

class EmptyWidget extends StatelessWidget {
  final String lottieAsset, content;

  const EmptyWidget({
    super.key,
    required this.lottieAsset,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Lottie.asset(lottieAsset),
        Text(
          content,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.textLGBold.copyWith(
                color: AppColors.accentDarkColor,
              ),
        ),
      ],
    );
  }
}
