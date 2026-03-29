import 'dart:io';

import 'package:bank_system/business_logic/bank_user_controller.dart';
import 'package:bank_system/models/bank_user_model.dart';
import 'package:bank_system/presentation/screens/main_screen.dart';

class ListUsersScreen extends MainScreen {
  static void _printUserRecordLine(BankUserModel user) {
    String indent = "".padLeft(10);

    stdout.write(indent);
    stdout.write("| ${user.fullName.padRight(25)}");
    stdout.write("| ${user.phone.padRight(12)}");
    stdout.write("| ${user.email.padRight(25)}");
    stdout.write("| ${user.password.padRight(10)}");
    stdout.write("| ${user.permission.toString().padRight(10)}");
    print("");
  }

  static void showUsersList() {
    List<BankUserModel> vUsers = BankUserController.getUsersList();

    String title = "\t  User List Screen";
    String subTitle = "\t    (${vUsers.length}) User(s).";

    MainScreen.drawScreenHeader(title, subTitle);

    String indent8 = "".padLeft(10);
    String lineSeparator =
        "________________________________________________________________________________________________";
    print("$indent8$lineSeparator");
    print("");

    stdout.write(indent8);
    stdout.write("| ${"Full Name".padRight(25)}");
    stdout.write("| ${"Phone".padRight(12)}");
    stdout.write("| ${"Email".padRight(25)}");
    stdout.write("| ${"Password".padRight(10)}");
    stdout.write("| ${"Permissions".padRight(10)}");
    print("\n$indent8$lineSeparator\n");

    if (vUsers.isEmpty) {
      print("\t\t\t\tNo Users Available In the System!");
    } else {
      for (var user in vUsers) {
        _printUserRecordLine(user);
      }
    }

    print("\n$indent8$lineSeparator");
  }

  static void showListUsersScreen() => showUsersList();
}
