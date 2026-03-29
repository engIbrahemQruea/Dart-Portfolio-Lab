import 'package:bank_system/core/extensions/client_display_extension.dart';
import 'package:bank_system/core/utils/validation_utils.dart';
import 'package:bank_system/models/bank_client_model.dart';
import 'package:bank_system/presentation/screens/main_screen.dart';

class TotalBalancesScreen extends MainScreen {
  static void _printClientRecordBalanceLine(BankClientModel client) {
    String indent = "".padLeft(25);

    String line =
        "$indent| ${client.accountNumber.padRight(15)} "
        "| ${client.fullName.padRight(40)} "
        "| ${client.accountBalance.toStringAsFixed(2).padRight(12)}";

    print(line);
  }

  static void showTotalBalances() {
    List<BankClientModel> vClients = BankClientModel.getClientsList();

    String title = "\t  Balances List Screen";
    String subTitle = "\t    (${vClients.length}) Client(s).";

    MainScreen.drawScreenHeader(title, subTitle);

    String indent25 = "".padLeft(25);
    String lineSeparator =
        "_________________________________________________________________________________";

    print("$indent25$lineSeparator");
    String header =
        "$indent25| ${"Account Number".padRight(15)} "
        "| ${"Client Name".padRight(40)} "
        "| ${"Balance".padRight(12)}";

    print(header);
    print("$indent25$lineSeparator");
    print("$indent25");

    num totalBalances = BankClientModel.getTotalBalances();

    if (vClients.isEmpty) {
      print("\t\t\t\tNo Clients Available In the System!");
    } else {
      for (var client in vClients) {
        _printClientRecordBalanceLine(client);
      }
    }

    print("$indent25\n\t\t$lineSeparator");
    print("$indent25\n");

    String indent8 = "".padLeft(8);

    print(
      "$indent8\t\t\t\t\t\t\t     Total Balances = ${totalBalances.toUSD()}",
    );

    print("$indent8\t\t\t\t  ( ${totalBalances.toInt().toText()} )");
  }

  static void showTotalBalancesScreen() =>
      showTotalBalances();
}
