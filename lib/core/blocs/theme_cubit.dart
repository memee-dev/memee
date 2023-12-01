import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_colors.dart';

enum ThemeEvent { light, dark }

class ThemeCubit extends Cubit<ThemeData> {
  ThemeCubit() : super(lightTheme);

  void changeTheme(ThemeEvent event) {
    switch (event) {
      case ThemeEvent.light:
        emit(lightTheme);
        break;
      case ThemeEvent.dark:
        emit(lightTheme);
        break;
    }
  }
}

final lightTheme = ThemeData(
  primarySwatch: Colors.amber,
  colorScheme: const ColorScheme.light(primary: Colors.pink),
  drawerTheme: const DrawerThemeData(backgroundColor: Colors.white24),
  fontFamily: 'Roboto',
  textTheme: TextTheme(
    headlineSmall: TextStyle(
      fontSize: 36.sp,
      fontStyle: FontStyle.italic,
    ),
    titleSmall: TextStyle(
      fontSize: 18.sp,
      color: const Color(0xff2A2A2A),
    ),
    displaySmall: TextStyle(
      fontSize: 16.sp,
      color: AppColors.displayColor,
      fontWeight: FontWeight.w700,
    ),
    bodySmall: TextStyle(
      fontSize: 14.sp,
      color: AppColors.displayColor,
      fontFamily: 'Hind',
    ),
    labelSmall: TextStyle(
      fontSize: 12.sp,
      color: AppColors.labelColor,
      fontFamily: 'Hind',
    ),
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: const Color(0xffffc000),
    textTheme: ButtonTextTheme.primary,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.r),
    ),
  ),
  appBarTheme: const AppBarTheme(backgroundColor: Colors.black),
);
