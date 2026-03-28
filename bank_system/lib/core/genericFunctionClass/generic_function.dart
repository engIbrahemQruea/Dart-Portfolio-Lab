// استخدام Extension يجعل الدالة متاحة لكل القوائم في مشروعك
extension ListUtils<T extends Comparable> on List<T> {
  
  // دالة Generic لإيجاد القيمة الكبرى في أي قائمة (أرقام أو نصوص)
  T findMax() {
    if (isEmpty) throw Exception("القائمة فارغة!");
    
    T maxElement = this[0];
    for (var i = 1; i < length; i++) {
      // بفضل 'Comparable' يمكننا استخدام compareTo
      if (this[i].compareTo(maxElement) > 0) {
        maxElement = this[i];
      }
    }
    return maxElement;
  }
}

// void main() {
//   var numbers = [10, 50, 30];
//   var names = ["Ibrahem", "Ahmed", "Zaid"];

//   print("Max Number: ${numbers.findMax()}"); // سيعطي 50
//   print("Max Name: ${names.findMax()}");     // سيعطي Zaid (ترتيب أبجدي)
// }