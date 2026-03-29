import 'package:date_library/date_library.dart';

extension DateModelLogic on DateModel {
  bool get isLeapYearStatic {
    final date = DateTime(this.getYear, 2, 29);
    return date.month == 2;

    //return (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);
  }

  bool get isLeapYear => isLeapYearStatic;

  int numberOfDaysInYear(int year) => isLeapYear ? 366 : 365;
}
