import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../utils/app_strings.dart';
import 'app_textfield.dart';

class AppNameField extends StatelessWidget {
  final TextEditingController controller;

  const AppNameField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      controller: controller,
      label: AppStrings.nameHint,
      inputFormatters: <TextInputFormatter>[
        LengthLimitingTextInputFormatter(10),
      ],
    );
  }
}
