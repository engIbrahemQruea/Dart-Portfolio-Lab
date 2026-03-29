import 'dart:io';

import 'package:bank_system/core/enums/en_currency_mode.dart';
import 'package:bank_system/core/enums/mode.dart';
import 'package:bank_system/core/extensions/client_display_extension.dart';
import 'package:bank_system/core/utils/input_scanner.dart';
import 'package:bank_system/presentation/screens/currency/calculator_currency_screen.dart';
import 'package:bank_system/presentation/screens/currency/find_currency_screen.dart';
import 'package:bank_system/presentation/screens/currency/list_currency_screen.dart';
import 'package:bank_system/presentation/screens/currency/update_rate_currency_screen.dart';
import 'package:bank_system/presentation/screens/main_screen.dart';

class CurrencyExchangeMainMenuScreen extends MainScreen {
  static int _readCurrencyExchangeMenuOption() {
    stdout.write("${"".padLeft(37)}Choose an option? [1 to 5]? ");
    int choice = InputScanner.readNumberBetween(
      1,
      5,
      errorMessage: "Enter Number between 1 to 5? ",
    );
    return choice;
  }

  static void _performCurrencyExchangeMenuOption(
    EnCurrenciesMainMenuOptions option,
  ) {
    return switch (option) {
      EnCurrenciesMainMenuOptions.eListCurrencies =>
        ListCurrencyScreen.showListCurrencyScreen(),
      EnCurrenciesMainMenuOptions.eFindCurrency =>
        FindCurrencyScreen.showFindCurrencyScreen(),
      EnCurrenciesMainMenuOptions.eUpdateRateCurrency =>
        UpdateRateCurrencyScreen.showUpdateRateCurrencyScreen(),
      EnCurrenciesMainMenuOptions.eCalculatorCurrency =>
        CalculatorCurrencyScreen.showCalculatorCurrencyScreen(),
      EnCurrenciesMainMenuOptions.eMainMenu => null,
    };
  }

  static void _drawMenuBody() {
    String indent = "".padLeft(37);
    "===========================================".printIndented();
    print("$indent\t\t  Currency Exchange Menu");
    "===========================================".printIndented();
    print("$indent\t[1] List Currencies.");
    print("$indent\t[2] Find Currency.");
    print("$indent\t[3] Update Rate Currency.");
    print("$indent\t[4] Calculator Currency.");
    print("$indent\t[5] Main Menu.");
    "===========================================".printIndented();
  }

  static void _waitForEnterKey() {
    stdout.write("\n${"".padLeft(37)}Press Enter to continue...");
    stdin.readLineSync();
  }

  static void showCurrencyExchangeMenu() {
    if (!MainScreen.checkAccessAndShowMessage(
      EnPermissions.pCurrencyExchange,
    )) {
      return;
    }
    MainScreen.drawScreenHeader("\t  Currency Exchange Main Menu");
    bool backToMainMenu = false;
    while (!backToMainMenu) {
      _drawMenuBody();
      int choice = _readCurrencyExchangeMenuOption();
      EnCurrenciesMainMenuOptions option = EnCurrenciesMainMenuOptions.fromInt(
        choice,
      );

      if (option == EnCurrenciesMainMenuOptions.eMainMenu) {
        backToMainMenu = true;
      } else {
        _performCurrencyExchangeMenuOption(option);
        _waitForEnterKey();
      }
    }
  }
}
