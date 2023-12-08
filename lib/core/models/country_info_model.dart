import '../utils/app_assets.dart';

class CountryInfoModel {
  final String code;
  final String flag;

  CountryInfoModel({required this.code, required this.flag});
}

final countryList = [
  CountryInfoModel(code: '+91', flag: AppFlags.flagIN),
  CountryInfoModel(code: '+974', flag: AppFlags.flagQA),
];
