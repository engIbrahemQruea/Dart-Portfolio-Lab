import 'package:bank_system/core/extensions/client_display_extension.dart';
import 'package:bank_system/core/utils/input_scanner.dart';
import 'package:bank_system/models/bank_client_model.dart';
import 'package:bank_system/presentation/screens/main_screen.dart';

class DepositScreen extends MainScreen {
  static void showDeposit() {
    MainScreen.drawScreenHeader("\t Deposit Screen ");
    print('Please enter the account number of the client you want to deposit:');
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
    client.printCard();
    print('Please enter the amount you want to deposit:');
    double amount = InputScanner.readNumber<double>(
      errorMessage: 'invalid amount? amount should be a positive number',
    );
    print('Are you sure you want to deposit $amount to this client y/n?');
    String confirmation = InputScanner.readString(
      errorMessage: 'invalid input',
    );
    if (confirmation.toLowerCase() == 'y') {
      var (result, message) = client.deposit(amount);
      if (result) {
        print(message);
        
      } else {
        print(message);
      }
    } else {
      print('Operation Deposit was cancelled.');
    }
  }

  static void showDepositScreen() => showDeposit();
}
