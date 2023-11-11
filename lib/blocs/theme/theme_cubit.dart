import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum ThemeEvent { light, dark }

class ThemeCubit extends Cubit<ThemeData> {
  ThemeCubit() : super(darkTheme);

  void changeTheme(ThemeEvent event) {
    switch (event) {
      case ThemeEvent.light:
        emit(lightTheme);
        break;
      case ThemeEvent.dark:
        emit(darkTheme);
        break;
    }
  }
}

final lightTheme = ThemeData(
  primarySwatch: Colors.indigo,
  colorScheme: const ColorScheme.light(primary: Colors.black),
  fontFamily: 'Roboto',
  textTheme: TextTheme(
    displayLarge: TextStyle(fontSize: 72.sp),
    headlineLarge: TextStyle(fontSize: 36.sp, fontStyle: FontStyle.italic),
    titleLarge: TextStyle(fontSize: 16.sp, fontFamily: 'Hind'),
    bodyLarge: TextStyle(fontSize: 14.sp, fontFamily: 'Hind'),
  ),
  buttonTheme: const ButtonThemeData(
    buttonColor: Colors.white,
    textTheme: ButtonTextTheme.primary,
  ),
);

final darkTheme = ThemeData(
  primarySwatch: Colors.cyan,
  colorScheme: const ColorScheme.dark(
    primary: Colors.amber,
    secondary: Colors.white,
    background: Colors.white,
  ),
  fontFamily: 'Roboto',
  textTheme: TextTheme(
    displayLarge: TextStyle(
      fontSize: 72.sp,
    ),
    // Text color
    headlineLarge: TextStyle(
      fontSize: 36.sp,
      fontStyle: FontStyle.italic,
    ),
    // Text color
    titleLarge: TextStyle(
      fontSize: 16.sp,
      fontFamily: 'Hind',
    ),
    // Text color
    bodyLarge: TextStyle(
      fontSize: 14.sp,
      fontFamily: 'Hind',
      color: Colors.amber,
    ),
    // Te
    bodySmall: TextStyle(
      fontSize: 10.sp,
      fontFamily: 'Hind',
      color: Colors.white,
      fontWeight: FontWeight.w700,
    ),
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: Colors.amber, // Button background color
    textTheme: ButtonTextTheme.primary, // Button text color
    shape: RoundedRectangleBorder(
      side: const BorderSide(color: Colors.amber), // Button border color
      borderRadius: BorderRadius.circular(
        16.sp,
      ),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.amber),
      // TextFormField border color
      borderRadius: BorderRadius.circular(
        12,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.amber),
      borderRadius: BorderRadius.circular(
        12,
      ),
    ),
  ),
  scaffoldBackgroundColor: Colors.black,
  // Scaffold background colo
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: Colors.black, // Text cursor color
    selectionColor: Colors.white, // Text selection color
    selectionHandleColor: Colors.white,
  ),
);
