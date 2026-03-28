import 'package:bank_system/core/utils/constance.dart';
import 'package:bank_system/data_access/services.dart';
import 'package:bank_system/models/currency_model.dart';

class CurrencyRepos {
  static const String _fileCurrencyPath = currencyFileName;

  static List<CurrencyModel> loadCurrencies() {
    final lines = Services.loadLinesFromFile(_fileCurrencyPath);
    return lines.map((line) => CurrencyModel.fromLine(line)).toList();
  }

  static void saveCurrencies(List<CurrencyModel> currencies) {
    final lines = currencies.map((currency) => currency.toLine()).toList();
    Services.saveAllLinesToFile(_fileCurrencyPath, lines);
  }

  static void addCurrency(CurrencyModel currency) {
    Services.addLineToFile(currency.toLine(), _fileCurrencyPath);
  }

  static void updateCurrency(CurrencyModel currency) {
    final lines = Services.loadLinesFromFile(_fileCurrencyPath);
    final index = lines.indexWhere((line) {
      final parts = line.split("#//#");
      return parts.length > 1 &&
          parts[1].toLowerCase() == currency.currencyCode.toLowerCase();
    });
    if (index != -1) {
      lines[index] = currency.toLine();
      Services.saveAllLinesToFile(_fileCurrencyPath, lines);
    }
  }
}
