import 'package:bank_system/core/utils/date_helper.dart';

class DateModel {
  final int _day, _month, _year;
  DateModel({required int day, required int month, required int year})
    : _day = day,
      _month = month,
      _year = year;
  int get day => _day;
  int get month => _month;
  int get year => _year;

  DateModel.toDay()
    : _day = DateTime.now().day,
      _month = DateTime.now().month,
      _year = DateTime.now().year;

  factory DateModel.fromString(String dateString) {
    final parts = dateString.split('/');
    return DateModel(
      day: int.parse(parts[0]),
      month: int.parse(parts[1]),
      year: int.parse(parts[2]),
    );
  }

  factory DateModel.fromValues(int day, int month, int year) {
    return DateModel(day: day, month: month, year: year);
  }

  factory DateModel.fromDateOrderInYear(int dayOfYear, int year) {
    final date = year.getDateFromDayOrderInYear(dayOfYear);
    return DateModel.fromValues(date.day, date.month, date.year);
  }

  @override
  String toString() {
    return '$_day/$_month/$_year';
  }
}
