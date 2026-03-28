import 'package:bank_system/core/enums/mode.dart';
import 'package:bank_system/core/utils/input_scanner.dart';
import 'package:bank_system/models/bank_client_model.dart';
import 'package:bank_system/presentation/screens/main_screen.dart';

class FindClientScreen extends MainScreen {
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

  static void showFindClient() {
    MainScreen.drawScreenHeader("\t Find Client Screen ");
    print(
      'Please enter the account number or pin code of the client you want to find:',
    );
    String input = InputScanner.readString(errorMessage: 'invalid input');
    while (!BankClientModel.isClientExist(input)) {
      print(
        'Client with account number or pin code $input does not exist. Please enter a valid account number or pin code:',
      );
      input = InputScanner.readString(errorMessage: 'invalid input');
    }
    BankClientModel client =
        BankClientModel.findBankClientByAccountNumberORPinCode(
          accountNumber: input,
        );
    if (!client.isEmpty) {
      print('Client Found :-)');
    } else {
      print('Client Not Found :-(');
    }
    _printClient(client);
  }

  static void showFindClientScreen() {
    if (!MainScreen.checkAccessAndShowMessage(EnPermissions.pFindClient))
      return;
    showFindClient();
  }
}
