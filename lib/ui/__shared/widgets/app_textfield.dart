import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final Widget? suffixIcon, prefixIcon;
  final String? label, hint;
  final String? title;
  final GestureTapCallback? onTap;
  final int? maxLines, minLines;
  final Color? textColor;
  final bool? obscureText;

  const AppTextField({
    Key? key,
    required this.controller,
    this.validator,
    this.suffixIcon,
    required this.label,
    this.title,
    this.onTap,
    this.maxLines,
    this.minLines,
    this.textColor,
    this.obscureText,
    this.hint,
    this.prefixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null) ...[
          Text(
            title!,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontSize: 8.r,
                  fontWeight: FontWeight.w800,
                ),
          ),
          SizedBox(height: 8.h),
        ],
        TextFormField(
          onChanged: (val) {},
          autovalidateMode: AutovalidateMode.onUserInteraction,
          textCapitalization: TextCapitalization.characters,
          controller: controller,
          minLines: minLines,
          maxLines: maxLines ?? 1,
          obscureText: obscureText ?? false,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                12.r,
              ),
            ),
            labelText: label,
            hintText: hint,
            suffixIcon: suffixIcon,
            labelStyle: Theme.of(context).textTheme.bodySmall,
            hintStyle: Theme.of(context).textTheme.bodySmall,
            prefixIcon: prefixIcon,
          ),
          validator: validator,
          keyboardType: TextInputType.text,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }
}
