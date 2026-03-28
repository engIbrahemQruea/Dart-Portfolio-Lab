import 'package:bank_system/core/utils/input_scanner.dart';
import 'package:bank_system/core/utils/validation_utils.dart';
import 'package:bank_system/models/bank_client_model.dart';

int calculate() {
  return 6 * 7;
}

// void readClientInfo(BankClientModel client) {
//   print('Client Card: ');
//   print('First Name      : ');
//   client.setFirstName = InputScanner.readString(
//     errorMessage: 'invalid first name',
//   );
//   print('Last Name       : ');
//   client.setLastName = InputScanner.readString(
//     errorMessage: 'invalid last name',
//   );
//   print('Email           : ');
//   client.setEmail = InputScanner.readString(errorMessage: 'invalid email');
//   print('Phone           : ');
//   client.setPhone = InputScanner.readString(errorMessage: 'invalid phone');
//   client.setAccountNumber = client.accountNumber;
//   print('Pin Code        : ');
//   client.setPinCode = InputScanner.readString(errorMessage: 'invalid pin code');
//   print('Account Balance : ');
//   client.setAccountBalance = InputScanner.readNumber<double>(
//     errorMessage: 'invalid account balance',
//   );

//   print('___________________');
// }

// void updateClient() {
//   print('Please enter the account number of the client you want to update:');
//   String accountNumber = InputScanner.readString(
//     errorMessage: 'invalid account number',
//   );
//   while (!BankClientModel.isClientExist(accountNumber)) {
//     print(
//       'Client with account number $accountNumber does not exist. Please enter a valid account number:',
//     );
//     accountNumber = InputScanner.readString(
//       errorMessage: 'invalid account number',
//     );
//   }
//   BankClientModel client =
//       BankClientModel.findBankClientByAccountNumberORPinCode(accountNumber: accountNumber);
//   client.printInfoBankClient();
//   print('Update Client Information:');
//   readClientInfo(client);
//   EnSaveResults result = client.save();
//   switch (result) {
//     case EnSaveResults.svSucceed:
//       print('Client information updated successfully.');
//       client.printInfoBankClient();
//       break;
//     case EnSaveResults.svFailedEmptyObject:
//       print('Failed to update client information: Empty client object.');
//       break;
//   }
// }

// void _handleAddingResult(EnSaveResults result, BankClientModel client) {
//   switch (result) {
//     case EnSaveResults.svSucceed:
//       print('\n✅ New client added successfully.');
//       client.printInfoBankClient();
//       break;
//     case EnSaveResults.svFailedAccountNumberExists:
//       print('\n❌ Failed: Account number already exists in the system.');
//       break;
//     default:
//       print('\n❌ Failed: An unexpected error occurred.');
//   }
// }


// void deleteClient() {
//   print('Please enter the account number of the client you want to delete:');
//   String accountNumber = InputScanner.readString(
//     errorMessage: 'invalid account number',
//   );
//   while (!BankClientModel.isClientExist(accountNumber)) {
//     print(
//       'Client with account number $accountNumber does not exist. Please enter a valid account number:',
//     );
//     accountNumber = InputScanner.readString(
//       errorMessage: 'invalid account number',
//     );
//   }
//   BankClientModel client =
//       BankClientModel.findBankClientByAccountNumberORPinCode(
//         accountNumber: accountNumber,
//       );
//   client.printInfoBankClient();
//   print('Are you sure you want to delete this client y/n?');
//   String confirmation = InputScanner.readString(errorMessage: 'invalid input');
//   if (confirmation.toLowerCase() == 'y') {
//     if (client.delete()) {
//       client.printInfoBankClient();
//       print('Client deleted successfully.');
//     } else {
//       print('Failed to delete client. Please try again.');
//     }
//   }
// }

// void printClientRecordLine(BankClientModel client) {
//   String line = "| ${client.accountNumber.padRight(15)} "
//                 "| ${client.fullName.padRight(15)} "
//                 "| ${client.phone.padRight(10)} "
//                 "| ${client.email.padRight(20)} "
//                 "| ${client.pinCode.padRight(10)} "
//                 "| ${client.accountBalance.toString().padRight(12)}";

//   print(line);
// }

// void showClientsList() {  List<BankClientModel> vClients = BankClientModel.getClientsList();

//   print("\n\t\t\t\t\tClient List (${vClients.length}) Client(s).");
//   print("________________________________________________________________________________________________");

//   // رأس الجدول بتنسيق منظم
//   String header = "| ${"Account Number".padRight(15)} "
//                   "| ${"Client Name".padRight(15)} "
//                   "| ${"Phone".padRight(10)} "
//                   "| ${"Email".padRight(20)} "
//                   "| ${"Pin Code".padRight(10)} "
//                   "| ${"Balance".padRight(12)}";

//   print(header);
//   print("________________________________________________________________________________________________\n");

//   if (vClients.isEmpty) {
//     print("\t\t\t\tNo Clients Available In the System!");
//   } else {
//     // استخدام for-in loop البسيطة في Dart
//     for (var client in vClients) {
//       printClientRecordLine(client);
//     }
//   }

//   print("\n________________________________________________________________________________________________\n");
// }

void printClientRecordBalanceLine(BankClientModel client) {
  String accountNumber = client.accountNumber.padRight(15);
  String fullName = client.fullName.padRight(40);
  String balance = client.accountBalance.toStringAsFixed(2).padRight(12);

  print("| $accountNumber | $fullName | $balance |");
}

void showTotalBalances() {
  List<BankClientModel> vClients = BankClientModel.getClientsList();

  print("\n\t\t\t\t\tBalances List (${vClients.length}) Client(s).");
  print(
    "________________________________________________________________________________________________",
  );

  String header =
      "| ${"Account Number".padRight(15)} "
      "| ${"Client Name".padRight(40)} "
      "| ${"Balance".padRight(12)} |";

  print(header);
  print(
    "________________________________________________________________________________________________\n",
  );

  num totalBalances = BankClientModel.getTotalBalances();

  if (vClients.isEmpty) {
    print("\t\t\t\tNo Clients Available In the System!");
  } else {
    for (var client in vClients) {
      printClientRecordBalanceLine(client);
    }
  }

  print(
    "\n________________________________________________________________________________________________\n",
  );

  print("\t\t\t\t\t   Total Balances = ${totalBalances.toStringAsFixed(2)}");

  print("\t\t\t\t\t   ( ${totalBalances.toInt().toText()} )");
}
