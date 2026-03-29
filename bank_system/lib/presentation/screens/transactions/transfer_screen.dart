import 'dart:io';

import 'package:bank_system/business_logic/transfer_log_controller.dart';
import 'package:bank_system/core/extensions/date_extensions.dart';
import 'package:bank_system/core/global/global_vars.dart';
import 'package:bank_system/core/utils/input_scanner.dart';
import 'package:bank_system/models/bank_client_model.dart';
import 'package:bank_system/models/transfer_log_model.dart';
import 'package:bank_system/presentation/screens/main_screen.dart';

class TransferScreen extends MainScreen {
  static void _printClientCard(BankClientModel client) {
    print('\nClient Card:');
    print('___________________');
    print('Full Name      : ${client.fullName}');
    print('Account Number : ${client.accountNumber}');
    print('Balance        : ${client.accountBalance}');
    print('___________________\n');
  }

  static void showTransfer() {
    MainScreen.drawScreenHeader("\t  Transfer Screen");

    BankClientModel? sourceClient = _getValidClient("From");
    if (sourceClient == null) return;
    _printClientCard(sourceClient);

    BankClientModel? destClient = _getValidClient("To");
    if (destClient == null) return;

    while (destClient!.accountNumber == sourceClient.accountNumber) {
      print("Error: Cannot transfer to the same account!");
      destClient = _getValidClient("To");
    }
    _printClientCard(destClient);

    print('Enter Transfer Amount: ');
    num amount = InputScanner.readNumberBetween(
      0.01,
      sourceClient.accountBalance,
      errorMessage:
          'Amount Exceeds the available Balance: ${sourceClient.accountBalance}, Enter another amount',
    );

    while (amount <= 0 || amount > sourceClient.accountBalance) {
      print('Invalid Amount! Available: ${sourceClient.accountBalance}');
      amount = InputScanner.readNumber<num>(errorMessage: 'Invalid amount');
    }

    stdout.write('Are you sure? y/n: ');
    if (InputScanner.readString(errorMessage: 'Invalid input').toLowerCase() ==
        'y') {
      var (success, message) = sourceClient.transfer(destClient, amount);
      print(message);
      if (success) {
        final transferLog = TransferLogModel(
          dateTime: DateTime.now().format12Hour(),
          senderAccNumber: sourceClient.accountNumber,
          receiverAccNumber: destClient.accountNumber,
          transferAmount: amount,
          senderAmountAfter: sourceClient.accountBalance,
          receiverAmountAfter: destClient.accountBalance,
          transferUser: currentUser.username,
        );
        TransferLogController.registerTransferLog(transferLog);
      }
    }
  }

  static BankClientModel? _getValidClient(String direction) {
    stdout.write('Enter Account Number to transfer $direction: ');
    String acc = InputScanner.readString(
      errorMessage: 'Invalid account number',
    );

    while (!BankClientModel.isClientExist(acc)) {
      stdout.write('Client not found! Try again: ');
      acc = InputScanner.readString(errorMessage: 'Invalid account number');
    }
    return BankClientModel.findBankClientByAccountNumberORPinCode(
      accountNumber: acc,
    );
  }

  static void showTransferScreen() {
    showTransfer();
  }
}
