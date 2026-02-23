extension SmartStringTrimming on String {
  String get trimLeftCustom => replaceFirst(RegExp(r'^\s+'), '');

  String get trimRightCustom => replaceFirst(RegExp(r'\s+$'), '');

  String get trimCustom => trimLeftCustom.trimRightCustom;
}
