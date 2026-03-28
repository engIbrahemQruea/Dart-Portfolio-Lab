import 'package:bank_system/bank_system.dart';
import 'package:bank_system/bank_system_pro.dart';
import 'package:bank_system/business_logic/auth_controller.dart';
import 'package:bank_system/business_logic/bank_client_controller.dart';
import 'package:bank_system/core/enums/users_menu_options.dart';
import 'package:bank_system/core/extensions/encryption_helper.dart';
import 'package:bank_system/core/global/global_vars.dart';
import 'package:bank_system/models/bank_client_model.dart';
import 'package:bank_system/models/bank_client_model_pro.dart';
import 'package:bank_system/presentation/screens/login/login_screen.dart';
import 'package:bank_system/presentation/screens/main_menu_screen.dart';

void main() {
  // BankClientController.findBankClientByAccountNumber('A104').printInfoBankClientPro();
  // BankClientController.findBankClientByAccountNumberAndPinCode('A102', '1234').printInfoBankClientPro();
  // print('Is Client Exist? ${BankClientController.isClientExist('A101')}');

  //  updateClient();
  // addNewClient();
  // addNewClientPro();
  //deleteClient();
  // deleteClientPro();
  //showClientsList();
  // showTotalBalances();
  //MainMenuScreen.showMainMenu();
  const String myKey = "IbrahimQureaBankKey#2026";
  const String originalPass = "123456";

  print("--- اختبار نظام التشفير الجديد ---");
  print("كلمة المرور الأصلية: $originalPass");

  // 2. تجربة التشفير
  String encrypted = originalPass.encryptPass(myKey);
  print("النص بعد التشفير (في الملف): $encrypted");

  // 3. تجربة فك التشفير
  String decrypted = encrypted.decryptPass(myKey);
  print("النص بعد فك التشفير: $decrypted");

  // 4. التحقق المنطقي
  if (originalPass == decrypted) {
    print("✅ النتيجة: النظام يعمل بنجاح! التطابق 100%.");
  } else {
    print("❌ النتيجة: هناك خطأ في المعادلة، النصوص لا تتطابق.");
  }
  while (true) {
    LoginScreen.showLoginScreen();
    if (currentUser.isEmpty) {
      break;
    }
    AuthController.registerLogIn(EnLogStatus.login);
    MainMenuScreen.showMainMenu();
  }
}
