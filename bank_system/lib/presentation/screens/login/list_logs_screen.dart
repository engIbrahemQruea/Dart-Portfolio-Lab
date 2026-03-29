import 'dart:io';

import 'package:bank_system/business_logic/auth_controller.dart';
import 'package:bank_system/core/enums/mode.dart';
import 'package:bank_system/models/login_record_model.dart';
import 'package:bank_system/presentation/screens/main_screen.dart';

class ListLogsScreen extends MainScreen {
  static void _printLoginRegisterRecordLine(LoginRecordModel record) {
    String space = "".padLeft(8);

    stdout.write("$space| ${record.dateTime.padRight(35)}");
    stdout.write("| ${record.username.padRight(10)}");
    stdout.write("| ${record.status.padRight(10)}");
    stdout.write("| ${record.password.padRight(10)}");
    stdout.write("| ${record.permissions.toString().padRight(10)}");
  }

  static void showLoginRegister() {
    List<LoginRecordModel> vLoginRegisterRecord = AuthController.getLogUsers();

    String title = "\tLogin Register List Screen";
    String subTitle = "\t\t(${vLoginRegisterRecord.length}) Record(s).";

    MainScreen.drawScreenHeader(title, subTitle);

    String space = "".padLeft(8);
    String line =
        "_______________________________________________________________________________________";

    print("$space\n\t$line\n");

    stdout.write("$space| ${"Date/Time".padRight(35)}");
    stdout.write("| ${"UserName".padRight(10)}");
    stdout.write("| ${"Status".padRight(10)}");
    stdout.write("| ${"Password".padRight(10)}");
    stdout.write("| ${"Permissions".padRight(10)}");

    print("\n$space\t$line\n");

    if (vLoginRegisterRecord.isEmpty) {
      print("\t\t\t\tNo Logins Available In the System!");
    } else {
      for (var record in vLoginRegisterRecord) {
        _printLoginRegisterRecordLine(record);
        print(""); // للنزول لسطر جديد بعد كل سجل
      }
    }

    print("\n$space\t$line\n");
  }

  static void showLoginRegisterScreen() {
    if (!MainScreen.checkAccessAndShowMessage(EnPermissions.pLogRegisters)) {
      return;
    }
    showLoginRegister();
    // showLoginRegisterTable();
  }
}
