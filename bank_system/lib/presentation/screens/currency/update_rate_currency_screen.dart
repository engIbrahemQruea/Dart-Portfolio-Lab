import 'dart:io';

import 'package:bank_system/business_logic/currency_controller.dart';
import 'package:bank_system/core/utils/input_scanner.dart';
import 'package:bank_system/models/currency_model.dart';
import 'package:bank_system/presentation/screens/main_screen.dart';

class UpdateRateCurrencyScreen extends MainScreen {
  static void _printCurrencyCard(CurrencyModel currency) {
    print("\n\tCurrency Card:");
    print("\t______________________________________");
    print("\tCountry       : ${currency.country.replaceAll('"', '')}");
    print("\tCode          : ${currency.currencyCode}");
    print("\tName          : ${currency.currencyName}");
    print("\tRate (1\$)    : ${currency.rate}");
    print("\t______________________________________\n");
  }

  static num _readCurrency(CurrencyModel currency) {
    String updateField(String label, String oldValue) {
      stdout.write('Enter $label [$oldValue]: ');
      String input = stdin.readLineSync()?.trim() ?? '';
      if (input.isEmpty) return currency.rate.toString();
      return input.trim().isEmpty ? oldValue : input;
    }

    num rate = num.parse(updateField('New Rate', currency.rate.toString()));
    return rate;
  }

  static void showUpdateRateCurrency() {
    MainScreen.drawScreenHeader("\t  Update Rate Currency Screen", "");
    print('Please enter the currency code of the currency you want to update:');
    String code = stdin.readLineSync()?.trim().toUpperCase() ?? "";

    while (!CurrencyController.isCurrencyExist(code)) {
      print(
        'Currency with code $code does not exist. Please enter a valid currency code:',
      );
      code = stdin.readLineSync()?.trim().toUpperCase() ?? "";
    }

    CurrencyModel currency = CurrencyController.findCurrencyByCodeORCountry(
      currencyCode: code,
      withCountryCheck: false,
    );

    _printCurrencyCard(currency);
    print("Are you sure you want to update this currency? y/n");
    String confirmation = InputScanner.readString(
      errorMessage: 'invalid input',
    );
    if (confirmation.toLowerCase() == 'y') {
      CurrencyController.updateRate(code, _readCurrency(currency));
      print('Currency updated successfully.');
      _printCurrencyCard(currency);
    } else {
      print('Update canceled.');
    }
  }

  static void showUpdateRateCurrencyScreen() {
    showUpdateRateCurrency();
  }
}
