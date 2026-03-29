// import 'dart:io';

// import 'package:date_library/date_library.dart';

// extension DateModelLogic on DateModel {
//   // --- الأساسيات (Leap Year & Month Days) ---

//   static bool isLeapYear(int year) {
//     return (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);
//   }

//   bool get isLeapYearInstance => isLeapYear(year);

//   static int numberOfDaysInAMonth(int month, int year) {
//     if (month < 1 || month > 12) return 0;
//     List<int> days = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
//     return (month == 2) ? (isLeapYear(year) ? 29 : 28) : days[month - 1];
//   }

//   // --- الحسابات الزمنية (ساعات، دقائق، ثواني) ---

//   int get numberOfDaysInYear => isLeapYearInstance ? 366 : 365;
//   int get hoursInYear => numberOfDaysInYear * 24;
//   int get minutesInYear => hoursInYear * 60;
//   int get secondsInYear => minutesInYear * 60;

//   // --- أسماء الأيام والشهور ---

//   int dayOfWeekOrder() {
//     // خوارزمية Zeller's congruence كما في الكود الأصلي
//     int a = (14 - month) ~/ 12;
//     int y = year - a;
//     int m = month + (12 * a) - 2;
//     return (day + y + (y ~/ 4) - (y ~/ 100) + (y ~/ 400) + ((31 * m) ~/ 12)) %
//         7;
//   }

//   String get dayShortName {
//     return ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"][dayOfWeekOrder()];
//   }


//   DateModel addOneDay() {
//     DateTime next = toDateTime().add(const Duration(days: 1));
//     return DateModel.fromValues(next.day, next.month, next.year);
//   }

//   DateModel increaseByXDays(int days) {
//     DateTime next = toDateTime().add(Duration(days: days));
//     return DateModel.fromValues(next.day, next.month, next.year);
//   }

//   DateModel increaseByOneMonth() {
//     int nextMonth = month == 12 ? 1 : month + 1;
//     int nextYear = month == 12 ? year + 1 : year;
//     int maxDays = numberOfDaysInAMonth(nextMonth, nextYear);
//     int nextDay = day > maxDays ? maxDays : day;
//     return DateModel.fromValues(nextDay, nextMonth, nextYear);
//   }


//   bool isBefore(DateModel other) {
//     if (year < other.year) return true;
//     if (year == other.year && month < other.month) return true;
//     if (year == other.year && month == other.month && day < other.day)
//       return true;
//     return false;
//   }

//   bool isEqual(DateModel other) =>
//       year == other.year && month == other.month && day == other.day;

//   static int getDifferenceInDays(
//     DateModel d1,
//     DateModel d2, {
//     bool includeEndDay = false,
//   }) {
//     int diff = d2.toDateTime().difference(d1.toDateTime()).inDays;
//     return includeEndDay ? diff + 1 : diff;
//   }


//   bool get isWeekend {
//     int order = dayOfWeekOrder();
//     return order == 5 || order == 6; // Fri and Sat
//   }

//   bool get isBusinessDay => !isWeekend;

//   int daysUntilEndOfWeek() => 6 - dayOfWeekOrder();

//   int daysUntilEndOfMonth() {
//     var lastDay = DateModel.fromValues(
//       numberOfDaysInAMonth(month, year),
//       month,
//       year,
//     );
//     return getDifferenceInDays(this, lastDay, includeEndDay: true);
//   }


//   static void printMonthCalendar(int month, int year) {
//     String monthName = [
//       "Jan",
//       "Feb",
//       "Mar",
//       "Apr",
//       "May",
//       "Jun",
//       "Jul",
//       "Aug",
//       "Sep",
//       "Oct",
//       "Nov",
//       "Dec",
//     ][month - 1];
//     print("\n  _______________$monthName_______________\n");
//     print("  Sun  Mon  Tue  Wed  Thu  Fri  Sat");

//     int current = DateModel.fromValues(1, month, year).dayOfWeekOrder();
//     int days = numberOfDaysInAMonth(month, year);

//     String firstLine = "     " * current;
//     stdout.write(firstLine);

//     for (int j = 1, i = current; j <= days; j++) {
//       stdout.write(j.toString().padLeft(5));
//       if (++i == 7) {
//         i = 0;
//         print("");
//       }
//     }
//     print("\n  _________________________________\n");
//   }
// }



