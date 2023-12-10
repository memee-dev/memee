import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:memee/core/extensions/theme_extension.dart';

import '../blocs/refresh_cubit.dart';
import '../utils/app_assets.dart';
import '../utils/app_colors.dart';
import '../utils/app_di.dart';

class AppButton extends StatefulWidget {
  final String text;
  final Function() onPressed;
  final Color color;
  final Color textColor;
  final double? width;
  final double? height;

  const AppButton.primary({
    super.key,
    required this.text,
    required this.onPressed,
    this.color = AppColors.primaryButtonColor,
    this.textColor = AppColors.textDarkColor,
    this.width,
    this.height,
  });

  const AppButton.secondary({
    super.key,
    required this.text,
    required this.onPressed,
    this.color = AppColors.secondaryButtonColor,
    this.textColor = AppColors.textDarkColor,
    this.width,
    this.height,
  });

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 5000),
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final refreshCubit = locator.get<RefreshCubit>();
    bool loading = false;
    return BlocBuilder<RefreshCubit, bool>(
      bloc: refreshCubit,
      builder: (_, state) {
        return SizedBox(
          width: widget.width ?? double.infinity,
          height: widget.height ?? 36.h,
          child: ElevatedButton(
            onPressed: () async {
              if (!loading) {
                loading = true;
                refreshCubit.change();
                await widget.onPressed();
                loading = false;
                refreshCubit.change();
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: widget.color,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            child: loading
                ? Lottie.asset(
                    AppAssets.loadingBtn,
                    repeat: false,
                    controller: _controller,
                  )
                : Text(
                    widget.text,
                    style: Theme.of(context).textTheme.textMDSemibold.copyWith(
                          color: widget.textColor,
                        ),
                  ),
          ),
        );
      },
    );
  }
}
