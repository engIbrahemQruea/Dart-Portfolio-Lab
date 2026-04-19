class Employee {
  // 1. استخدام final مع متغير public (الطريقة الأسرع)
  // دارت ستنشئ له Getter تلقائياً وتمنع الـ Setter
  final int id; 
  
  String _name = "";

  Employee(this.id);

  // 2. الطريقة الكلاسيكية (Getter Only)
  // نستخدمها إذا أردنا معالجة القيمة قبل إرجاعها
  String get name => _name;

  set name(String value) => _name = value;
}

void main() {
  var emp = Employee(101);
  
  // emp.id = 202; // خطأ: المتغير نهائي (ReadOnly)
  print(emp.id); // مسموح: قراءة فقط
}