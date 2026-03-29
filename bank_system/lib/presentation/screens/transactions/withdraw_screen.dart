import 'package:bank_system/core/extensions/client_display_extension.dart';
import 'package:bank_system/core/utils/input_scanner.dart';
import 'package:bank_system/models/bank_client_model.dart';
import 'package:bank_system/presentation/screens/main_screen.dart';

class WithdrawScreen extends MainScreen {
  static void showWithdraw() {
    MainScreen.drawScreenHeader("\t  Withdraw Screen");
    print('Please enter the account number or pin code:');
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
    client.printCard();
    print('Please enter the amount you want to withdraw:');
    double amount = InputScanner.readNumber<double>(
      errorMessage: 'invalid amount',
    );
    print('Are you sure you want to withdraw $amount from this client y/n?');
    String confirmation = InputScanner.readString(
      errorMessage: 'invalid input',
    );
    if (confirmation.toLowerCase() == 'y') {
      var (result, message) = client.withdraw(amount);
      if (result) {
    print(message);
      } else {
        print(message);
      }
    } else {
      print('Operation Withdraw was cancelled.');
    }
  }

  static void showWithdrawScreen() =>
      showWithdraw(); // Call the method to display the Withdraw screen
}
