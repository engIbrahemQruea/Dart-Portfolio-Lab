import 'dart:io';

class DateModel {
  int _day;
  int _month;
  int _year;

  DateModel._(this._day, this._month, this._year);

  DateModel()
    : _day = DateTime.now().day,
      _month = DateTime.now().month,
      _year = DateTime.now().year;

  factory DateModel.fromValues(int day, int month, int year) {
    return DateModel._(day, month, year);
  }
  factory DateModel.fromString(String sDate) {
    List<String> vDate = sDate.split('/');
    return DateModel.fromValues(
      int.parse(vDate[0]),
      int.parse(vDate[1]),
      int.parse(vDate[2]),
    );
  }

  factory DateModel.fromDayOrder(int dateOrderInYear, int year) {
    DateTime date = DateTime(year).add(Duration(days: dateOrderInYear - 1));
    return DateModel.fromValues(date.day, date.month, date.year);
  }

  set setDay(int day) => _day = day;
  set setMonth(int month) => _month = month;
  set setYear(int year) => _year = year;

  int get getDay => _day;
  int get getMonth => _month;
  int get getYear => _year;

  void printDate() => print(toString());

  @override
  String toString() => "$_day/$_month/$_year";

  DateTime toDateTime() => DateTime(_year, _month, _day);

  static DateModel getSystemDate() {
    final now = DateTime.now();
    return DateModel.fromValues(now.day, now.month, now.year);
  }

  static bool isValidDate(int day, int month, int year) {
    final date = DateTime(year, month, day);

    return (date.year == year && date.month == month && date.day == day);
  }

  bool isValid() => isValidDate(_day, _month, _year);

  static bool isLeapYearStatic(int year) => DateTime(year, 2, 29).month == 2;
  //=> (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);

  bool get isLeapYear => isLeapYearStatic(_year);

  static int numberOfDaysInYearStatic(int year) =>
      isLeapYearStatic(year) ? 366 : 365;

  int get numberOfDaysInYear => numberOfDaysInYearStatic(_year);

  static int numberOfHoursInYearStatic(int year) =>
      numberOfDaysInYearStatic(year) * 24;
  int get numberOfHoursInYear => numberOfHoursInYearStatic(_year);

  static int numberOfMinutesInYearStatic(int year) =>
      numberOfHoursInYearStatic(year) * 60;
  int get numberOfMinutesInYear => numberOfMinutesInYearStatic(_year);

  static int numberOfSecondsInYearStatic(int year) =>
      numberOfMinutesInYearStatic(year) * 60;
  int get numberOfSecondsInYear => numberOfSecondsInYearStatic(_year);

  static int numberOfDaysInAMonthStatic(int month, int year) {
    const List<int> daysPerMonth = [
      31,
      28,
      31,
      30,
      31,
      30,
      31,
      31,
      30,
      31,
      30,
      31,
    ];
    if (month < 1 || month > 12) return 0;
    if (month == 2 && isLeapYearStatic(year)) return 29;

    return daysPerMonth[month - 1];
  }

  int get numberOfDaysInAMonth => numberOfDaysInAMonthStatic(_month, _year);

  static int numberOfHoursInAMonthStatic(int month, int year) =>
      numberOfDaysInAMonthStatic(month, year) * 24;
  int get numberOfHoursInAMonth => numberOfHoursInAMonthStatic(_month, _year);

  static int numberOfMinutesInAMonthStatic(int month, int year) =>
      numberOfHoursInAMonthStatic(month, year) * 60;
  int get numberOfMinutesInAMonth =>
      numberOfMinutesInAMonthStatic(_month, _year);

  static int numberOfSecondsInAMonthStatic(int month, int year) =>
      numberOfMinutesInAMonthStatic(month, year) * 60;
  int get numberOfSecondsInAMonth =>
      numberOfSecondsInAMonthStatic(_month, _year);

  static int dayOfWeekOrderStatic(int day, int month, int year) {
    int a = (14 - month) ~/ 12;
    int y = year - a;
    int m = month + (12 * a) - 2;
    return (day + y + (y ~/ 4) - (y ~/ 100) + (y ~/ 400) + ((31 * m) ~/ 12)) %
        7;
  }

  int get dayOfWeekOrder => dayOfWeekOrderStatic(_day, _month, _year);

