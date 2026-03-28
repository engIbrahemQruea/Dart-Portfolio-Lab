import 'package:bank_system/core/enums/mode.dart';
import 'package:bank_system/core/utils/input_scanner.dart';
import 'package:bank_system/models/bank_client_model.dart';
import 'package:bank_system/presentation/screens/main_screen.dart';

class DeleteClientScreen extends MainScreen {
  static void _printClient(BankClientModel client) {
    print('Client Card: ');
    print('___________________');
    print('First Name      : ${client.firstName}');
    print('Last Name       : ${client.lastName}');
    print('Full Name       : ${client.fullName}');
    print('Email           : ${client.email}');
    print('Phone           : ${client.phone}');
    print('Account Number  : ${client.accountNumber}');
    print('Pin Code        : ${client.pinCode}');
    print('Account Balance : ${client.accountBalance}');
    print('___________________');
  }

  static void showDeleteClient() {
    MainScreen.drawScreenHeader("\t Delete Client Screen ");
    print('Please enter the account number of the client you want to delete:');
    String accountNumber = InputScanner.readString(
      errorMessage: 'invalid account number',
    );
    while (!BankClientModel.isClientExist(accountNumber)) {
      print(
        'Client with account number $accountNumber does not exist. Please enter a valid account number:',
      );
      accountNumber = InputScanner.readString(
        errorMessage: 'invalid account number',
      );
    }
    BankClientModel client =
        BankClientModel.findBankClientByAccountNumberORPinCode(
          accountNumber: accountNumber,
        );
    _printClient(client);
    print('Are you sure you want to delete this client y/n?');
    String confirmation = InputScanner.readString(
      errorMessage: 'invalid input',
    );
    if (confirmation.toLowerCase() == 'y') {
      if (client.delete()) {
        _printClient(client);
        print('Client deleted successfully.');
      } else {
        print('Failed to delete client. Please try again.');
      }
    }
  }

  static void showDeleteClientScreen() {
    if (!MainScreen.checkAccessAndShowMessage(EnPermissions.pDeleteClient))
      return;
    showDeleteClient();
  }
}
