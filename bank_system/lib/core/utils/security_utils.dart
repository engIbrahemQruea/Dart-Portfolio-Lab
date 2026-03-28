
extension StringSecurity on String {
  String encrypt(int encryptionKey) {
    return String.fromCharCodes(codeUnits.map((c) => c + encryptionKey));
  }

  String decrypt(int encryptionKey) {
    return String.fromCharCodes(codeUnits.map((c) => c - encryptionKey));
  }
}

