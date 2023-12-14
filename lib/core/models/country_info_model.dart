import '../utils/app_assets.dart';

class CountryInfoModel {
  final String code;
  final String flag;
  final int length;

  CountryInfoModel(
      {required this.code, required this.flag, required this.length});
}

final countryList = [
  CountryInfoModel(code: '+91', flag: AppFlags.flagIN, length: 10),
  CountryInfoModel(code: '+974', flag: AppFlags.flagQA, length: 9),
];
