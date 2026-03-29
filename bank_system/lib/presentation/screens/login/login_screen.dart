import 'dart:io';

import 'package:bank_system/business_logic/auth_controller.dart';
import 'package:bank_system/core/enums/users_menu_options.dart';
import 'package:bank_system/core/global/global_vars.dart';
import 'package:bank_system/core/utils/input_scanner.dart';
import 'package:bank_system/models/bank_user_model.dart';
import 'package:bank_system/presentation/screens/main_screen.dart';

class LoginScreen extends MainScreen {
 static void showLogin() {
    int trials = 3;
    String userName, passWord;

    while (trials > 0) {
      print('-----------------------------------------');
      print('Attempts remaining: $trials');
      
      stdout.write('Enter Username: ');
      userName = InputScanner.readString(errorMessage: 'Invalid username');

      stdout.write('Enter Password: ');
      passWord = InputScanner.readString(errorMessage: 'Invalid password');

      if (AuthController.login(userName, passWord)) {
        print('\n✅ Login Successful. Welcome back ${currentUser.firstName}!');
        return;
      } else {
        trials--;
        if (trials > 0) {
          print('\n❌ Invalid Username/Password! Please try again.');
        }
      }
    }

    print('\n❌ System Locked: You have exceeded the maximum number of attempts.\n');
    AuthController.registerLogIn(EnLogStatus.logout);
    currentUser = BankUserModel.empty(); 
  }
  static void showLoginScreen() {
    MainScreen.drawScreenHeader("\t  Login Screen");
    showLogin();
  }
}
