import 'cls_date.dart';

extension DateFormatting on ClsDate {
  String get iso =>
      "${year.toString().padLeft(4, '0')}-"
      "${month.toString().padLeft(2, '0')}-"
      "${day.toString().padLeft(2, '0')}";

  (int, int, int) get asRecord =>
      (day, month, year);
}
