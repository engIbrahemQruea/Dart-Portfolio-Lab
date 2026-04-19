class MyClass {
  int x1 = 0; // Instance variable
  static int x2 = 0; // Static variable

  // Instance Method: ترى الجميع
  int method1() {
    return x1 + x2; 
  }

  // Static Method: لا ترى إلا الـ static
  static int method2() {
    // return x1; // خطأ برمجي Compilation Error
    return x2;
  }
}

void main() {
  var obj = MyClass();
  obj.x1 = 10;
  
  // الوصول للـ static يكون باسم الكلاس حصراً
  MyClass.x2 = 100; 
  
  print(obj.method1()); // 110
  print(MyClass.method2()); // 100
}