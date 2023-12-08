// AppTextField(
// //   controller: controller,
// //   label: 'Search Here',
// //   prefixIcon: const Icon(
// //     Icons.search,
// //     color: Colors.white,
// //   ),

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../utils/app_strings.dart';
import 'app_textfield.dart';

class AppSearchField extends StatelessWidget {
  final TextEditingController controller;

  const AppSearchField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      controller: controller,
      prefixIcon: const Icon(
        Icons.search,
        color: Colors.white,
      ),
      label: AppStrings.searchHint,
      inputFormatters: <TextInputFormatter>[
        LengthLimitingTextInputFormatter(10),
      ],
    );
  }
}
