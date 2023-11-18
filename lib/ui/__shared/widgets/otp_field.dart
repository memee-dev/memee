import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpField extends StatelessWidget {
  final TextEditingController otpController;

  const OtpField({super.key, required this.otpController});

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      length: 6,
      obscureText: false,
      keyboardType: TextInputType.number,
      blinkWhenObscuring: true,
      enablePinAutofill: true,
      textStyle:
          Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.black),
      animationType: AnimationType.fade,
      animationDuration: const Duration(milliseconds: 300),
      pinTheme: PinTheme(
        borderRadius: BorderRadius.circular(
          12.r,
        ),
        fieldHeight: 50,
        fieldWidth: 50,
        errorBorderColor: Theme.of(context).colorScheme.primary,
        selectedColor: Colors.amberAccent,
        selectedFillColor: Colors.amberAccent,
        activeColor: Colors.amberAccent,
        activeFillColor: Colors.amberAccent,
        inactiveFillColor: Colors.black12,
        shape: PinCodeFieldShape.box,
      ),
      enableActiveFill: true,
      controller: otpController,
      onCompleted: (v) {},
      onChanged: (value) {},
      beforeTextPaste: (text) {
        return true;
      },
      appContext: context,
    );
  }
}
