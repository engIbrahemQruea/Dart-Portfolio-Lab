import 'package:bank_system/core/enums/mode.dart';
import 'package:bank_system/core/utils/input_scanner.dart';
import 'package:bank_system/models/bank_client_model.dart';
import 'package:bank_system/presentation/screens/main_screen.dart';

class UpdateClientScreen {
  static void _readClientInfo(BankClientModel client) {
    print('Client Card: ');
    print('First Name      : ');
    client.setFirstName = InputScanner.readString(
      errorMessage: 'invalid first name',
    );
    print('Last Name       : ');
    client.setLastName = InputScanner.readString(
      errorMessage: 'invalid last name',
    );
    print('Email           : ');
    client.setEmail = InputScanner.readString(errorMessage: 'invalid email');
    print('Phone           : ');
    client.setPhone = InputScanner.readString(errorMessage: 'invalid phone');
    client.setAccountNumber = client.accountNumber;
    print('Pin Code        : ');
    client.setPinCode = InputScanner.readString(
      errorMessage: 'invalid pin code',
    );
    print('Account Balance : ');
    client.setAccountBalance = InputScanner.readNumber<double>(
      errorMessage: 'invalid account balance',
    );
  }

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

  static void showUpdateClient() {
    MainScreen.drawScreenHeader("\t Update Client Screen ");

    print('Please enter the account number of the client you want to update:');
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
    print('Update Client Information:');
    _readClientInfo(client);
    EnSaveResults result = client.save();
    switch (result) {
      case EnSaveResults.svSucceed:
        print('Client information updated successfully.');
        _printClient(client);
        break;
      case EnSaveResults.svFailedEmptyObject:
        print('Failed to update client information: Empty client object.');
        break;
      case EnSaveResults.svFailedAccountNumberExists:
        print(
          'Failed to update client information: Account number already exists.',
        );
        break;
    }
  }

  static void showUpdateClientScreen() {
    if (!MainScreen.checkAccessAndShowMessage(EnPermissions.pUpdateClients)) {
      return;
    }

    showUpdateClient();
  }
}
