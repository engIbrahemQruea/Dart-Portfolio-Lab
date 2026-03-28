// extension DateFormatting on DateTime {
//   String toShortDate() {
//     return "${this.day}/${this.month}/${this.year}";
//   }
// }

extension DateFormatting on DateTime {
  String format12Hour() {
    // 1. تحديد هل الوقت صباحاً أم مساءً
    String period = this.hour >= 12 ? "PM" : "AM";

    // 2. تحويل الساعة من نظام 24 إلى 12
    // إذا كانت الساعة 0 (منتصف الليل) تصبح 12، وإذا كانت > 12 نطرح منها 12
    int hour12 = this.hour % 12;
    hour12 = hour12 == 0 ? 12 : hour12;

    // 3. إضافة "0" قبل الدقائق إذا كانت أقل من 10 (مثلاً 05 بدلاً من 5)
    String minuteStr = this.minute.toString().padLeft(2, '0');

    // 4. دمج كل شيء: التاريخ + الوقت
    return "${this.day}/${this.month}/${this.year} - $hour12:$minuteStr $period";
  }
}