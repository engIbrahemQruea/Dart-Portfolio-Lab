import 'package:bank_system/core/enums/mode.dart';
import 'package:bank_system/core/extensions/date_extensions.dart';
import 'package:bank_system/core/global/global_vars.dart';

class MainScreen {
  static void drawScreenHeader(String title, [String subTitle = ""]) {
    print("\t\t\t\t\t______________________________________");
    print("\n\t\t\t\t\t  $title");

    if (subTitle.isNotEmpty) {
      print("\t\t\t\t\t  $subTitle");
    }

    print("\t\t\t\t\t______________________________________\n");
    _showSessionInfo();
  }

  static bool checkAccessAndShowMessage(EnPermissions permission) {
    if (!EnPermissions.hasPermission(currentUser.permission, permission)) {
      print("\t\t\t\t\t______________________________________");
      print("\n\t\t\t\t\t  Access Denied! Contact your Admin.");
      print("\n\t\t\t\t\t______________________________________");
      return false;
    }
    return true;
  }

static void _showSessionInfo() {
    String user = currentUser.isEmpty ? "Guest" : currentUser.username;
    String date = DateTime.now().format12Hour(); 
    
    print("\t\t\t\t\tUser: $user | Date: $date");
  }

 
}
