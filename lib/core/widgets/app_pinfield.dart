import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';

import '../extensions/theme_extension.dart';

class AppPinField extends StatelessWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final Function(String)? onCompleted;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final int length;

  const AppPinField({
    super.key,
    this.controller,
    this.focusNode,
    this.onCompleted,
    this.onChanged,
    this.validator,
    this.length = 4,
  });

  @override
  Widget build(BuildContext context) {
    return Pinput(
      controller: controller,
      focusNode: focusNode,
      length: length,
      androidSmsAutofillMethod: AndroidSmsAutofillMethod.smsUserConsentApi,
      listenForMultipleSmsOnAndroid: true,
      defaultPinTheme: AppPinTheme.defaultPinTheme,
      separatorBuilder: (index) => SizedBox(width: 8.w),
      validator: validator,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
      ],
      hapticFeedbackType: HapticFeedbackType.lightImpact,
      onCompleted: onCompleted,
      onChanged: onChanged,
      focusedPinTheme: AppPinTheme.defaultPinTheme,
      submittedPinTheme: AppPinTheme.defaultPinTheme,
      errorPinTheme: AppPinTheme.defaultPinTheme,
    );
  }
}
