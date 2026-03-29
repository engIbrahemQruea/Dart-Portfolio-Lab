import 'dart:io';

import 'package:bank_system/business_logic/currency_controller.dart';
import 'package:bank_system/core/utils/input_scanner.dart';
import 'package:bank_system/models/currency_model.dart';
import 'package:bank_system/presentation/screens/main_screen.dart';

class CalculatorCurrencyScreen extends MainScreen {
  static void _printCurrencyCard(CurrencyModel currency, String title) {
    print("\n\tConvert $title:");
    print("\t______________________________________");
    print("\tCountry       : ${currency.country.replaceAll('"', '')}");
    print("\tCode          : ${currency.currencyCode}");
    print("\tName          : ${currency.currencyName}");
    print("\tRate (1\$)    : ${currency.rate}");
    print("\t______________________________________\n");
  }

  static CurrencyModel _getCurrency(String message) {
    print(message);
    String code = InputScanner.readString(
      errorMessage: 'Invalid currency code',
    );

    while (!CurrencyController.isCurrencyExist(code)) {
      print(
        'Currency with code $code does not exist. Please enter a valid currency code:',
      );
      code = InputScanner.readString(errorMessage: 'Invalid currency code');
    }
    CurrencyModel currency = CurrencyController.findCurrencyByCodeORCountry(
      currencyCode: code,
      withCountryCheck: false,
    );
    return currency;
  }

  static void showCalculatorCurrency() {
    String tryAgain = 'y';
    while (tryAgain.toLowerCase() == 'y') {
      MainScreen.drawScreenHeader("\t  Calculator Currency Screen", "");

      CurrencyModel currencyFrom = _getCurrency('Please Enter Currency1 Code:');
      CurrencyModel currencyTo = _getCurrency('Please Enter Currency2 Code:');

      print('Please Enter Amount:');
      num amount = InputScanner.readNumberBetween(
        0,
        1000000,
        errorMessage: 'Invalid Amount',
      );
      double result = CurrencyController.calculateExchange(
        currencyFrom,
        currencyTo,
        amount,
      );
      _printCurrencyCard(currencyFrom, 'From');
      _printCurrencyCard(currencyTo, 'To');
      print(
        '\t$amount ${currencyFrom.currencyCode} = ${result.toStringAsFixed(2)} ${currencyTo.currencyCode}',
      );
      print('\nDo you want to perform another calculation? y/n ? ');
      tryAgain = InputScanner.readString(
        errorMessage: 'Invalid input Enter y or n',
      );
    }
  }

  static void showCalculatorCurrencyScreen() {
    showCalculatorCurrency();
  }
}
