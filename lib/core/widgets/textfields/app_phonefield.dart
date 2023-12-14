import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../models/country_info_model.dart';
import 'app_textfield.dart';

class AppPhoneTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String selectedCountryCode;
  final void Function(String?)? onChanged;
  final TextInputType keyboardType;
  final bool autofocus;

  const AppPhoneTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.onChanged,
    required this.selectedCountryCode,
    this.keyboardType = TextInputType.text,
    this.autofocus = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      controller: controller,
      label: label,
      autofocus: autofocus,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'^\d*$')),
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(countryList
            .firstWhere((country) => country.code == selectedCountryCode)
            .length)
      ],
      keyboardType: keyboardType,
      prefixIcon: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(width: 16.w),
          SvgPicture.asset(
            countryList
                .firstWhere((country) => country.code == selectedCountryCode)
                .flag,
          ),
          SizedBox(width: 4.w),
          DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: selectedCountryCode,
              onChanged: onChanged,
              items: countryList
                  .map<DropdownMenuItem<String>>((CountryInfoModel country) {
                return DropdownMenuItem<String>(
                  value: country.code,
                  child: Text(country.code),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
