import 'package:bank_system/core/enums/mode.dart';
import 'package:bank_system/models/bank_client_model.dart';
import 'package:bank_system/presentation/screens/main_screen.dart';

class ListClientsScreen extends MainScreen {
  static void printClientRecordLine(BankClientModel client) {
    String line =
        "| ${client.accountNumber.padRight(15)} "
        "| ${client.fullName.padRight(15)} "
        "| ${client.phone.padRight(10)} "
        "| ${client.email.padRight(20)} "
        "| ${client.pinCode.padRight(10)} "
        "| ${client.accountBalance.toString().padRight(12)}";

    print(line);
  }

  static void showClientsList() {
    List<BankClientModel> vClients = BankClientModel.getClientsList();

    String title = '\t Client List Screen';
    String subTitle = "\t (${vClients.length}) Client(s).";

    MainScreen.drawScreenHeader(title, subTitle);

    print(
      "________________________________________________________________________________________________",
    );

    String header =
        "| ${"Account Number".padRight(15)} "
        "| ${"Client Name".padRight(15)} "
        "| ${"Phone".padRight(10)} "
        "| ${"Email".padRight(20)} "
        "| ${"Pin Code".padRight(10)} "
        "| ${"Balance".padRight(12)}";

    print(header);
    print(
      "________________________________________________________________________________________________\n",
    );

    if (vClients.isEmpty) {
      print("\t\t\t\tNo Clients Available In the System!");
    } else {
      for (var client in vClients) {
        printClientRecordLine(client);
      }
    }

    print(
      "\n________________________________________________________________________________________________\n",
    );
  }

  static void showAllClientsScreen() {
    if (!MainScreen.checkAccessAndShowMessage(EnPermissions.pListClients))
      return;
    return showClientsList();
  }
}
