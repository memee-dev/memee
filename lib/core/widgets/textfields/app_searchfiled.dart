// AppTextField(
// //   controller: controller,
// //   label: 'Search Here',
// //   prefixIcon: const Icon(
// //     Icons.search,
// //     color: Colors.white,
// //   ),

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:memee/core/utils/app_colors.dart';

import '../../utils/app_strings.dart';
import 'app_textfield.dart';

class AppSearchField extends StatelessWidget {
  final TextEditingController controller;

  const AppSearchField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurStyle: BlurStyle.outer,
            blurRadius: 24.r,
          )
        ],
        color: AppColors.bgColor,
        borderRadius: BorderRadius.circular(
          12.r,
        ),
      ),
      child: AppTextField(
        controller: controller,
        prefixIcon: const Icon(
          Icons.search,
          color: AppColors.textAccentDarkColor,
        ),
        borderColor: AppColors.bgColor,
        label: AppStrings.searchHint,
        inputFormatters: <TextInputFormatter>[
          LengthLimitingTextInputFormatter(10),
        ],
      ),
    );
  }
}
