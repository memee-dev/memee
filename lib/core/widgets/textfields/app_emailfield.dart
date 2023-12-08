import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../utils/app_strings.dart';
import '../../utils/app_textinputformatter.dart';
import 'app_textfield.dart';

class AppEmailField extends StatelessWidget {
  final TextEditingController controller;

  const AppEmailField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      controller: controller,
      label: AppStrings.emailHint,
      inputFormatters: <TextInputFormatter>[
        EmailInputFormatter(),
      ],
    );
  }
}
