import 'package:flutter/material.dart';

dynamic snackBar(
  context,
  String label, {
  SnackBarAction? action,
  Duration? duration,
}) =>
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(label),
        duration: duration ?? const Duration(seconds: 1),
        action: action,
      ),
    );

Icon parseIcon(String iconName) {
  switch (iconName.toLowerCase()) {
    case 'home':
      return const Icon(Icons.home_outlined);
    case 'work':
      return const Icon(Icons.work_outline_outlined);
    case 'other':
      return const Icon(Icons.location_city_outlined);
    default:
      return const Icon(Icons.error_outline);
  }
}
