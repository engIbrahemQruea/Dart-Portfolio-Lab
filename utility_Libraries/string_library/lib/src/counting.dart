import 'package:characters/characters.dart';

enum LetterType { small, capital, all }

extension SmartStringCounting on String {
  int get wordCount =>
      trim().isEmpty ? 0 : trim().split(RegExp(r'\s+')).length;

  int countLetters({LetterType type = LetterType.all}) {
    switch (type) {
      case LetterType.all:
        return length;
      case LetterType.capital:
        return characters.where((c) => c == c.toUpperCase() && c != c.toLowerCase()).length;
      case LetterType.small:
        return characters.where((c) => c == c.toLowerCase() && c != c.toUpperCase()).length;
    }
  }

  int countSpecific(String letter, {bool matchCase = true}) {
    if (letter.isEmpty) return 0;

    return characters.where((c) {
      if (matchCase) return c == letter;
      return c.toLowerCase() == letter.toLowerCase();
    }).length;
  }

  int get vowelCount =>
      characters.where((c) => 'aeiou'.contains(c.toLowerCase())).length;
}
