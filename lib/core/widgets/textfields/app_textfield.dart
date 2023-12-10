import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:memee/core/extensions/theme_extension.dart';

import '../../utils/app_colors.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? label;
  final bool obscureText;
  final bool autofocus;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool readOnly;
  final double? width;
  final Color? borderColor;
  final List<TextInputFormatter> inputFormatters;
  final TextInputType keyboardType;
  final InputDecoration decoration;
  final Function(String)? onChanged;
  final String? errorText;

  AppTextField({
    super.key,
    required this.controller,
    this.label,
    this.obscureText = false,
    this.autofocus = false,
    this.suffixIcon,
    this.prefixIcon,
    this.readOnly = false,
    this.width,
    List<TextInputFormatter>? inputFormatters,
    this.keyboardType = TextInputType.text,
    InputDecoration? decoration,
    this.onChanged,
    this.errorText, this.borderColor,
  })  : inputFormatters = inputFormatters ?? [],
        decoration = decoration ??
            const InputDecoration(
              border: OutlineInputBorder(),
            );

  AppTextField.digits({
    Key? key,
    required TextEditingController controller,
    String? label,
    String? errorText,
    bool obscureText = false,
    bool autofocus = false,
    bool isBorder = true,
    Widget? suffixIcon,
    Widget? prefixIcon,
    bool readOnly = false,
    double? width,
    Function(String)? onChanged,
  }) : this(
          key: key,
          controller: controller,
          label: label,
          obscureText: obscureText,
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          readOnly: readOnly,
          width: width,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          onChanged: onChanged,
        );

  AppTextField.decimals({
    Key? key,
    required TextEditingController controller,
    String? label,
    String? errorText,
    bool obscureText = false,
    bool autofocus = false,
    Widget? suffixIcon,
    Widget? prefixIcon,
    bool readOnly = false,
    double? width,
    Function(String)? onChanged,
  }) : this(
          key: key,
          controller: controller,
          label: label,
          obscureText: obscureText,
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          readOnly: readOnly,
          width: width,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))
          ],
          onChanged: onChanged,
          errorText: errorText,
        );

  @override
  Widget build(BuildContext context) {
    return TextField(
      key: key,
      readOnly: readOnly,
      inputFormatters: inputFormatters,
      obscureText: obscureText,
      controller: controller,
      style: Theme.of(context).textTheme.bodySmall,
      autofocus: autofocus,
      keyboardType: keyboardType,
      onChanged: onChanged,
      decoration: decoration.copyWith(
        errorText: errorText,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(
            width: 1.w,
            color: borderColor ?? AppColors.borderColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(
            width: 1.w,
            color: borderColor ?? AppColors.borderColor,
          ),
        ),
        hintText: label,
        hintStyle: Theme.of(context).textTheme.textMDRegular,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
      ),
    );
  }
}
