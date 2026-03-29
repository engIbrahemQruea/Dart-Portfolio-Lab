import 'dart:io';

import 'package:bank_system/business_logic/bank_user_controller.dart';
import 'package:bank_system/core/extensions/client_display_extension.dart';
import 'package:bank_system/core/utils/input_scanner.dart';
import 'package:bank_system/models/bank_user_model.dart';
import 'package:bank_system/presentation/screens/main_screen.dart';

class DeleteUserScreen extends MainScreen {
  static void showDeleteUser() {
    MainScreen.drawScreenHeader("\t  Delete User Screen");

    stdout.write('Please enter username to delete: ');
    String username = InputScanner.readString(errorMessage: 'Invalid username');

    while (!BankUserController.isUserExist(username) || username.isAdmin()) {
      if (username.isAdmin()) {
        print(
          '⛔ Access Denied: Admin user is protected and cannot be removed.',
        );
      } else {
        print('⚠️ User [$username] not found. Try again:');
      }
      username = InputScanner.readString(errorMessage: 'Invalid username');
    }

    BankUserModel user = BankUserController.find(username: username);
    user.printInfo();

    stdout.write('\n⚠️ Are you sure you want to delete this user? (y/n): ');
    if (InputScanner.readString(
          errorMessage: 'Invalid input Enter y or n',
        ).toLowerCase() ==
        'y') {
      if (BankUserController.delete(username)) {
        print('✅ User [$username] has been purged from the system.');
      } else {
        print('❌ Failed: An internal error occurred during deletion.');
      }
    } else {
      print('ℹ️ Operation cancelled.');
    }
  }

  static void showDeleteUserScreen() => showDeleteUser();
}
