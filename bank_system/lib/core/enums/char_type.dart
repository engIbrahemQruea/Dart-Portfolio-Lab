enum CharType {
  smallLetter,
  capitalLetter,
  digit,
  mixChars,
  specialCharacter;

  static CharType fromInt(int value) {
    return CharType.values[value - 1];
  }
}