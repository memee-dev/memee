import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';

import '../utils/app_colors.dart';

extension AppTextTheme on TextTheme {
  TextStyle get display2XLRegular {
    return TextStyle(
      fontSize: 68.sp,
      fontWeight: FontWeight.w300,
    );
  }

  TextStyle get display2XLMedium {
    return TextStyle(
      fontSize: 68.sp,
      fontWeight: FontWeight.w500,
    );
  }

  TextStyle get display2XLSemibold {
    return TextStyle(
      fontSize: 68.sp,
      fontWeight: FontWeight.w700,
    );
  }

  TextStyle get display2XLBold {
    return TextStyle(
      fontSize: 68.sp,
      fontWeight: FontWeight.w900,
    );
  }

  TextStyle get displayXLRegular {
    return TextStyle(
      fontSize: 56.sp,
      fontWeight: FontWeight.w300,
    );
  }

  TextStyle get displayXLMedium {
    return TextStyle(
      fontSize: 56.sp,
      fontWeight: FontWeight.w500,
    );
  }

  TextStyle get displayXLSemibold {
    return TextStyle(
      fontSize: 56.sp,
      fontWeight: FontWeight.w700,
    );
  }

  TextStyle get displayXLBold {
    return TextStyle(
      fontSize: 56.sp,
      fontWeight: FontWeight.w900,
    );
  }

  TextStyle get displayLGRegular {
    return TextStyle(
      fontSize: 48.sp,
      fontWeight: FontWeight.w300,
    );
  }

  TextStyle get displayLGMedium {
    return TextStyle(
      fontSize: 48.sp,
      fontWeight: FontWeight.w500,
    );
  }

  TextStyle get displayLGSemibold {
    return TextStyle(
      fontSize: 48.sp,
      fontWeight: FontWeight.w700,
    );
  }

  TextStyle get displayLGBold {
    return TextStyle(
      fontSize: 48.sp,
      fontWeight: FontWeight.w900,
    );
  }

  TextStyle get displayMDRegular {
    return TextStyle(
      fontSize: 36.sp,
      fontWeight: FontWeight.w300,
    );
  }

  TextStyle get displayMDMedium {
    return TextStyle(
      fontSize: 36.sp,
      fontWeight: FontWeight.w500,
    );
  }

  TextStyle get displayMDSemibold {
    return TextStyle(
      fontSize: 36.sp,
      fontWeight: FontWeight.w700,
    );
  }

  TextStyle get displayMDBold {
    return TextStyle(
      fontSize: 36.sp,
      fontWeight: FontWeight.w900,
    );
  }

  TextStyle get displaySMRegular {
    return TextStyle(
      fontSize: 36.sp,
      fontWeight: FontWeight.w300,
    );
  }

  TextStyle get displaySMMedium {
    return TextStyle(
      fontSize: 36.sp,
      fontWeight: FontWeight.w500,
    );
  }

  TextStyle get displaySMSemibold {
    return TextStyle(
      fontSize: 36.sp,
      fontWeight: FontWeight.w700,
    );
  }

  TextStyle get displaySMBold {
    return TextStyle(
      fontSize: 36.sp,
      fontWeight: FontWeight.w900,
    );
  }

  TextStyle get displayXSRegular {
    return TextStyle(
      fontSize: 24.sp,
      fontWeight: FontWeight.w300,
    );
  }

  TextStyle get displayXSMedium {
    return TextStyle(
      fontSize: 24.sp,
      fontWeight: FontWeight.w500,
    );
  }

  TextStyle get displayXSSemibold {
    return TextStyle(
      fontSize: 24.sp,
      fontWeight: FontWeight.w700,
    );
  }

  TextStyle get displayXSBold {
    return TextStyle(
      fontSize: 24.sp,
      fontWeight: FontWeight.w900,
    );
  }

  TextStyle get text2XLRegular {
    return TextStyle(
      fontSize: 68.sp,
      fontWeight: FontWeight.w300,
    );
  }

  TextStyle get text2XLMedium {
    return TextStyle(
      fontSize: 68.sp,
      fontWeight: FontWeight.w500,
    );
  }

  TextStyle get text2XLSemibold {
    return TextStyle(
      fontSize: 68.sp,
      fontWeight: FontWeight.w700,
    );
  }

  TextStyle get text2XLBold {
    return TextStyle(
      fontSize: 68.sp,
      fontWeight: FontWeight.w900,
    );
  }

  TextStyle get textXLRegular {
    return TextStyle(
      fontSize: 20.sp,
      fontWeight: FontWeight.w300,
    );
  }

  TextStyle get textXLMedium {
    return TextStyle(
      fontSize: 20.sp,
      fontWeight: FontWeight.w500,
    );
  }

  TextStyle get textXLSemibold {
    return TextStyle(
      fontSize: 20.sp,
      fontWeight: FontWeight.w700,
    );
  }

  TextStyle get textXLBold {
    return TextStyle(
      fontSize: 20.sp,
      fontWeight: FontWeight.w900,
    );
  }

  TextStyle get textLGRegular {
    return TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.w300,
    );
  }

  TextStyle get textLGMedium {
    return TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.w500,
    );
  }

  TextStyle get textLGSemibold {
    return TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.w700,
    );
  }

  TextStyle get textLGBold {
    return TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.w900,
    );
  }

  TextStyle get textMDRegular {
    return TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.w300,
    );
  }

  TextStyle get textMDMedium {
    return TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.w500,
    );
  }

  TextStyle get textMDSemibold {
    return TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.w700,
    );
  }

  TextStyle get textMDBold {
    return TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.w900,
    );
  }

  TextStyle get textSMRegular {
    return TextStyle(
      fontSize: 12.sp,
      fontWeight: FontWeight.w300,
    );
  }

  TextStyle get textSMMedium {
    return TextStyle(
      fontSize: 12.sp,
      fontWeight: FontWeight.w500,
    );
  }

  TextStyle get textSMSemibold {
    return TextStyle(
      fontSize: 12.sp,
      fontWeight: FontWeight.w700,
    );
  }

  TextStyle get textSMBold {
    return TextStyle(
      fontSize: 12.sp,
      fontWeight: FontWeight.w900,
    );
  }

  TextStyle get textXSRegular {
    return TextStyle(
      fontSize: 10.sp,
      fontWeight: FontWeight.w300,
    );
  }

  TextStyle get textXSMedium {
    return TextStyle(
      fontSize: 10.sp,
      fontWeight: FontWeight.w500,
    );
  }

  TextStyle get textXSSemibold {
    return TextStyle(
      fontSize: 10.sp,
      fontWeight: FontWeight.w700,
    );
  }

  TextStyle get textXSBold {
    return TextStyle(
      fontSize: 10.sp,
      fontWeight: FontWeight.w900,
    );
  }
}

mixin AppPinTheme on PinTheme {
  static PinTheme get defaultPinTheme {
    return PinTheme(
      width: 48.sp,
      height: 48.sp,
      textStyle: const TextTheme().displayXSMedium.copyWith(
            color: AppColors.textDarkColor,
          ),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: AppColors.borderColor, width: 4.sp),
          bottom: BorderSide(color: AppColors.borderColor, width: 1.sp),
          left: BorderSide(color: AppColors.borderColor, width: 2.sp),
          right: BorderSide(color: AppColors.borderColor, width: 2.sp),
        ),
        borderRadius: BorderRadius.circular(
          10.r,
        ),
      ),
    );
  }
}
