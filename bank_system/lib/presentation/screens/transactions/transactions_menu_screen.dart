import 'dart:io';
import 'dart:math';

import 'package:bank_system/core/enums/mode.dart';
import 'package:bank_system/core/utils/input_scanner.dart';
import 'package:bank_system/presentation/screens/main_screen.dart';
import 'package:bank_system/presentation/screens/transactions/deposit_screen.dart';
import 'package:bank_system/presentation/screens/transactions/total_balances_screen.dart';
import 'package:bank_system/presentation/screens/transactions/transfer_log_screen.dart';
import 'package:bank_system/presentation/screens/transactions/transfer_screen.dart';
import 'package:bank_system/presentation/screens/transactions/withdraw_screen.dart';

enum EnTransactionsMenuOptions {
  deposit(1),
  withdraw(2),
  showTotalBalances(3),
  transfer(4),
  transferLog(5),
  showMainMenu(6);

  final int value;

  const EnTransactionsMenuOptions(this.value);

  static EnTransactionsMenuOptions fromInt(int value) {
    return EnTransactionsMenuOptions.values.firstWhere(
      (option) => option.value == value,
      orElse: () => EnTransactionsMenuOptions.showMainMenu,
    );
  }
}

class TransactionsMenuScreen extends MainScreen {
  TransactionsMenuScreen._();

  static int _readTransactionsMenuOption() {
    stdout.write("${"".padLeft(37)}Choose a transaction type? [1 to 6]? ");
    int choice = InputScanner.readNumberBetween(
      1,
      6,
      errorMessage: "Enter Number between 1 to 6? ",
    );
    return choice;
  }

  static void _performTransactionMenuOption(EnTransactionsMenuOptions option) {
    switch (option) {
      case EnTransactionsMenuOptions.deposit:
        DepositScreen.showDepositScreen();
        break;
      case EnTransactionsMenuOptions.withdraw:
        WithdrawScreen.showWithdrawScreen();
        break;
      case EnTransactionsMenuOptions.showTotalBalances:
        TotalBalancesScreen.showTotalBalancesScreen();
        break;
      case EnTransactionsMenuOptions.transfer:
        TransferScreen.showTransferScreen();
        break;
        case EnTransactionsMenuOptions.transferLog:
        TransferLogScreen.showTransferLogScreen();
        break;
      case EnTransactionsMenuOptions.showMainMenu:
      //do nothing here the main screen will handle it :-) ;
      //  MainScreen.showMainMenu                     ();
      // break;
    }
  }

  static void showTransactionsMenu() {
    if (!MainScreen.checkAccessAndShowMessage(EnPermissions.pTransactions)) {
      return;
    }
    MainScreen.drawScreenHeader("\t  Transactions Screen");
    bool backToMainMenu = false;
    while (!backToMainMenu) {
      _drawMenuBody();
      int choice = _readTransactionsMenuOption();
      EnTransactionsMenuOptions option = EnTransactionsMenuOptions.fromInt(
        choice,
      );

      if (option == EnTransactionsMenuOptions.showMainMenu) {
        backToMainMenu =
            true; // سيخرج من الـ loop ويعود للمنيو الرئيسي تلقائياً
      } else {
        _performTransactionMenuOption(option);
        _waitForEnter();
      }
    }
  }

  static void _waitForEnter() {
    print("\n${"".padLeft(37)}Press Enter to continue...");
    stdin.readLineSync();
  }

  static void _drawMenuBody() {
    String indent = "".padLeft(37);
    print("$indent===========================================");
    print("$indent\t\t  Transactions Menu");
    print("$indent===========================================");
    print("$indent\t[1] Deposit.");
    print("$indent\t[2] Withdraw.");
    print("$indent\t[3] Total Balances.");
    print("$indent\t[4] Transfer.");
    print("$indent\t[5] Transfer Log.");
    print("$indent\t[6] Main Menu.");
    print("$indent===========================================");
  }
}
