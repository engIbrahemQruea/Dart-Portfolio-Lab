import 'package:bank_system/core/utils/constance.dart';
import 'package:bank_system/data_access/services.dart';
import 'package:bank_system/models/transfer_log_model.dart';

class TransferLogRepos {
  static const String _filePath = transactionFileName;
  static void saveTransferLog(TransferLogModel transferLog) {
    Services.addLineToFile(transferLog.toLine(), _filePath);
  }

  static List<TransferLogModel> loadTransferLogs() {
    final lines = Services.loadLinesFromFile(_filePath);
    return lines.map((line) => TransferLogModel.fromLine(line)).toList();
  }
}
