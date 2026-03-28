import 'dart:math';

enum CharType { smallLetter, capitalLetter, digit, mixChars, specialCharacter }

class UtilHelper {
  static final Random _random = Random();

  // توليد رقم عشوائي
  static int randomNumber(int from, int to) =>
      from + _random.nextInt(to - from + 1);

  // دالة Swap "ذكية" باستخدام Generics <T>
  // في Dart، التبديل يتم داخل القوائم لأن المتغيرات العادية تمرر بالـ Value
  static void swap<T>(List<T> list, int index1, int index2) {
    T temp = list[index1];
    list[index1] = list[index2];
    list[index2] = temp;
  }

  // دالة ShuffleArray عامة تعمل مع أي نوع (أرقام، نصوص، كائنات)
  static void shuffleArray<T>(List<T> list) {
    for (int i = 0; i < list.length; i++) {
      swap(
        list,
        randomNumber(0, list.length - 1),
        randomNumber(0, list.length - 1),
      );
    }
  }

  // دالة التعبئة العشوائية العامة (Template Function)
  // هذه الدالة تعوض كل دوال FillArray المكررة في C++
  static List<T> fillArray<T>(int length, T Function() generator) {
    return List.generate(length, (index) => generator());
  }

  // منطق توليد الحروف (كما هو في كود المدرب)
  static String getRandomCharacter(CharType type) {
    var currentType = type;
    if (type == CharType.mixChars) {
      currentType = CharType.values[randomNumber(0, 2)];
    }

    switch (currentType) {
      case CharType.smallLetter:
        return String.fromCharCode(randomNumber(97, 122));
      case CharType.capitalLetter:
        return String.fromCharCode(randomNumber(65, 90));
      case CharType.specialCharacter:
        return String.fromCharCode(randomNumber(33, 47));
      case CharType.digit:
        return String.fromCharCode(randomNumber(48, 57));
      default:
        return String.fromCharCode(randomNumber(65, 90));
    }
  }

  static String generateWord(CharType type, int length) {
    return List.generate(length, (_) => getRandomCharacter(type)).join();
  }

  // تشفير النص (Encryption)
  static String encryptText(String text, int key) {
    return String.fromCharCodes(text.runes.map((r) => r + key));
  }

  static String decryptText(String text, int key) {
    return String.fromCharCodes(text.runes.map((r) => r - key));
  }
}
