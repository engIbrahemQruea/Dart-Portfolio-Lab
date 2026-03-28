// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:bank_system/core/enums/mode.dart';
import 'package:bank_system/core/extensions/client_display_extension.dart';
import 'package:bank_system/core/utils/constance.dart';
import 'package:bank_system/models/person_model.dart';

class BankClientModel extends PersonModel {
  EnMode _mode;

  String _accountNumber, _pinCode;
  double _accountBalance;

  BankClientModel({
    required super.firstName,
    required super.lastName,
    required super.email,
    required super.phone,
    required EnMode mode,
    required String accountNumber,
    required String pinCode,
    required double accountBalance,
  }) : _accountNumber = accountNumber,
       _pinCode = pinCode,
       _accountBalance = accountBalance,
       _mode = mode;

  static BankClientModel _convertLineToBankClientModelObject(
    String line, {
    String seperator = "#//#",
  }) {
    List<String> parts = line.split(seperator);

    return BankClientModel(
      mode: EnMode.updateMode,
      firstName: parts[0],
      lastName: parts[1],
      email: parts[2],
      phone: parts[3],
      accountNumber: parts[4],
      pinCode: parts[5],
      accountBalance: double.parse(parts[6]),
    );
  }

  static String _convertBankClientModelObjectToLine(
    BankClientModel client, {
    String seperator = "#//#",
  }) {
    return [
      // client._mode.toString(),
      client.firstName,
      client.lastName,
      client.email,
      client.phone,
      client.accountNumber,
      client.pinCode,
      client.accountBalance.toString(),
    ].join(seperator);
  }

  static BankClientModel _getEmptyBankClientModelObject() {
    return BankClientModel(
      mode: EnMode.emptyMode,
      firstName: '',
      lastName: '',
      email: '',
      phone: '',
      accountNumber: '',
      pinCode: '',
      accountBalance: 0.0,
    );
  }

  bool get isEmpty => _mode == EnMode.emptyMode;

  set setMode(EnMode mode) => _mode = mode;
  set setAccountNumber(String accountNumber) => _accountNumber = accountNumber;
  set setPinCode(String pinCode) => _pinCode = pinCode;
  set setAccountBalance(double accountBalance) =>
      _accountBalance = accountBalance;

  String get accountNumber => _accountNumber;
  String get pinCode => _pinCode;
  double get accountBalance => _accountBalance;

  static List<BankClientModel> _loadDataFromFile() {
    final file = File(clientFileName);
    if (!file.existsSync()) return [];
    try {
      return file
          .readAsLinesSync()
          .where((line) => line.trim().isNotEmpty)
          .map((line) => _convertLineToBankClientModelObject(line))
          .toList();
    } catch (e) {
      print('Error reading file: $e');
      return [];
    }
  }

  static BankClientModel findBankClientByAccountNumberORPinCode({
    required String accountNumber,
    String pinCode = "",
    bool withPinCodeCheck = false,
  }) {
    final clients = _loadDataFromFile();
    return clients.firstWhere(
      (client) =>
          client.accountNumber.trim().toUpperCase() ==
              accountNumber.trim().toUpperCase() &&
          (!withPinCodeCheck || client.pinCode.trim() == pinCode.trim()),
      orElse: () => _getEmptyBankClientModelObject(),
    );
  }

  static bool isClientExist(String accountNumber) {
    BankClientModel client = findBankClientByAccountNumberORPinCode(
      accountNumber: accountNumber,
    );
    return !client.isEmpty;
  }

  static void _saveClientsDataToFile(List<BankClientModel> clients) {
    try {
      final file = File(clientFileName);
      String allData = clients
          .map((c) => _convertBankClientModelObjectToLine(c))
          .join('\n');

      if (allData.isNotEmpty) allData += '\n';
      file.writeAsStringSync(allData);
    } catch (e) {
      stderr.writeln('Critical Error: Could not refresh file. Details: $e');
    }
  }

