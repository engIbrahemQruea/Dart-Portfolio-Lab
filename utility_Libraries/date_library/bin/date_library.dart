import 'package:date_library/date_library.dart';

void main() {
  // final date1 = DateModel();
  // date1.printDate();
  // final date2 = DateModel.fromString('31/1/2022');
  // date2.printDate();
  // final date3 = DateModel.fromValues(3000, 1, 2025);
  // date3.printDate();
  // final date4 = DateModel.fromDayOrder(250, 2022);
  // date4.printDate();

  // print(DateModel.getDateFromDayOrderInYearStatic(250, 2025));
  // print(date3.getDateFromDayOrderInYear);


    final d1 = ClsDate(day: 31, month: 1, year: 2024);
  final d2 = ClsDate.fromString("10/2/2024");

  print(d1 + 5);
  print(d2 - d1);

  print(d1 < d2);

  print(d1.iso);

  final (day, month, year) = d1.asRecord;
  print("$day-$month-$year");

  print(d1.businessDaysUntil(d2));
}
