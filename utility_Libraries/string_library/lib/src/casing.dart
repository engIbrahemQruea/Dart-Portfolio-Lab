import 'package:characters/characters.dart';

extension SmartStringCasing on String {
  String get capitalizeWords => trim()
      .split(RegExp(r'\s+'))
      .map(
        (w) => w.isEmpty
            ? w
            : '${w[0].toUpperCase()}${w.substring(1).toLowerCase()}',
      )
      .join(' ');

  String get upperAll => toUpperCase();

  String get lowerAll => toLowerCase();

  String get invertCase => characters
      .map((c) => c == c.toUpperCase() ? c.toLowerCase() : c.toUpperCase())
      .join();
}
