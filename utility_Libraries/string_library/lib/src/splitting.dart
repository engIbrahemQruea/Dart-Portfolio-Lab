extension SmartStringSplitting on String {
  List<String> splitBy(String delimiter) =>
      split(delimiter).where((e) => e.isNotEmpty).toList();

  String get reverseWords =>
      trim()
          .split(RegExp(r'\s+'))
          .reversed
          .join(' ');

  String replaceWord(
    String target,
    String replacement, {
    bool matchCase = true,
  }) {
    final words = split(RegExp(r'\s+'));

    return words.map((word) {
      if (matchCase) {
        return word == target ? replacement : word;
      }
      return word.toLowerCase() == target.toLowerCase()
          ? replacement
          : word;
    }).join(' ');
  }
}
