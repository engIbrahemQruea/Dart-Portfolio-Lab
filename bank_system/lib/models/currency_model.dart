import 'package:bank_system/core/enums/en_currency_mode.dart';

class CurrencyModel {
  final EnCurrencyMode mode;
  final String country;
  final String currencyCode;
  final String currencyName;
  final num rate;

  bool get isEmpty => mode == EnCurrencyMode.emptyMode;

  CurrencyModel({
    required this.mode,
    required this.country,
    required this.currencyCode,
    required this.currencyName,
    required this.rate,
  });

  CurrencyModel copyWith({
    String? country,
    String? currencyCode,
    String? currencyName,
    num? rate,
    EnCurrencyMode? mode,
  }) {
    return CurrencyModel(
      mode: mode ?? this.mode,
      country: country ?? this.country,
      currencyCode: currencyCode ?? this.currencyCode,
      currencyName: currencyName ?? this.currencyName,
      rate: rate ?? this.rate,
    );
  }

  factory CurrencyModel.empty() {
    return CurrencyModel(
      mode: EnCurrencyMode.emptyMode,
      country: '',
      currencyCode: '',
      currencyName: '',
      rate: 0.0,
    );
  }

  factory CurrencyModel.fromLine(String line, {String sep = "#//#"}) {
    List<String> p = line.split(sep);
    return CurrencyModel(
      mode: EnCurrencyMode.updateMode,
      country: p[0].trim(),
      currencyCode: p[1].trim(),
      currencyName: p[2].trim(),
      rate: num.parse(p[3].trim()),
    );
  }
  String toLine({String sep = "#//#"}) {
    return [
      country.trim(),
      currencyCode.trim(),
      currencyName.trim(),
      rate,
    ].map((e) => e.toString()).join(sep);
  }
}
