
import 'package:bank_system/core/utils/constance.dart';
import 'package:bank_system/data_access/services.dart';
import 'package:bank_system/models/bank_user_model.dart';

class UserRepository {
  static const String _fileName = userFileName;

  static List<BankUserModel> loadUsers() {
    final lines = Services.loadLinesFromFile(_fileName);
    return lines
        .map((line) => BankUserModel.fromLine(line))
        .where((user) => !user.isEmpty) // تحسين: استبعاد أي مستخدم تالف
        .toList();
  }

  static void saveUsers(List<BankUserModel> users) {
    final lines = users.map((user) => user.toLine()).toList();
    Services.saveAllLinesToFile(_fileName, lines);
  }

  static void addUser(BankUserModel user) {
    Services.addLineToFile(user.toLine(), _fileName);
  }

static void updateSpecificUser(BankUserModel updatedUser) {
    final lines = Services.loadLinesFromFile(_fileName);
    
    for (int i = 0; i < lines.length; i++) {
      List<String> parts = lines[i].split("#//#");
      
      if (parts.length > 4 && parts[4].toLowerCase() == updatedUser.username.toLowerCase()) {
        lines[i] = updatedUser.toLine();
        break;
      }
    }

    Services.saveAllLinesToFile(_fileName, lines);
  }

  
}
