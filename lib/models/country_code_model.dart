import 'package:equatable/equatable.dart';

class CountryCodeModel extends Equatable {
  final String code;
  final String country;

  const CountryCodeModel({required this.code, required this.country});

  @override
  List<Object?> get props => [
        code,
        country,
      ];

  @override
  String toString() => code;
}

final List<CountryCodeModel> countryCodes = [
  const CountryCodeModel(code: '+91', country: 'India'),
  const CountryCodeModel(code: '+44', country: 'UK'),
];
