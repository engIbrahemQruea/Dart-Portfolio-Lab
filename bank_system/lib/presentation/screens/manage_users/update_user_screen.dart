import 'dart:io';

import 'package:bank_system/business_logic/bank_user_controller.dart';
import 'package:bank_system/core/enums/mode.dart';
import 'package:bank_system/core/utils/input_scanner.dart';
import 'package:bank_system/models/bank_user_model.dart';
import 'package:bank_system/presentation/screens/main_screen.dart';

class UpdateUserScreen extends MainScreen {
  static BankUserModel _readUserInfo(BankUserModel user) {
    String updateField(String label, String oldValue) {
      stdout.write('Enter $label [$oldValue]: ');
      String input = stdin.readLineSync() ?? '';
      return input.trim().isEmpty ? oldValue : input;
    }

    String fn = updateField('First Name', user.firstName);
    String ln = updateField('Last Name', user.lastName);
    String email = updateField('Email', user.email);
    String phone = updateField('Phone', user.phone);
    String pass = updateField('Password', user.password);

    print('Current Permission: ${user.permission}');
    stdout.write('Do you want to update permissions? y/n: ');
    int perm = user.permission;
    if (stdin.readLineSync()?.toLowerCase() == 'y') {
      perm = _readPermissionToSet();
    }

    return user.copyWith(
      firstName: fn,
      lastName: ln,
      email: email,
      phone: phone,
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

  static void showUpdateUser() {
    MainScreen.drawScreenHeader("\t  Update User Screen");

    print('Please enter the username of the user you want to update:');
    String username = InputScanner.readString(errorMessage: 'invalid username');

    while (!BankUserController.isUserExist(username)) {
      print(
        'User with username $username does not exist. Please enter a valid username:',
      );
      username = InputScanner.readString(errorMessage: 'invalid username');
    }
    BankUserModel user = BankUserController.find(username: username);
    user.printInfo();

    print('Are you sure you want to update this user y/n?');
    String confirmation = InputScanner.readString(
      errorMessage: 'invalid input',
    );
    if (confirmation.toLowerCase() == 'y') {
      print('Update User Information:');
      user = _readUserInfo(user);
      EnSaveResults result = BankUserController.save(user);
      switch (result) {
        case EnSaveResults.svSucceed:
          print('User Updated Successfully :-)');
          _printUser(user);
          break;
        case EnSaveResults.svFailedEmptyObject:
          print('Error User was not saved because it\'s Empty');
          break;
        case EnSaveResults.svFailedAccountNumberExists:
          print('Failed to update user: Username already exists.');
          break;
      }
    } else {
      print('Update canceled.');
    }
  }

  static void showUpdateUserScreen() => showUpdateUser();
}
