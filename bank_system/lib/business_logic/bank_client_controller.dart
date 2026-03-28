import 'package:bank_system/core/enums/mode.dart';
import 'package:bank_system/data_access/services.dart';
import 'package:bank_system/models/bank_client_model_pro.dart';

class BankClientController {
  static BankClientModelPro findBankClientByAccountNumberORPinCode({
    required String accountNumber,
    String pinCode = "",
    bool withPinCodeCheck = false,
  }) {
    final clients = Services.loadDataFromFile();
    return clients.firstWhere(
      (client) =>
          client.accountNumber.trim().toUpperCase() ==
              accountNumber.trim().toUpperCase() &&
          (!withPinCodeCheck || client.pinCode.trim() == pinCode.trim()),
      orElse: () => BankClientModelPro.empty(),
    );
  }

  static bool isClientExist(String accountNumber) {
    BankClientModelPro client = findBankClientByAccountNumberORPinCode(
      accountNumber: accountNumber,
    );
    return !client.getIsEmpty;
  }

  static EnSaveResults save(BankClientModelPro client) {
    switch (client.mode) {
      case EnMode.emptyMode:
        return EnSaveResults.svFailedEmptyObject;
      case EnMode.updateMode:
        update(client);
        return EnSaveResults.svSucceed;
      case EnMode.addNewMode:
        {
          if (isClientExist(client.accountNumber)) {
            return EnSaveResults.svFailedAccountNumberExists;
          } else {
            addNew(client);
            client.mode = EnMode.updateMode;
            return EnSaveResults.svSucceed;
          }
        }
    }
  }

  static void update(BankClientModelPro client) {
    final clients = Services.loadDataFromFile();
    int index = clients.indexWhere(
      (c) =>
          c.accountNumber.trim().toUpperCase() ==
          client.accountNumber.trim().toUpperCase(),
    );
    if (index != -1) {
      clients[index] = client;
      Services.saveClientsDataToFile(clients);
    }
  }

  static void addNew(BankClientModelPro client) {
    Services.saveDataToFile(client.toLine());
  }

  static bool delete(BankClientModelPro client) {
    final clients = Services.loadDataFromFile();
    int index = clients.indexWhere(
      (c) =>
          c.accountNumber.trim().toUpperCase() ==
          client.accountNumber.trim().toUpperCase(),
    );
    if (index != -1) {
      clients.removeAt(index);
      Services.saveClientsDataToFile(clients);
      return true;
    }
    return false;
  }

  static List<BankClientModelPro> getClientsList() {
    return Services.loadDataFromFile();
  }

  static (bool, String) deposit(BankClientModelPro client, num amount) {
    if (amount <= 0) {
      return (false, 'Invalid amount. Must be positive.');
    }

    client.accountBalance += amount;

    // تأكد أن save ترجع نجاح قبل تأكيد العملية
    if (save(client) == EnSaveResults.svSucceed) {
      return (
        true,
        'Deposited \$${amount.toStringAsFixed(2)}. New balance: \$${client.accountBalance}',
      );
    }
    return (false, 'System Error: Failed to save transaction.');
  }

  static (bool, String) withdraw(BankClientModelPro client, num amount) {
    if (amount <= 0) return (false, 'Invalid amount.');
    if (amount > client.accountBalance) return (false, 'Insufficient funds!');

    client.accountBalance -= amount;

    if (save(client) == EnSaveResults.svSucceed) {
      return (
        true,
        'Withdrawn \$${amount.toStringAsFixed(2)}. New balance: \$${client.accountBalance}',
      );
    }
    return (false, 'System Error: Failed to save transaction.');
  }

  static (bool success, String message) transfer(
    BankClientModelPro source,
    BankClientModelPro destination,
    num amount,
  ) {
    // التحقق من أن الحسابين مختلفين (لزيادة الأمان)
    if (source.accountNumber == destination.accountNumber) {
      return (false, "Cannot transfer to the same account.");
    }

    var (withdrawOk, withdrawMsg) = withdraw(source, amount);
    if (!withdrawOk) return (false, withdrawMsg);

    var (depositOk, _) = deposit(destination, amount);
    if (depositOk) {
      return (
        true,
        'Transfer of \$${amount} to [${destination.accountNumber}] succeeded.',
      );
    }

    // Rollback
    deposit(source, amount);
    return (false, 'Critical Error during transfer. Money returned to source.');
  }
}
