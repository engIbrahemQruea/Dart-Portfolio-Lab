class ClsDate implements Comparable<ClsDate> {
  final int day;
  final int month;
  final int year;

  DateTime? _cachedDateTime;

  DateTime get _dateTime => _cachedDateTime ??= DateTime(year, month, day);

  DateTime get asDateTime => _dateTime;

  // ================= Constructors =================

  ClsDate({required this.day, required this.month, required this.year}) {
    if (!isValid()) {
      throw ArgumentError("Invalid Date: $day/$month/$year");
    }
  }

  factory ClsDate.now() {
    final now = DateTime.now();
    return ClsDate(day: now.day, month: now.month, year: now.year);
  }

  factory ClsDate.fromString(String sDate) {
    final parts = sDate.split('/');
    return ClsDate(
      day: int.parse(parts[0]),
      month: int.parse(parts[1]),
      year: int.parse(parts[2]),
    );
  }

  static ClsDate? tryParse(String input) {
    try {
      return ClsDate.fromString(input);
    } catch (_) {
      return null;
    }
  }

  factory ClsDate.fromDayOrder(int dayOrder, int year) {
    final first = DateTime(year, 1, 1);
    final date = first.add(Duration(days: dayOrder - 1));
    return ClsDate(day: date.day, month: date.month, year: date.year);
  }

  // ================= Core =================

  static bool isLeapYear(int year) =>
      (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);

  bool get isLeap => isLeapYear(year);

  static int numberOfDaysInAMonth(int month, int year) {
    if (month < 1 || month > 12) return 0;
    const days = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
    return month == 2 ? (isLeapYear(year) ? 29 : 28) : days[month - 1];
  }

  bool isValid() =>
      month >= 1 &&
      month <= 12 &&
      day >= 1 &&
      day <= numberOfDaysInAMonth(month, year);

  // ================= Comparable =================

  @override
  int compareTo(ClsDate other) => _dateTime.compareTo(other._dateTime);

  // ================= Operators =================

  ClsDate operator +(int days) => addDays(this, days);

  int operator -(ClsDate other) => differenceInDays(other, this);

  bool operator <(ClsDate other) => compareTo(other) < 0;

  bool operator >(ClsDate other) => compareTo(other) > 0;

  // ================= Equality =================

  @override
  bool operator ==(Object other) =>
      other is ClsDate &&
      other.day == day &&
      other.month == month &&
      other.year == year;

  @override
  int get hashCode => Object.hash(day, month, year);

  // ================= Static Utilities =================

  static ClsDate addDays(ClsDate date, int days) {
    final dt = date._dateTime.add(Duration(days: days));
    return ClsDate(day: dt.day, month: dt.month, year: dt.year);
  }

  ClsDate addOneDay() => this + 1;

  static int differenceInDays(
    ClsDate d1,
    ClsDate d2, {
    bool includeEndDay = false,
  }) {
    int diff = d1._dateTime.difference(d2._dateTime).inDays;
    if (includeEndDay) diff += 1;
    return diff.abs();
  }

  int differenceInDaysInstance(ClsDate other, {bool includeEndDay = false}) =>
      differenceInDays(this, other, includeEndDay: includeEndDay);

  @override
  String toString() => "$day/$month/$year";
}
