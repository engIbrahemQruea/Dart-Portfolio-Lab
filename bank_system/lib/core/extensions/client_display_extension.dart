import 'package:bank_system/core/enums/mode.dart';
import 'package:bank_system/models/bank_client_model.dart';
import 'package:bank_system/models/bank_user_model.dart';

extension BankClientDisplay on BankClientModel {
  void printCard() {
    print('\n' + '_' * 40);
    print('         CLIENT CARD DETAILS');
    print('_' * 40);
    print('Account Number : $accountNumber');
    print('Full Name      : $fullName');
    print('Current Balance: ${accountBalance.toUSD()})} \$');
    print('_' * 40 + '\n');
  }
}

extension BankUserUI on BankUserModel {
  void showCard() {
    print('\n┌──────────────────────────────────────────┐');
    print('│              USER INFORMATION            │');
    print('├──────────────────────────────────────────┤');
    print('│ Name        : ${firstName.padRight(28)} │');
    print('│ Last Name   : ${lastName.padRight(28)} │');
    print('│ Username    : ${username.padRight(28)} │');
    print('│ Password    : ${password.padRight(28)} │');
    print('│ Permissions : ${permission.toString().padRight(28)} │');
    print('└──────────────────────────────────────────┘\n');
  }
}

extension CurrencyFormatter on num {
  String toUSD() => "\$${this.toStringAsFixed(2)}";
}

extension ConsoleFormat on String {
  void printIndented() => print("${"".padLeft(37)}$this");
}

extension StringLogic on String {
  bool isSameAs(String other) =>
      this.trim().toLowerCase() == other.trim().toLowerCase();

  bool isAdmin() => this.isSameAs('admin');
}

extension PermissionChecker on int {
  bool hasAccess(EnPermissions permission) {
    if (this == EnPermissions.eAll.value) return true;
    return (this & permission.value) == permission.value;
  }
}