import 'dart:io';

import 'package:bank_system/business_logic/bank_user_controller.dart';
import 'package:bank_system/core/extensions/client_display_extension.dart';
import 'package:bank_system/core/utils/input_scanner.dart';
import 'package:bank_system/models/bank_user_model.dart';
import 'package:bank_system/presentation/screens/main_screen.dart';

class FindUserScreen extends MainScreen {
  static void _printUser(BankUserModel user) {
    print('User Card:');
    print('___________________');
    print('First Name      : ${user.firstName}');
    print('Last Name       : ${user.lastName}');
    print('Full Name       : ${user.fullName}');
    print('Email           : ${user.email}');
    print('Phone           : ${user.phone}');
    print('Username        : ${user.username}');
    print('Password        : ${user.password}');
    print('Permission      : ${user.permission}');
    print('___________________');
  }

  static void showFindUser() {
    MainScreen.drawScreenHeader("\t  Find User Screen");
    print('Please enter the username of the user you want to find:');
    String username = InputScanner.readString(errorMessage: 'invalid username');

    while (!BankUserController.isUserExist(username)) {
      print(
        'User with username $username does not exist. Please enter a valid username:',
      );
      username = InputScanner.readString(errorMessage: 'invalid username');
    }
    BankUserModel user = BankUserController.find(username: username);
    if (!user.isEmpty) {
      print('User Found :-');
    } else {
      print('User Was not Found :-(');
    }
    _printUser(user);
  }

  static void showFindUserModren() {
    MainScreen.drawScreenHeader("\t  Find User Screen");

    stdout.write('Enter username to find: ');
    String username = InputScanner.readString(errorMessage: 'Invalid username');

    // استخدام الكنترولر مباشرة
    BankUserModel user = BankUserController.find(username: username);

    if (user.isEmpty) {
      print('❌ User [$username] was not found in our records.');
    } else {
      print('✅ User found successfully!');
      user.showCard(); // استخدام الـ Extension الجميل
    }
  }

  static void showFindUserScreen() => showFindUser();
}
