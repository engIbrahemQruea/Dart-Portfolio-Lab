import 'package:string_library/src/counting.dart';
import 'package:string_library/string_library.dart' as string_library;


void main() {
  String string1 = "Ibrahim Ahmed";
  String string2 = "Ibrahim";

  print("String1 = $string1");
  print("String2 = $string2");

  print("Number of words: ${string1.wordCount}");

  print("Number of words: ${"Osama ahmed rateb omer".wordCount}");

  print("Number of words: ${"Ibrahim ahmed Qurea".wordCount}");

  //---------------------------------

  String string3 = "hi how are you?";

  print("String3 = $string3");

  print("String Length = ${string3.length}");

  print(string3.capitalizeWords);

  print(string3.capitalizeWords.toLowerCase());

  print(string3.upperAll);

  print(string3.lowerAll);

  //---------------------------------

  print("After inverting a: ${"a".invertCase}");

  string3 = "AbCdEfg";

  print(string3.invertCase);
  print(string3.invertCase);

  //---------------------------------

  print("Capital Letters count: ${"Ibrahim Qurea".countLetters(type: LetterType.capital)}");

  string3 = "Welcome to Yemen";

  print("Capital Letters count: ${string3.countLetters(type: LetterType.capital)}");

  print("Small Letters count: ${string3.countLetters(type: LetterType.small)}");

  print("Vowels count: ${string3.vowelCount}");

  print("Letter E count: ${string3.countSpecific("E", matchCase: false)}");

  //---------------------------------

  print("Is 'a' vowel? ${"a".vowelCount == 1}");

  //---------------------------------

  print("Words Count: ${string3.wordCount}");

  //---------------------------------

  final tokens = string3.splitBy(" ");

  print("Tokens = ${tokens.length}");

  for (final s in tokens) {
    print(s);
  }

  //---------------------------------

  string3 = "    Ibrahim AL-Qurea     ";

  print("Original = '$string3'");

  print("Trim Left = '${string3.trimLeftCustom}'");

  print("Trim Right = '${string3.trimRightCustom}'");

  print("Trim = '${string3.trimCustom}'");
  //---------------------------------

  final list = ["Ibrahim", "Ahmed", "Salh", "Qurea"];

  print("Join from List: ${list.join(" ")}");

  //---------------------------------

  string3 = "Ibrahim Ahmed Qurea";

  print("Reverse Words: ${string3.reverseWords}");

  //---------------------------------

  print("Replace: ${string3.replaceWord("Ibrahim", "Osama")}");

  //---------------------------------

  string3 = "This is: a sample text, with punctuations.";

  print("Remove Punctuation: ${string3.removePunctuation}");
}
