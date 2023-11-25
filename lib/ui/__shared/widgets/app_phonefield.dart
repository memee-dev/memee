import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:memee/ui/__shared/extensions/widget_extensions.dart';

import '../../../blocs/hide_and_seek/toggle_cubit.dart';
import '../../../core/shared/app_strings.dart';
import '../../../models/country_code_model.dart';
import 'app_dropdown.dart';
import 'app_textfield.dart';

class AppPhoneField extends StatelessWidget {
  final TextEditingController controller;
  final ToggleCubit cubit;
  final CountryCodeModel selectedCountryCode;
  final Function(CountryCodeModel?) onChanged;
  const AppPhoneField({
    super.key,
    required this.controller,
    required this.cubit,
    required this.selectedCountryCode,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        BlocBuilder<ToggleCubit, bool>(
          bloc: cubit,
          builder: (_, state) {
            return AppDropDown<CountryCodeModel>(
              value: selectedCountryCode,
              items: countryCodes,
              onChanged: onChanged,
            );
          },
        ).gapRight(8.w),
        AppTextField(
          controller: controller,
          label: AppStrings.number,
          inputFormatters: [
            LengthLimitingTextInputFormatter(10),
            FilteringTextInputFormatter.digitsOnly,
          ],
        ).flexible(),
      ],
    );
  }
}
