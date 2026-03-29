import 'dart:io';

import 'package:bank_system/business_logic/currency_controller.dart';
import 'package:bank_system/models/currency_model.dart';
import 'package:bank_system/presentation/screens/main_screen.dart';

class ListCurrencyScreen extends MainScreen {
  static void _printCurrencyRecordLine(CurrencyModel currency) {
    String indent = "".padLeft(10);

    stdout.write(indent);
    stdout.write("| ${currency.country.padRight(25)}");
    stdout.write("| ${currency.currencyCode.padRight(15)}");
    stdout.write("| ${currency.currencyName.padRight(30)}");
    stdout.write("| ${currency.rate.toString().padRight(12)}");
    print("");
  }

  static void showListCurrency() {
    List<CurrencyModel> lsCurrency = CurrencyController.getCurrenciesList();
    String title = "\t  Currencies List Screen";
    String subTitle = "\t    (${lsCurrency.length}) Currency(s).";

    MainScreen.drawScreenHeader(title, subTitle);
    String indent8 = "".padLeft(10);
    String lineSeparator =
        "___________________________________________________________________________________";
    print("$indent8$lineSeparator");
    print("");

    stdout.write(indent8);
    stdout.write("| ${"Country".padRight(25)}");
    stdout.write("| ${"Currency Code".padRight(15)}");
    stdout.write("| ${"Currency Name".padRight(30)}");
    stdout.write("| ${"Rate".padRight(12)}");
    print("\n$indent8$lineSeparator\n");

    if (lsCurrency.isEmpty) {
      print("\t\t\t\tNo Currencies Available In the System!");
    } else {
      for (var currency in lsCurrency) {
        _printCurrencyRecordLine(currency);
      }
    }

    print("\n$indent8$lineSeparator");
  }

  static void showListCurrencyScreen() {
    showListCurrency();
  }
}
