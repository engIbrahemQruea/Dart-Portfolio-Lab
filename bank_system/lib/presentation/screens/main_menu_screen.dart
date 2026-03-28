import 'dart:io';

import 'package:bank_system/business_logic/auth_controller.dart';
import 'package:bank_system/core/utils/input_scanner.dart';
import 'package:bank_system/presentation/screens/add_client_screen.dart';
import 'package:bank_system/presentation/screens/currency/currency_exchange_main_menu_screen.dart';
import 'package:bank_system/presentation/screens/delete_client_screen.dart';
import 'package:bank_system/presentation/screens/find_client_screen.dart';
import 'package:bank_system/presentation/screens/list_clients_screen.dart';
import 'package:bank_system/presentation/screens/login/list_logs_screen.dart';
import 'package:bank_system/presentation/screens/main_screen.dart';
import 'package:bank_system/presentation/screens/manage_users/manage_users_menu_screen.dart';
import 'package:bank_system/presentation/screens/transactions/transactions_menu_screen.dart';
import 'package:bank_system/presentation/screens/update_client_screen.dart';

enum EnMainMenuOptions {
  listClients(1),
  addNewClient(2),
  deleteClient(3),
  updateClient(4),
  findClient(5),
  showTransactionsMenu(6),
  manageUsers(7),
  logRegisters(8),
  currencyExchange(9),  
  logout(10);

  final int value;
  const EnMainMenuOptions(this.value);

  static EnMainMenuOptions fromInt(int value) {
    return EnMainMenuOptions.values.firstWhere(
      (option) => option.value == value,
      orElse: () => EnMainMenuOptions.logout,
    );
  }
}

class MainMenuScreen extends MainScreen {
  MainMenuScreen._();

  static int _readMainMenuOption() {
    stdout.write("${"".padLeft(37)}Choose what do you want to do? [1 to 10]? ");
    int choice = InputScanner.readNumberBetween(
      1,
      10,
      errorMessage: "Enter Number between 1 to 10? ",
    );
    return choice;
  }

  static void _clearScreen() {
    if (Platform.isWindows) {
      Process.runSync('cls', [], runInShell: true);
    } else {
      Process.runSync('clear', [], runInShell: true);
    }
  }

  static void _performMainMenuOption(EnMainMenuOptions option) {
    //_clearScreen();
    switch (option) {
      case EnMainMenuOptions.listClients:
        ListClientsScreen.showAllClientsScreen();
        break;
      case EnMainMenuOptions.addNewClient:
        AddClientScreen.showAddNewClientsScreen();
        break;
      case EnMainMenuOptions.deleteClient:
        DeleteClientScreen.showDeleteClientScreen();
        break;
      case EnMainMenuOptions.updateClient:
        UpdateClientScreen.showUpdateClientScreen();
        break;
      case EnMainMenuOptions.findClient:
        FindClientScreen.showFindClientScreen();
        break;
      case EnMainMenuOptions.showTransactionsMenu:
        TransactionsMenuScreen.showTransactionsMenu();
        break;
      case EnMainMenuOptions.manageUsers:
        ManageUsersMenuScreen.showManageUsersMenu();
        break;
      case EnMainMenuOptions.logRegisters:
        ListLogsScreen.showLoginRegisterScreen();
        break;
        case EnMainMenuOptions.currencyExchange:
        CurrencyExchangeMainMenuScreen.showCurrencyExchangeMenu();
        break;
      case EnMainMenuOptions.logout:
        // AuthController.registerLogIn(EnLogStatus.logout);
        AuthController.logout();
        return;
    }
  }

  static void showMainMenu() {
    MainScreen.drawScreenHeader("\t\tMain Screen");
    bool backToMainMenu = false;
    while (!backToMainMenu) {
      _drawMainMenuBody();
      int choice = _readMainMenuOption();
      EnMainMenuOptions option = EnMainMenuOptions.fromInt(choice);
      if (option == EnMainMenuOptions.logout) {
        backToMainMenu = true;
      } else {
        _performMainMenuOption(option);
        _waitForEnter();
      }
    }
  }

  static void _drawMainMenuBody() {
    String space = "".padLeft(37);
    print("$space===========================================");
    print("$space\t\t\tMain Menu");
    print("$space===========================================");
    print("$space\t[1] Show Client List.");
    print("$space\t[2] Add New Client.");
    print("$space\t[3] Delete Client.");
    print("$space\t[4] Update Client Info.");
    print("$space\t[5] Find Client.");
    print("$space\t[6] Transactions.");
    print("$space\t[7] Manage Users.");
    print("$space\t[8] Login Registers.");
    print("$space\t[9] Currency Exchange.");
    print("$space\t[10] Logout.");
    print("$space===========================================");
  }

  static void _waitForEnter() {
    print("\n${"".padLeft(37)}Press Enter to continue...");
    stdin.readLineSync();
  }
}
