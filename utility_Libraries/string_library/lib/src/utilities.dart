extension SmartStringUtilities on String {
  String get removePunctuation =>
      replaceAll(RegExp(r'[^\w\s]'), '');

  bool get isBlank => trim().isEmpty;
}
