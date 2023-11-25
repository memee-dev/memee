import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:memee/ui/__shared/extensions/widget_extensions.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  final Widget? suffixIcon, prefixIcon;
  final String? label, hint, errorText;
  final String? title;
  final GestureTapCallback? onTap;
  final int? maxLines, minLines;
  final Color? textColor;
  final bool? obscureText;
  final TextInputType? keyboardType;
  final bool readOnly;
  final VoidCallback? onEditingComplete;
  final List<TextInputFormatter>? inputFormatters;

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
    this.keyboardType,
    this.errorText,
    this.onChanged,
    this.readOnly = false,
    this.inputFormatters,
    this.onEditingComplete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (title != null) ...[
          Text(
            title!,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontSize: 8.sp,
                  fontWeight: FontWeight.w700,
                ),
          ).gapBottom(8.h)
        ],
        TextFormField(
          readOnly: readOnly,
          onChanged: onChanged,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: controller,
          minLines: minLines,
          maxLines: maxLines ?? 1,
          inputFormatters: inputFormatters,
          obscureText: obscureText ?? false,
          cursorColor: Theme.of(context).colorScheme.primary,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white70),
              borderRadius: BorderRadius.all(Radius.circular(8.r)),
              gapPadding: 0.0,
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white70),
              borderRadius: BorderRadius.all(Radius.circular(8.r)),
              gapPadding: 0.0,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white70),
              borderRadius: BorderRadius.all(Radius.circular(8.r)),
              gapPadding: 0.0,
            ),
            errorText: errorText,
            errorStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.red,
                ),
            labelText: label,
            hintText: hint,
            suffixIcon: suffixIcon,
            labelStyle: Theme.of(context).textTheme.bodySmall,
            hintStyle: Theme.of(context).textTheme.bodySmall,
            prefixIcon: prefixIcon,
          ),
          onEditingComplete: onEditingComplete,
          maxLengthEnforcement: MaxLengthEnforcement.none,
          validator: validator,
          keyboardType: keyboardType ?? TextInputType.text,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}
