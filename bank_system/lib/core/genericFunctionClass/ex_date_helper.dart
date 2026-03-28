class MyDate implements Comparable<MyDate> {
  int day;
  int month;
  int year;

  // Constructor افتراضي (تاريخ النظام اليوم)
  MyDate() : 
    day = DateTime.now().day,
    month = DateTime.now().month,
    year = DateTime.now().year;

  MyDate.all(this.day, this.month, this.year);

  // 1. استخدام الـ Generics في دالة التبديل (Swap)
  // كما تعلمنا، نستخدم قائمة لتمكين التبديل في Dart
  static void swap<T>(List<T> items, int index1, int index2) {
    T temp = items[index1];
    items[index1] = items[index2];
    items[index2] = temp;
  }

  // 2. تطبيق الـ Comparable (الذي هو نوع من الـ Generics)
  // هذا يسمح لنا بمقارنة التواريخ باستخدام > و < و == لاحقاً
  @override
  int compareTo(MyDate other) {
    if (year != other.year) return year.compareTo(other.year);
    if (month != other.month) return month.compareTo(other.month);
    return day.compareTo(other.day);
  }

  // منطق السنة الكبيسة (Static)
  static bool isLeapYear(int year) {
    return (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);
  }

  // عدد الأيام في الشهر
  static int numberOfDaysInMonth(int month, int year) {
    List<int> days = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
    return (month == 2 && isLeapYear(year)) ? 29 : days[month - 1];
  }

  // إضافة يوم واحد (المنطق الذي يحبه أبو هدهود)
  void addOneDay() {
    if (day == numberOfDaysInMonth(month, year)) {
      if (month == 12) {
        month = 1;
        day = 1;
        year++;
      } else {
        month++;
        day = 1;
      }
    } else {
      day++;
    }
  }

  @override
  String toString() => "$day/$month/$year";
}

// دالة عامة تقارن أي شيئين (تواريخ، أرقام، نصوص)
T getMax<T extends Comparable>(T item1, T item2) {
  return (item1.compareTo(item2) > 0) ? item1 : item2;
}

// void main() {
//   MyDate date1 = MyDate.all(1, 1, 2026);
//   MyDate date2 = MyDate.all(1, 1, 2025);

//   // استخدام الدالة العامة للمقارنة بين التواريخ!
//   MyDate older = getMax(date1, date2);
//   print("التاريخ الأحدث هو: $older");
// }