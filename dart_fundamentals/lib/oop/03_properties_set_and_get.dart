class BankAccount {
  // 1. المتغير الحقيقي (الحقل) يكون خاصاً
  double _balance = 0;

  // 2. الـ Getter: بوابة القراءة
  // نستخدم fat arrow => للاختصار
  double get balance => _balance;

  // 3. الـ Setter: بوابة الكتابة مع التحقق (Validation)
  set balance(double amount) {
    if (amount >= 0) {
      _balance = amount;
    } else {
      print("خطأ: لا يمكن تعيين رصيد بالسالب!");
    }
  }
}


class Employee {
  int _id = 0; // Private field
  String _name = "";

  // Getter (بوابة القراءة)
  int get id => _id;

  // Setter (بوابة الكتابة مع منطق حماية)
  set id(int value) {
    if (value > 0) {
      _id = value;
    } else {
      print("ID must be positive!");
    }
  }

  // ميزة Dart: يمكنك تعريف Getter فقط لجعل الحقل للقراءة فقط من الخارج
  String get name => _name;
  
  set name(String value) => _name = value;
}

void main() {
  var myAcc = BankAccount();
  
  // نستخدمها كأنها متغير عادي (هذا هو السحر!)
  myAcc.balance = 500; // يستدعي الـ Setter
  print(myAcc.balance); // يستدعي الـ Getter
  
  myAcc.balance = -100; // سيطبع رسالة الخطأ ولن يتغير الرصيد
}