  EnSaveResults save() {
    switch (_mode) {
      case EnMode.emptyMode:
        return EnSaveResults.svFailedEmptyObject;
      case EnMode.updateMode:
        _updateClientDataInFile();
        return EnSaveResults.svSucceed;
      case EnMode.addNewMode:
        {
          if (BankClientModel.isClientExist(accountNumber)) {
            return EnSaveResults.svFailedAccountNumberExists;
          } else {
            _addNew();
            _mode = EnMode.updateMode;
            return EnSaveResults.svSucceed;
          }
        }
    }
  }

  void _updateClientDataInFile() {
    final clients = _loadDataFromFile();
    final index = clients.indexWhere(
      (client) =>
          client.accountNumber.trim().toUpperCase() ==
          accountNumber.trim().toUpperCase(),
    );

    if (index != -1) {
      clients[index] = this;
      _saveClientsDataToFile(clients);
    } else {
      stderr.writeln(
        'Error: Client with account number $accountNumber not found.',
      );
    }
  }

  /// Additional method to add new client to file

  void _addNew() {
    _saveDataToFile(_convertBankClientModelObjectToLine(this));
  }

  static void _saveDataToFile(String lineData) {
    try {
      final file = File(clientFileName);

      file.writeAsStringSync('$lineData\n', mode: FileMode.append, flush: true);
    } catch (e) {
      stderr.writeln(
        'Critical Error: Could not save to $clientFileName. Details: $e',
      );
    }
  }

  static BankClientModel getAddNewClient(String accountNumber) {
    return BankClientModel(
      mode: EnMode.addNewMode,
      firstName: '',
      lastName: '',
      email: '',
      phone: '',
      accountNumber: accountNumber,
      pinCode: '',
      accountBalance: 0.0,
    );
  }

  bool delete() {
    var clients = _loadDataFromFile();
    final initialLength = clients.length;
    clients.removeWhere(
      (client) =>
          client.accountNumber.trim().toUpperCase() ==
          accountNumber.trim().toUpperCase(),
    );

    if (clients.length < initialLength) {
      _saveClientsDataToFile(clients);
      // clients = _getEmptyBankClientModelObject() ;
      return true;
    }
    return false;
  }

  static List<BankClientModel> getClientsList() {
    return _loadDataFromFile();
  }

  static num getTotalBalances() {
    final clients = _loadDataFromFile();
    return clients.fold(0.0, (sum, client) => sum + client.accountBalance);
  }

  (bool result, String message) deposit(num amount) {
    if (amount <= 0) {
      return (false, 'Invalid deposit amount. Please enter a positive value.');
    } else {
      _accountBalance += amount;
      save();
      return (
        true,
        'Amount deposited successfully. Your new balance is ${_accountBalance.toUSD()} \$',
      );
    }
  }

  (bool result, String message) withdraw(num amount) {
    if (amount <= 0) {
      return (
        false,
        'Invalid withdrawal amount. Please enter a positive value.',
      );
    } else if (amount > _accountBalance) {
      return (
        false,
        'Insufficient funds. Your current balance is ${_accountBalance.toUSD()} \$',
      );
    } else {
      _accountBalance -= amount;
      save();
      return (
        true,
        'Amount withdrawn successfully. Your new balance is ${_accountBalance.toUSD()}                                                                  ',
      );
    }
  }

  (bool result, String message) transferr(
    BankClientModel destination,

    num amount,
  ) {
    var (result, message) = withdraw(amount);
    if (result) {
      var (result2, message) = destination.deposit(amount);
      if (result2) {
        return (true, 'Amount transferred successfully.');
      } else {
        return (result2, message);
      }
    }
    return (result, message);
  }

  // داخل كلاس BankClientModel
  (bool success, String message) transfer(
    BankClientModel destination,
    num amount,
  ) {
    var (withdrawOk, withdrawMsg) = withdraw(amount);

    if (!withdrawOk) return (false, withdrawMsg);

    var (depositOk, _) = destination.deposit(amount);

    if (depositOk) {
      return (
        true,
        'Transfer completed: $amount moved to ${destination.accountNumber}',
      );
    }

    deposit(amount);
    return (false, 'Critical Error: Destination account rejected the deposit.');
  }
}
