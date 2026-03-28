import 'package:bank_system/business_logic/bank_user_controller.dart';
import 'package:bank_system/core/enums/users_menu_options.dart';
import 'package:bank_system/core/extensions/date_extensions.dart';
import 'package:bank_system/core/global/global_vars.dart';
import 'package:bank_system/data_access/repositories/login_register_repos.dart';
import 'package:bank_system/data_access/repositories/transfer_log_repos.dart';
import 'package:bank_system/models/bank_user_model.dart';
import 'package:bank_system/models/login_record_model.dart';
import 'package:bank_system/models/transfer_log_model.dart';

class AuthController {
  static bool login(String username, String password) {
    BankUserModel user = BankUserController.find(
      username: username,
      password: password,
      withPasswordCheck: true,
    );

    if (!user.isEmpty) {
      currentUser = user;
      return true;
    }
    return false;
  }

  static void logout() {
    //registerLogIn(EnLogStatus.logout);
    currentUser = BankUserModel.empty();
  }

  static void registerLogIn(EnLogStatus status) {
    final logUser = LoginRecordModel(
      username: currentUser.username,
      status: status.title,
      dateTime: DateTime.now().format12Hour(),
      password: currentUser.password,
      permissions: currentUser.permission,
    );

    LoginRegisterRepos.saveLogUser(logUser);
  }

  static List<LoginRecordModel> getLogUsers() {
    return LoginRegisterRepos.loadLogUsers();
  }


}
