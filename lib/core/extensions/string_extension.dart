import 'package:intl/intl.dart';

extension StringExtension on String {
  String append(Object v) => '$this $v';

  bool equals(String s) => toLowerCase() == s.toLowerCase();

  String toCapitalize() =>
      toBeginningOfSentenceCase(this) ?? '${this[0].toUpperCase()}${substring(1)}';
}

extension DateFormatExtension on DateTime {
  String format() => DateFormat('MMMM d, y hh:mm a').format(this);
}
