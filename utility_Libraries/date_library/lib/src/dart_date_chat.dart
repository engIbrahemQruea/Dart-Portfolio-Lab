// class ClsDate {
//   int day;
//   int month;
//   int year;

//   // ================= Constructors =================

//   ClsDate({int? day, int? month, int? year})
//     : day = day ?? DateTime.now().day,
//       month = month ?? DateTime.now().month,
//       year = year ?? DateTime.now().year;

//   factory ClsDate.fromString(String sDate) {
//     final parts = sDate.split('/');
//     return ClsDate(
//       day: int.parse(parts[0]),
//       month: int.parse(parts[1]),
//       year: int.parse(parts[2]),
//     );
//   }

//   factory ClsDate.fromDayOrder(int dateOrderInYear, int year) {
//     return getDateFromDayOrderInYear(dateOrderInYear, year);
//   }

//   // ================= Basic =================

//   void printDate() => print(dateToString());

//   static ClsDate getSystemDate() => ClsDate();

//   static bool isValidDate(ClsDate date) {
//     if (date.day < 1 || date.day > 31) return false;
//     if (date.month < 1 || date.month > 12) return false;

//     final daysInMonth = numberOfDaysInAMonth(date.month, date.year);
//     return date.day <= daysInMonth;
//   }

//   bool isValid() => isValidDate(this);

//   static String dateToString(ClsDate date) =>
//       "${date.day}/${date.month}/${date.year}";

//   String dateToStringInstance() => dateToString(this);

//   // ================= Leap Year =================

//   static bool isLeapYear(int year) =>
//       (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);

//   bool isLeap() => isLeapYear(year);

//   // ================= Year Calculations =================

//   static int numberOfDaysInAYear(int year) => isLeapYear(year) ? 366 : 365;

//   int numberOfDaysInYear() => numberOfDaysInAYear(year);

//   static int numberOfHoursInAYear(int year) => numberOfDaysInAYear(year) * 24;

//   int numberOfHoursInYear() => numberOfHoursInAYear(year);

//   static int numberOfMinutesInAYear(int year) =>
//       numberOfHoursInAYear(year) * 60;

//   static int numberOfSecondsInAYear(int year) =>
//       numberOfMinutesInAYear(year) * 60;

//   // ================= Month =================

//   static int numberOfDaysInAMonth(int month, int year) {
//     if (month < 1 || month > 12) return 0;
//     const days = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
//     return month == 2 ? (isLeapYear(year) ? 29 : 28) : days[month - 1];
//   }

//   int numberOfDaysInMonth() => numberOfDaysInAMonth(month, year);

//   // ================= Day Of Week =================

//   static int dayOfWeekOrder(int day, int month, int year) {
//     return DateTime(year, month, day).weekday % 7;
//   }

//   int dayOfWeek() => dayOfWeekOrder(day, month, year);

//   static const _dayNames = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];

//   static String dayShortNameFromOrder(int order) => _dayNames[order];

//   String dayShortName() => dayShortNameFromOrder(dayOfWeek());

//   // ================= Add =================

//   static ClsDate addOneDay(ClsDate date) {
//     final dt = DateTime(
//       date.year,
//       date.month,
//       date.day,
//     ).add(const Duration(days: 1));
//     return ClsDate(day: dt.day, month: dt.month, year: dt.year);
//   }

//   void addOneDayInstance() {
//     final newDate = addOneDay(this);
//     day = newDate.day;
//     month = newDate.month;
//     year = newDate.year;
//   }

//   static ClsDate addDays(ClsDate date, int days) {
//     final dt = DateTime(
//       date.year,
//       date.month,
//       date.day,
//     ).add(Duration(days: days));
//     return ClsDate(day: dt.day, month: dt.month, year: dt.year);
//   }

//   // ================= Difference =================

//   static int getDifferenceInDays(
//     ClsDate d1,
//     ClsDate d2, {
//     bool includeEndDay = false,
//   }) {
//     final dt1 = DateTime(d1.year, d1.month, d1.day);
//     final dt2 = DateTime(d2.year, d2.month, d2.day);
//     int diff = dt2.difference(dt1).inDays;
//     if (includeEndDay) diff += 1;
//     return diff;
//   }

//   int differenceInDays(ClsDate other, {bool includeEndDay = false}) =>
//       getDifferenceInDays(this, other, includeEndDay: includeEndDay);

//   // ================= Compare =================

//   static bool isDate1BeforeDate2(ClsDate d1, ClsDate d2) => DateTime(
//     d1.year,
//     d1.month,
//     d1.day,
//   ).isBefore(DateTime(d2.year, d2.month, d2.day));

//   static bool isDate1EqualDate2(ClsDate d1, ClsDate d2) =>
//       d1.day == d2.day && d1.month == d2.month && d1.year == d2.year;

//   static bool isDate1AfterDate2(ClsDate d1, ClsDate d2) =>
//       !isDate1BeforeDate2(d1, d2) && !isDate1EqualDate2(d1, d2);

//   // ================= Business =================

//   static bool isWeekend(ClsDate date) {
//     final w = dayOfWeekOrder(date.day, date.month, date.year);
//     return w == 5 || w == 6;
//   }

//   static bool isBusinessDay(ClsDate date) => !isWeekend(date);

//   static int calculateBusinessDays(ClsDate from, ClsDate to) {
//     int days = 0;
//     var current = from;

//     while (isDate1BeforeDate2(current, to)) {
//       if (isBusinessDay(current)) days++;
//       current = addOneDay(current);
//     }
//     return days;
//   }
// }
