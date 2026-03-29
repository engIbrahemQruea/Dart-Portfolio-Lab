import 'package:bank_system/business_logic/transfer_log_controller.dart';
import 'package:bank_system/models/transfer_log_model.dart';
import 'package:bank_system/presentation/screens/main_screen.dart';

class TransferLogScreen extends MainScreen {
  static void showTransferLog() {
    List<TransferLogModel> logs = TransferLogController.getTransferLogs();

    String title = "\t  Transfer Log List Screen";
    String subTitle = "\t    (${logs.length}) Record(s).";

    MainScreen.drawScreenHeader(title, subTitle);

    print(
      "________________________________________________________________________________________________",
    );
    print(
      "| ${'Date/Time'.padRight(20)} | ${'S.Acct'.padRight(8)} | ${'R.Acct'.padRight(8)} | ${'Amount'.padRight(10)} | ${'S.Balance'.padRight(10)} | ${'R.Balance'.padRight(10)} | ${'User'.padRight(8)} |",
    );
    print(
      "________________________________________________________________________________________________",
    );

    if (logs.isEmpty) {
      print("\t\t\t\tNo Transfer Logs Available.");
    } else {
      for (var log in logs) {
        print(
          "| ${log.dateTime.padRight(20)} | ${log.senderAccNumber.padRight(8)} | ${log.receiverAccNumber.padRight(8)} | ${log.transferAmount.toString().padRight(10)} | ${log.senderAmountAfter.toString().padRight(10)} | ${log.receiverAmountAfter.toString().padRight(10)} | ${log.transferUser.padRight(8)} |",
        );
      }
    }
    print(
      "________________________________________________________________________________________________\n",
    );
  }

  static void showTransferLogScreen() {
    showTransferLog();
  }
}
