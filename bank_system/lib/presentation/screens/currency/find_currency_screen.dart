import 'dart:io';

import 'package:bank_system/business_logic/currency_controller.dart';
import 'package:bank_system/models/currency_model.dart';
import 'package:bank_system/presentation/screens/main_screen.dart';

class FindCurrencyScreen extends MainScreen {
  static void _printCurrencyCard(CurrencyModel currency) {
    print("\n\tCurrency Card:");
    print("\t______________________________________");
    print("\tCountry       : ${currency.country.replaceAll('"', '')}");
    print("\tCode          : ${currency.currencyCode}");
    print("\tName          : ${currency.currencyName}");
    print("\tRate (1\$)    : ${currency.rate}");
    print("\t______________________________________\n");
  }

  static void showFindCurrency() {
    MainScreen.drawScreenHeader("\t  Find Currency Screen", "");

    print("\nFind By: [1] Code or [2] Country ? ");
    String choice = stdin.readLineSync() ?? "1";

    CurrencyModel currency = CurrencyModel.empty();

    if (choice == "1") {
      stdout.write("\nPlease Enter Currency Code: ");
      String code = stdin.readLineSync()?.trim().toUpperCase() ?? "";

      currency = CurrencyController.findCurrencyByCodeORCountry(
        currencyCode: code,
        withCountryCheck: false,
      );
    } else {
      stdout.write("\nPlease Enter Country Name: ");
      String country = stdin.readLineSync()?.trim() ?? "";

      currency = CurrencyController.findCurrencyByCodeORCountry(
        currencyCode: "",
        countryName: country,
        withCountryCheck: true,
      );
    }

    _showResults(currency);
  }

  static void _showResults(CurrencyModel currency) {
    if (currency.isEmpty) {
      print("\nCurrency was not found! ❌");
    } else {
      _printCurrencyCard(currency);
    }
  }

  static void showFindCurrencyScreen() {
    showFindCurrency();
  }
}
