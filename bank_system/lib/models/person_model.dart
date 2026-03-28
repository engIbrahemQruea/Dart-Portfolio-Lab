class PersonModel {
  String _firstName, _lastName, _email, _phone;

  PersonModel({
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
  }) : _firstName = firstName,
       _lastName = lastName,
       _email = email,
       _phone = phone;

  set setFirstName(String firstName) => _firstName = firstName;
  set setLastName(String lastName) => _lastName = lastName;
  set setEmail(String email) => _email = email;
  set setPhone(String phone) => _phone = phone;

  String get firstName => _firstName;
  String get lastName => _lastName;
  String get email => _email;
  String get phone => _phone;

  String get fullName => '$_firstName $_lastName';

  void printInfo() {
    print('Info:');
    print('___________________');
    print('First name : $_firstName');
    print('Last name  : $_lastName');
    print('Full Name  : $fullName');
    print('Email      : $_email');
    print('Phone      : $_phone');
    print('___________________');
  }
}


// lib/
// ├── models/
// │   ├── bank_client_model.dart
// │   └── bank_user_model.dart             <-- (Lesson 18)
// ├── business_logic/
// │   ├── bank_client_controller.dart
// │   └── bank_user_controller.dart        <-- الكنترولر الخاص بالمستخدمين
// ├── data_access/
// │   ├── repositories/
// │   │   ├── client_repository.dart
// │   │   └── user_repository.dart         <-- المسؤول عن ملف Users.txt
// ├── presentation/
// │   └── screens/
// │       ├── main_menu_screen.dart
// │       ├── transactions/
// │       └── manage_users/                <-- (Lesson 17) مجلد إدارة المستخدمين
// │           ├── manage_users_menu_screen.dart
// │           ├── list_users_screen.dart    <-- (Lesson 19)
// │           ├── add_user_screen.dart      <-- (Lesson 20)
// │           ├── delete_user_screen.dart   <-- (Lesson 21)
// │           ├── update_user_screen.dart   <-- (Lesson 22)
// │           └── find_user_screen.dart     <-- (Lesson 23)




// lib/
// ├── core/
// │   └── global/
// │       └── global_vars.dart             <-- (Lesson 24) لتخزين المستخدم الحالي (CurrentUser)
// ├── business_logic/
// │   └── auth_controller.dart             <-- (جديد) مسؤول عن الـ Login والتحقق من الصلاحيات
// ├── presentation/
// │   └── screens/
// │       ├── login/                       <-- مجلد جديد
// │       │   └── login_screen.dart        <-- (Lesson 24 & 26)
// │       ├── main_menu_screen.dart        <-- (Lesson 27) تعديله لإخفاء الخيارات بناءً على الصلاحية
// │       └── ...