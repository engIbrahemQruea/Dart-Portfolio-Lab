import 'dart:io';
import 'validation_utils.dart';

class InputScanner {
  static T readNumber<T extends num>({required String errorMessage}) {
    while (true) {
      String? input = stdin.readLineSync();
      num? parsed = num.tryParse(input ?? "");

      if (parsed != null && parsed is T) {
        return parsed as T;
      }
      stdout.write(errorMessage);
    }
  }

  static T readNumberBetween<T extends num>(
    T from,
    T to, {
    String errorMessage = "Out of range, try again: ",
  }) {
    T number = readNumber<T>(errorMessage: "Invalid input, try again: ");
    while (!number.isBetween(from, to)) {
      stdout.write(errorMessage);
      number = readNumber<T>(errorMessage: "Invalid input, try again: ");
    }
    return number;
  }

  static String readString({required String errorMessage}) {
    while (true) {
      String? input = stdin.readLineSync();
      if (input != null && input.trim().isNotEmpty) {
        return input;
      }
      stdout.write(errorMessage);
    }
  }
}
