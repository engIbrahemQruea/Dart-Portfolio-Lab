import 'dart:io';

import 'package:bank_system/core/enums/mode.dart';
import 'package:bank_system/core/enums/users_menu_options.dart';
import 'package:bank_system/core/extensions/client_display_extension.dart';
import 'package:bank_system/core/utils/input_scanner.dart';
import 'package:bank_system/presentation/screens/main_screen.dart';
import 'package:bank_system/presentation/screens/manage_users/add_user_screen.dart';
import 'package:bank_system/presentation/screens/manage_users/delete_user_screen.dart';
import 'package:bank_system/presentation/screens/manage_users/find_user_screen.dart';
import 'package:bank_system/presentation/screens/manage_users/list_users_screen.dart';
import 'package:bank_system/presentation/screens/manage_users/update_user_screen.dart';

class ManageUsersMenuScreen extends MainScreen {
  ManageUsersMenuScreen._();

  static int _readManageUsersMenuOption() {
    stdout.write("${"".padLeft(37)}Choose an option? [1 to 6]? ");
    int choice = InputScanner.readNumberBetween(
      1,
      6,
      errorMessage: "Enter Number between 1 to 6? ",
    );
    return choice;
  }

  static void _performManageUsersMenuOption(ManageUsersMenuOptions option) {
    return switch (option) {
      ManageUsersMenuOptions.listUsers => ListUsersScreen.showListUsersScreen(),
      ManageUsersMenuOptions.addUser => AddUserScreen.showAddUserScreen(),
      ManageUsersMenuOptions.deleteUser =>
        DeleteUserScreen.showDeleteUserScreen(),
      ManageUsersMenuOptions.updateUser =>
        UpdateUserScreen.showUpdateUserScreen(),
      ManageUsersMenuOptions.findUser => FindUserScreen.showFindUserScreen(),
      ManageUsersMenuOptions.showMainMenu => null,
    };
  }

  static void _drawMenuBody() {
    String indent = "".padLeft(37);
    "===========================================".printIndented();
    print("$indent\t\t  Manage Users Menu");
    "===========================================".printIndented();
    print("$indent\t[1] List Users.");
    print("$indent\t[2] Add User.");
    print("$indent\t[3] Delete User.");
    print("$indent\t[4] Update User.");
    print("$indent\t[5] Find User.");
    print("$indent\t[6] Main Menu.");
    "===========================================".printIndented();
  }

  static void _waitForEnterKey() {
    stdout.write("\n${"".padLeft(37)}Press Enter to continue...");
    stdin.readLineSync();
  }

  static void showManageUsersMenu() {
    if (!MainScreen.checkAccessAndShowMessage(EnPermissions.pManageUsers)) {
      return;
    }
    MainScreen.drawScreenHeader("\t  Manage Users Screen");
    bool backToMainMenu = false;
    while (!backToMainMenu) {
      _drawMenuBody();
      int choice = _readManageUsersMenuOption();
      ManageUsersMenuOptions option = ManageUsersMenuOptions.fromInt(choice);

      if (option == ManageUsersMenuOptions.showMainMenu) {
        backToMainMenu = true;
      } else {
        _performManageUsersMenuOption(option);
        _waitForEnterKey();
      }
    }
  }
}
