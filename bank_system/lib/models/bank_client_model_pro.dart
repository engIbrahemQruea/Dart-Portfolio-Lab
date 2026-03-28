import 'package:bank_system/core/enums/mode.dart';

import 'person_model.dart';



class BankClientModelPro extends PersonModel {
  EnMode mode;
  String accountNumber;
  String pinCode;
  num accountBalance;

  BankClientModelPro({
    required super.firstName,
    required super.lastName,
    required super.email,
    required super.phone,
    required this.mode,
    required this.accountNumber,
    required this.pinCode,
    required this.accountBalance,
  });

  bool get getIsEmpty => mode == EnMode.emptyMode;


  factory BankClientModelPro.empty() {
    return BankClientModelPro(
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

  factory BankClientModelPro.addNew(String accountNumber) {
    return BankClientModelPro(
      mode: EnMode.addNewMode,
      accountNumber: accountNumber,
      firstName: '', lastName: '', email: '', phone: '',
      pinCode: '', accountBalance: 0.0,
    );
  }

  factory BankClientModelPro.fromLine(String line, {String sep = "#//#"}) {
    List<String> p = line.split(sep);
    return BankClientModelPro(
      mode: EnMode.updateMode,
      firstName: p[0],
      lastName: p[1],
      email: p[2],
      phone: p[3],
      accountNumber: p[4],
      pinCode: p[5],
      accountBalance: double.parse(p[6]),
    );
  }

  String toLine({String sep = "#//#"}) {
    return [
      firstName,
      lastName,
      email,
      phone,
      accountNumber,
      pinCode,
      accountBalance.toString(),
    ].join(sep);
  }




   void printInfoBankClientPro() {
    print('Client Card: ');
    super.printInfo();
    print('Account Number  : $accountNumber');
    print('Pin Code        : $pinCode');
    print('Account Balance : $accountBalance');
    print('___________________');
  }

}
