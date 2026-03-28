import 'package:bank_system/data_access/repositories/transfer_log_repos.dart';
import 'package:bank_system/models/transfer_log_model.dart';

class TransferLogController  {
  static List<TransferLogModel> getTransferLogs() {
    return TransferLogRepos.loadTransferLogs();
  }

  static void registerTransferLog(TransferLogModel transferLog) {
    TransferLogRepos.saveTransferLog(transferLog);
  }
}
