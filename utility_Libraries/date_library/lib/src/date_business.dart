import 'cls_date.dart';

extension DateBusiness on ClsDate {
  bool get isWeekend =>
      asDateTime.weekday == DateTime.friday ||
      asDateTime.weekday == DateTime.saturday;

  bool get isBusinessDay => !isWeekend;

  int businessDaysUntil(ClsDate other) {
    if (this == other) return 0;

    ClsDate start = this < other ? this : other;
    ClsDate end = this < other ? other : this;

    int totalDays = end.asDateTime.difference(start.asDateTime).inDays;

    int fullWeeks = totalDays ~/ 7;
    int businessDays = fullWeeks * 5;

    int remaining = totalDays % 7;
    for (int i = 0; i < remaining; i++) {
      final temp = start + (fullWeeks * 7 + i);
      if (temp.isBusinessDay) businessDays++;
    }

    return businessDays;
  }
}
