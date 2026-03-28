import 'package:bank_system/core/utils/constance.dart';
import 'package:bank_system/data_access/services.dart';
import 'package:bank_system/models/login_record_model.dart';

class LoginRegisterRepos {
  static const String _fileLogPath = logFileName;
  static void saveLogUser(LoginRecordModel logUser) {
    Services.addLineToFile(logUser.toLine(), _fileLogPath);
  }

  static List<LoginRecordModel> loadLogUsers() {
    final lines = Services.loadLinesFromFile(_fileLogPath);
    return lines.map((line) => LoginRecordModel.fromLine(line)).toList();
  }
}