// /////////////////////////////////////////

// import 'dart:io';

// import 'package:date_library/date_library.dart';

// extension DateModelLogic on DateModel {
//   // --- الأساسيات (Leap Year & Month Days) ---

//   static bool isLeapYear(int year) {
//     return (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);
//   }

//   bool get isLeapYearInstance => isLeapYear(year);

//   static int numberOfDaysInAMonth(int month, int year) {
//     if (month < 1 || month > 12) return 0;
//     List<int> days = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
//     return (month == 2) ? (isLeapYear(year) ? 29 : 28) : days[month - 1];
//   }

//   // --- الحسابات الزمنية (ساعات، دقائق، ثواني) ---

//   int get numberOfDaysInYear => isLeapYearInstance ? 366 : 365;
//   int get hoursInYear => numberOfDaysInYear * 24;
//   int get minutesInYear => hoursInYear * 60;
//   int get secondsInYear => minutesInYear * 60;

//   // --- أسماء الأيام والشهور ---

//   int dayOfWeekOrder() {
//     // خوارزمية Zeller's congruence كما في الكود الأصلي
//     int a = (14 - month) ~/ 12;
//     int y = year - a;
//     int m = month + (12 * a) - 2;
//     return (day + y + (y ~/ 4) - (y ~/ 100) + (y ~/ 400) + ((31 * m) ~/ 12)) %
//         7;
//   }

//   String get dayShortName {
//     return ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"][dayOfWeekOrder()];
//   }


//   DateModel addOneDay() {
//     DateTime next = toDateTime().add(const Duration(days: 1));
//     return DateModel.fromValues(next.day, next.month, next.year);
//   }

//   DateModel increaseByXDays(int days) {
//     DateTime next = toDateTime().add(Duration(days: days));
//     return DateModel.fromValues(next.day, next.month, next.year);
//   }

//   DateModel increaseByOneMonth() {
//     int nextMonth = month == 12 ? 1 : month + 1;
//     int nextYear = month == 12 ? year + 1 : year;
//     int maxDays = numberOfDaysInAMonth(nextMonth, nextYear);
//     int nextDay = day > maxDays ? maxDays : day;
//     return DateModel.fromValues(nextDay, nextMonth, nextYear);
//   }


//   bool isBefore(DateModel other) {
//     if (year < other.year) return true;
//     if (year == other.year && month < other.month) return true;
//     if (year == other.year && month == other.month && day < other.day)
//       return true;
//     return false;
//   }

//   bool isEqual(DateModel other) =>
//       year == other.year && month == other.month && day == other.day;

//   static int getDifferenceInDays(
//     DateModel d1,
//     DateModel d2, {
//     bool includeEndDay = false,
//   }) {
//     int diff = d2.toDateTime().difference(d1.toDateTime()).inDays;
//     return includeEndDay ? diff + 1 : diff;
//   }


//   bool get isWeekend {
//     int order = dayOfWeekOrder();
//     return order == 5 || order == 6; // Fri and Sat
//   }

//   bool get isBusinessDay => !isWeekend;

//   int daysUntilEndOfWeek() => 6 - dayOfWeekOrder();

//   int daysUntilEndOfMonth() {
//     var lastDay = DateModel.fromValues(
//       numberOfDaysInAMonth(month, year),
//       month,
//       year,
//     );
//     return getDifferenceInDays(this, lastDay, includeEndDay: true);
//   }


//   static void printMonthCalendar(int month, int year) {
//     String monthName = [
//       "Jan",
//       "Feb",
//       "Mar",
//       "Apr",
//       "May",
//       "Jun",
//       "Jul",
//       "Aug",
//       "Sep",
//       "Oct",
//       "Nov",
//       "Dec",
//     ][month - 1];
//     print("\n  _______________$monthName_______________\n");
//     print("  Sun  Mon  Tue  Wed  Thu  Fri  Sat");

//     int current = DateModel.fromValues(1, month, year).dayOfWeekOrder();
//     int days = numberOfDaysInAMonth(month, year);

//     String firstLine = "     " * current;
//     stdout.write(firstLine);

//     for (int j = 1, i = current; j <= days; j++) {
//       stdout.write(j.toString().padLeft(5));
//       if (++i == 7) {
//         i = 0;
//         print("");
//       }
//     }
//     print("\n  _________________________________\n");
//   }
// }
