import 'package:bank_system/models/date_model.dart';

extension DateComparison on DateTime {
  bool operator <=(DateTime other) =>
      isBefore(other) || isAtSameMomentAs(other);
  bool operator >=(DateTime other) => isAfter(other) || isAtSameMomentAs(other);
  bool operator <(DateTime other) => isBefore(other);
  bool operator >(DateTime other) => isAfter(other);

  bool isEqual(DateTime date1, DateTime date2) {
    return date1.isAtSameMomentAs(date2);
  }
}

extension DateOperations on DateModel {
  int get daysFromStartOfYear {
    final startOfYear = DateTime(year, 1, 1);
    final current = DateTime(year, month, day);
    return current.difference(startOfYear).inDays + 1;
  }

  int getDifferenceInDays(DateModel other, {bool includeEndDay = false}) {
    var d1 = DateTime(year, month, day);
    var d2 = DateTime(other.year, other.month, other.day);

    int swapValueFlag = d1.isBefore(d2) ? 1 : -1;

    final duration = d2.difference(d1).abs();
    int days = duration.inDays;

    if (includeEndDay) days++;

    return days * swapValueFlag;
  }

  int calculateMyAgeInDays(DateModel birthDate) {
    return birthDate.getDifferenceInDays(DateModel.toDay());
  }

  DateModel increaseDateByOneWeek(DateModel date) {
    final dateTime = DateTime(
      date.year,
      date.month,
      date.day,
    ).add(Duration(days: 7));
    return DateModel(
      year: dateTime.year,
      month: dateTime.month,
      day: dateTime.day,
    );
  }

  DateModel increaseDateByXWeeks(DateModel date, int weeks) {
    for (int i = 0; i < weeks; i++) {
      date = increaseDateByOneWeek(date);
    }
    return date;
  }

  DateModel increaseDateByOneMonth(DateModel date) {
    int newMonth = date.month + 1;
    int newYear = date.year;

    if (newMonth > 12) {
      newMonth = 1;
      newYear++;
    }

    int daysInNewMonth = newYear.daysInMonth(newMonth);
    int newDay = date.day > daysInNewMonth ? daysInNewMonth : date.day;

    return DateModel(year: newYear, month: newMonth, day: newDay);
  }

 static  bool isValidDate(DateModel date) {
    final dateToCheck = DateTime(date.year, date.month, date.day);
    return dateToCheck.year == date.year &&
        dateToCheck.month == date.month &&
        dateToCheck.day == date.day;
  }

  bool isDate1BeforeDate2(DateModel date1, DateModel date2) {
    final date1DateTime = DateTime(date1.year, date1.month, date1.day);
    final date2DateTime = DateTime(date2.year, date2.month, date2.day);
    return date1DateTime.isBefore(date2DateTime);
  }

  bool isLastDayOfMonth(DateModel date) {
    return date.day == date.month.numberOfDaysInMonth;
  }

  bool isLastMonthOfYear(DateModel date) {
    return date.month == 12;
  }

  DateModel addOneDay(DateModel date) {
    final dateTime = DateTime(
      date.year,
      date.month,
      date.day,
    ).add(Duration(days: 1));
    return DateModel(
      year: dateTime.year,
      month: dateTime.month,
      day: dateTime.day,
    );
  }

  // bool isBetween(DateModel from, DateModel to) {
  //   if (this >= from && this <= to) return true;
  //   if (this >= to && this <= from) return true;
  //   return false;
  // }
}

extension YearChecker on int {
  bool get isLeapYear =>
      (this % 400 == 0) || (this % 4 == 0 && this % 100 != 0);

  int get numberOfDaysInYear => isLeapYear ? 366 : 365;

  int get numberOfHoursInYear => numberOfDaysInYear * 24;
  int get numberOfMinutesInYear => numberOfHoursInYear * 60;
  int get numberOfSecondsInYear => numberOfMinutesInYear * 60;

  int get numberOfDaysInMonth => daysInMonth(this);
  int get numberOfHoursInMonth => numberOfDaysInMonth * 24;
  int get numberOfMinutesInMonth => numberOfHoursInMonth * 60;
  int get numberOfSecondsInMonth => numberOfMinutesInMonth * 60;

  int get dayOfWeekOrder {
    final date = DateTime(this);
    return date.weekday; // 1 (Monday) to 7 (Sunday)
  }

  bool isEndOfWeek() {
    return dayOfWeekOrder == 7; // Sunday
  }

  bool isBeginningOfWeek() {
    return dayOfWeekOrder == 1; // Monday
  }

  bool isWeekend() {
    return dayOfWeekOrder == 6 || dayOfWeekOrder == 7; // Saturday or Sunday
  }

  bool isBusinessDay() {
    return !isWeekend();
  }

  int daysUntilEndOfWeek() {
    return 7 - dayOfWeekOrder;
  }

  int daysUntilEndOfMonth() {
    return daysInMonth(this) - DateTime(this).day;
  }

  int daysUntilEndOfYear() {
    final now = DateTime.now();
    final endOfYear = DateTime(this, 12, 31);
    return endOfYear.difference(now).inDays;
  }

  String get dayShortName {
    const dayNames = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return dayNames[dayOfWeekOrder - 1];
  }

  String monthShortName(int monthNumber) {
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return months[monthNumber - 1];
  }

  int daysInMonth(int month) {
    if (month < 1 || month > 12) {
      throw ArgumentError('Month must be between 1 and 12');
    }

    const days = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
    if (month == 2 && isLeapYear) return 29;
    return days[month - 1];
  }

  DateTime getDateFromDayOrderInYear(int daysOrder) {
    return DateTime(this).add(Duration(days: daysOrder - 1));
  }

  int get daysFromTheBeginingOfYear {
    final now = DateTime.now();
    final startOfYear = DateTime(this, 1, 1);
    return now.difference(startOfYear).inDays + 1;
  }

  DateModel addDays(int days) {
    final date = DateTime(this).add(Duration(days: days));
    return DateModel(year: date.year, month: date.month, day: date.day);
  }
}



extension DateFormatter on DateTime {
  String format(String layout) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];

    final replacements = {
      'dd': day.toString().padLeft(2, '0'),
      'mm': month.toString().padLeft(2, '0'),
      'mmm': months[month - 1],
      'yyyy': year.toString(),
      'yy': year.toString().substring(2),
    };

    final pattern = RegExp(replacements.keys.map(RegExp.escape).join('|'));

    return layout.replaceAllMapped(pattern, (match) {
      return replacements[match.group(0)] ?? match.group(0)!;
    });
  }
}