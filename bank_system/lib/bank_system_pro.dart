import 'package:bank_system/business_logic/bank_client_controller.dart';
import 'package:bank_system/core/enums/mode.dart';
import 'package:bank_system/core/utils/input_scanner.dart';
import 'package:bank_system/models/bank_client_model_pro.dart';

void readClientInfo(BankClientModelPro client) {
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
  client.accountNumber = client.accountNumber;
  print('Pin Code        : ');
  client.pinCode = InputScanner.readString(errorMessage: 'invalid pin code');
  print('Account Balance : ');
  client.accountBalance = InputScanner.readNumber<double>(
    errorMessage: 'invalid account balance',
  );

  print('___________________');
}

void addNewClientPro() {
  print('Please enter the account number of the new client:');
  String accountNumber = InputScanner.readString(
    errorMessage: 'invalid account number',
  );
  while (BankClientController.isClientExist(accountNumber)) {
    print(
      'Client with account number $accountNumber already exists. Please enter a different account number:',
    );
    accountNumber = InputScanner.readString(
      errorMessage: 'invalid account number',
    );
  }
  BankClientModelPro newClient = BankClientModelPro.addNew(accountNumber);
  readClientInfo(newClient);
  EnSaveResults result = BankClientController.save(newClient);
  switch (result) {
    case EnSaveResults.svSucceed:
      print('New client added successfully.');
      newClient.printInfoBankClientPro();
      break;
    case EnSaveResults.svFailedEmptyObject:
      print('Failed to add new client: Empty client object.');
      break;
    case EnSaveResults.svFailedAccountNumberExists:
      print('Failed to add new client: Account number already exists.');
      break;
  }
}

void deleteClientPro() {
  print('Please enter the account number of the client you want to delete:');
  String accountNumber = InputScanner.readString(
    errorMessage: 'invalid account number',
  );
  while (!BankClientController.isClientExist(accountNumber)) {
    print(
      'Client with account number $accountNumber does not exist. Please enter a valid account number:',
    );
    accountNumber = InputScanner.readString(
      errorMessage: 'invalid account number',
    );
  }
  BankClientModelPro client =
      BankClientController.findBankClientByAccountNumberORPinCode(accountNumber: accountNumber);
  client.printInfoBankClientPro();
  print('Are you sure you want to delete this client y/n?');
  String confirmation = InputScanner.readString(errorMessage: 'invalid input');
  if (confirmation.toLowerCase() == 'y') {
    if (BankClientController.delete(client)) {
      client.printInfoBankClientPro();
      print('Client deleted successfully.');
    } else {
      print('Failed to delete client. Please try again.');
    }
  }
}


