import 'dart:io';

import 'package:bank_system/business_logic/bank_user_controller.dart';
import 'package:bank_system/core/enums/mode.dart';
import 'package:bank_system/core/utils/input_scanner.dart';
import 'package:bank_system/models/bank_user_model.dart';
import 'package:bank_system/presentation/screens/main_screen.dart';

class AddUserScreen extends MainScreen {
  static BankUserModel _readUserInfo(BankUserModel user) {
    print('Enter First Name: ');
    String fn = InputScanner.readString(errorMessage: 'invalid name');

    print('Enter Last Name: ');
    String ln = InputScanner.readString(errorMessage: 'invalid name');

    print('Enter Email: ');
    String email = InputScanner.readString(errorMessage: 'invalid email');

    print('Enter Phone: ');
    String phone = InputScanner.readString(errorMessage: 'invalid phone');

    print('Enter Password: ');
    String pass = InputScanner.readString(errorMessage: 'invalid password');

    print('Enter Permission: ');
    int perm = _readPermissionToSet();

    return user.copyWith(
      firstName: fn,
      lastName: ln,
      email: email,
      phone: phone,
      username: user.username,
      password: pass,
      permission: perm,
    );
  }

  static int _readPermissionToSet() {
    stdout.write('Do you want to give full access? y/n? ');
    if (InputScanner.readString(
          errorMessage: 'invalid input Enter y or n',
        ).toLowerCase() ==
        'y') {
      return EnPermissions.eAll.value;
    }

    int permission = 0;
    final permissionsMap = {
      'Show Client List?': EnPermissions.pListClients,
      'Add New Client?': EnPermissions.pAddNewClient,
      'Delete Client?': EnPermissions.pDeleteClient,
      'Update Client?': EnPermissions.pUpdateClients,
      'Find Client?': EnPermissions.pFindClient,
      'Show Transactions?': EnPermissions.pTransactions,
      'Manage Users?': EnPermissions.pManageUsers,
      'Log Registers?': EnPermissions.pLogRegisters,
      'Currency Exchange?': EnPermissions.pCurrencyExchange,
    };

    permissionsMap.forEach((question, perm) {
      stdout.write('Do you want to give access to $question y/n? ');
      if (InputScanner.readString(
            errorMessage: 'invalid input Enter y or n',
          ).toLowerCase() ==
          'y') {
        permission += perm.value;
      }
    });
    return permission;
  }

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

  static void showAddNewUser() {
    MainScreen.drawScreenHeader("\t  Add User Screen");

    print('Please enter the username of the new user:');
    String username = InputScanner.readString(errorMessage: 'invalid username');
    while (BankUserController.isUserExist(username)) {
      print(
        'User with username $username already exists. Please enter a different username:',
      );
      username = InputScanner.readString(errorMessage: 'invalid username');
    }
    BankUserModel newUser = BankUserModel.getAddNewUser(username);

    newUser = _readUserInfo(newUser);
    EnSaveResults result = BankUserController.save(newUser);
    switch (result) {
      case EnSaveResults.svSucceed:
        print('New user added successfully.');
        _printUser(newUser);
        break;
      case EnSaveResults.svFailedEmptyObject:
        print('Failed to add new user: Empty user object.');
        break;
      case EnSaveResults.svFailedAccountNumberExists:
        print('Failed to add new user: Username already exists.');
        break;
    }
  }

  static void showAddUserScreen() => showAddNewUser();
}
