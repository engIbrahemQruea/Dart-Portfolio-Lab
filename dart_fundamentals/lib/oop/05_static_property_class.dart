class AppConfig {
  // منع إنشاء كائنات من الكلاس (المكافئ لـ Static Class في C#)
  AppConfig._();

  static String appName = "My Flutter App";
  static const String version = "1.0.0";

  static void logInfo(String msg) {
    print("LOG: $msg");
  }
}

abstract class Settings {
  // لمنع إنشاء كائنات، نجعل الكلاس abstract
  // أو نضع Private Constructor: Settings._();

  static int get dayNumber => DateTime.now().day;

  static String get dayName {
    // ميزة Dart في التعامل مع التواريخ بسيطة جداً
    return DateTime.now().weekday.toString();
  }

  static String projectPath = r"C:\MyProjects\";
}

void main() {
  // AppConfig.appName متاح مباشرة
  // var config = AppConfig(); // خطأ برمجي بفضل الـ Private Constructor

  print(Settings.dayNumber);
  print(Settings.dayName);

  Settings.projectPath = r"D:\FlutterWork\";
  print(Settings.projectPath);
}
