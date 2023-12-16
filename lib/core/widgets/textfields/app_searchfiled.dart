import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:memee/core/utils/app_colors.dart';
import 'package:memee/core/utils/app_di.dart';
import 'package:memee/feature/product/bloc/product_cubit/product_cubit.dart';

import '../../utils/app_strings.dart';
import 'app_textfield.dart';

class AppSearchField extends StatelessWidget {
  const AppSearchField({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.textAccentDarkColor,
          width: 2.4.w,
          strokeAlign: BorderSide.strokeAlignInside,
        ),
        color: AppColors.bgColor,
        borderRadius: BorderRadius.circular(
          12.r,
        ),
      ),
      child: AppTextField(
        controller: controller,
        prefixIcon: Icon(
          Icons.search,
          size: 24.r,
          color: AppColors.textAccentDarkColor,
        ),
        onChanged: (String value) =>
            locator.get<ProductCubit>().searchProducts(context, value),
        borderColor: AppColors.bgColor,
        label: AppStrings.searchHint,
        inputFormatters: <TextInputFormatter>[
          LengthLimitingTextInputFormatter(10),
        ],
      ),
    );
  }
}