  static String dayShortNameStatic(int dayOfWeekOrder) {
    const List<String> days = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];
    return days[dayOfWeekOrder];
  }

  static String dayShortNameStaticParameter(int day, int month, int year) {
    const List<String> days = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];
    return days[dayOfWeekOrderStatic(day, month, year)];
  }

  String get dayShortName => dayShortNameStatic(dayOfWeekOrder);

  static String monthShortNameStatic(int month) {
    const List<String> months = [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec",
    ];
    return months[month - 1];
  }

  String get monthShortName => monthShortNameStatic(_month);

  static void printMonthCalendarStatic(int month, int year) {
    final firstDayOrder = dayOfWeekOrderStatic(year, month, 1);
    final totalDays = numberOfDaysInAMonthStatic(month, year);

    print(
      '\n  _______________ ${monthShortNameStatic(month)} $year _______________',
    );
    print('  Sun  Mon  Tue  Wed  Thu  Fri  Sat');

    print('');

    int i;
    for (i = 0; i < firstDayOrder; i++) {
      stdout.write("     ");
    }

    for (int j = 1; j <= totalDays; j++) {
      stdout.write(j.toString().padLeft(5));
      if (++i == 7) {
        i = 0;
        print('');
      }
    }
    print('\n  _________________________________\n');
  }

  void get printMonthCalendar => printMonthCalendarStatic(_month, _year);

  static void printHaderYear(int year) {
    print('=' * 35);
    print('\t  Calendar = $year');
    print('=' * 35);
  }

  static void printYearCalendarStatic(int year) {
    printHaderYear(year);
    for (int i = 1; i <= 12; i++) {
      printMonthCalendarStatic(i, year);
    }
  }

  void get printYearCalendar => printYearCalendarStatic(_year);

  static int daysFromTheBeginingOfYearStatic(int day, int month, int year) {
    int previousMonthsDays = Iterable<int>.generate(
      month - 1,
      (i) => i + 1,
    ).fold(0, (sum, m) => sum + numberOfDaysInAMonthStatic(month, year));

    return previousMonthsDays + day;
  }

  int get daysFromTheBeginingOfYear {
    int previousMonthsDays = Iterable<int>.generate(
      _month - 1,
      (i) => i + 1,
    ).fold(0, (sum, m) => sum + numberOfDaysInAMonthStatic(_month, _year));

    return previousMonthsDays + _day;
  }

  static DateTime getDateFromDayOrderInYearStatic(
    int dateOrderInYear,
    int year,
  ) {
    return DateTime(year).add(Duration(days: dateOrderInYear - 1));
  }

  DateTime get getDateFromDayOrderInYear =>
      getDateFromDayOrderInYearStatic(daysFromTheBeginingOfYear, _year);

  void addDays(int days) {
    final newDate = getDateFromDayOrderInYear.add(Duration(days: days));
    _day = newDate.day;
    _month = newDate.month;
    _year = newDate.year;
  }

  static bool isDate1BeforeDate2Static(DateModel d1, DateModel d2) =>
      d1.toDateTime().isBefore(d2.toDateTime());

  bool isDate1BeforeDate2(DateModel other) =>
      isDate1BeforeDate2Static(this, other);

  static bool isDate1EqualDate2Static(DateModel d1, DateModel d2) =>
      d1._day == d2._day && d1._month == d2._month && d1._year == d2._year;
  bool isDate1EqualDate2(DateModel other) =>
      isDate1EqualDate2Static(this, other);

  static bool isLastDayOfMonthStatic(DateModel date) =>
      date._day == numberOfDaysInAMonthStatic(date._month, date._year);

  bool get isLastDayOfMonth => isLastDayOfMonthStatic(this);

  static bool isLastMonthOfYearStatic(DateModel date) => date._month == 12;

  static DateModel addOneDayStatic(DateModel date) {
    final newDate = date.getDateFromDayOrderInYear.add(const Duration(days: 1));
    return DateModel.fromValues(newDate.day, newDate.month, newDate.year);
  }

  void addOneDay() {
    final newDate = getDateFromDayOrderInYear.add(const Duration(days: 1));
    _day = newDate.day;
    _month = newDate.month;
    _year = newDate.year;
  }

  static void swapDates(DateModel d1, DateModel d2) {
    int tempDay = d1._day;
    int tempMonth = d1._month;
    int tempYear = d1._year;

    d1._day = d2._day;
    d1._month = d2._month;
    d1._year = d2._year;

    d2._day = tempDay;
    d2._month = tempMonth;
    d2._year = tempYear;
  }

  static int getDifferenceInDaysStatic(
    DateModel d1,
    DateModel d2, {
    bool includeEndDay = false,
  }) {
    int diff = d2.toDateTime().difference(d1.toDateTime()).inDays;
    return includeEndDay ? diff + 1 : diff;
  }

  int getDifferenceInDays(DateModel other, {bool includeEndDay = false}) =>
      getDifferenceInDaysStatic(this, other, includeEndDay: includeEndDay);

  static int calculateMyAgeInDays(DateModel birthDate) {
    final today = DateModel.getSystemDate();
    return getDifferenceInDaysStatic(birthDate, today);
  }

  static DateModel increaseDateByOneWeekStatic(DateModel date) {
    final newDate = date.getDateFromDayOrderInYear.add(const Duration(days: 7));
    return DateModel.fromValues(newDate.day, newDate.month, newDate.year);
  }

  void increaseDateByOneWeek() {
    final newDate = getDateFromDayOrderInYear.add(const Duration(days: 7));
    _day = newDate.day;
    _month = newDate.month;
    _year = newDate.year;
  }

  DateModel increaseDateByXWeeks(int weeks) {
    final newDate = getDateFromDayOrderInYear.add(Duration(days: weeks * 7));
    return DateModel.fromValues(newDate.day, newDate.month, newDate.year);
  }

  void increaseDateByXWeeksInstance(int weeks) {
    final newDate = getDateFromDayOrderInYear.add(Duration(days: weeks * 7));
    _day = newDate.day;
    _month = newDate.month;
    _year = newDate.year;
  }

  DateModel increaseDateByOneMonth(DateModel date) {
    int nextMonth = date._month == 12 ? 1 : date._month + 1;
    int nextYear = date._month == 12 ? date._year + 1 : date._year;
    int maxDays = numberOfDaysInAMonthStatic(nextMonth, nextYear);
    int nextDay = date._day > maxDays ? maxDays : date._day;
    return DateModel.fromValues(nextDay, nextMonth, nextYear);
  }

  void increaseDateByOneMonthInstance() => increaseDateByOneMonth(this);
}
