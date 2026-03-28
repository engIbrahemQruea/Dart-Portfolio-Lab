import 'dart:math';
import '../enums/char_type.dart';

class Util {
  static final Random _random = Random();

  static int randomNumber(int from, int to) {
    return from + _random.nextInt(to - from + 1);
  }

  static String getRandomCharacter(CharType charType) {
    if (charType == CharType.mixChars) {
      charType = CharType.fromInt(randomNumber(1, 3));
    }

    return switch (charType) {
      CharType.smallLetter => String.fromCharCode(randomNumber(97, 122)),
      CharType.capitalLetter => String.fromCharCode(randomNumber(65, 90)),
      CharType.specialCharacter => String.fromCharCode(randomNumber(33, 47)),
      CharType.digit => String.fromCharCode(randomNumber(48, 57)),
      _ => String.fromCharCode(randomNumber(65, 90)),
    };
  }

  static String generateWord(CharType charType, int length) {
    return List.generate(length, (_) => getRandomCharacter(charType)).join();
  }

  static String generateKey([CharType charType = CharType.capitalLetter]) {
    return "${generateWord(charType, 4)}-${generateWord(charType, 4)}-"
           "${generateWord(charType, 4)}-${generateWord(charType, 4)}";
  }

  static void generateKeys(int numberOfKeys, CharType charType) {
    for (int i = 1; i <= numberOfKeys; i++) {
      print("Key [$i] : ${generateKey(charType)}");
    }
  }

  static void fillListWithRandom<T>(List<T> list, int length, T Function() generator) {
    for (int i = 0; i < length; i++) {
      list.add(generator());
    }
  }

  static String tabs(int numberOfTabs) {
    String t = "\t" * numberOfTabs;
    print(t);
    return t;
  }
}