import 'dart:convert'; // ضروري لتحويل الـ Base64

extension EncryptionTool on String {
  String encryptPass(String key) {
    List<int> result = [];
    List<int> textCodes = utf8.encode(this); // تحويل النص لـ Bytes بأمان
    List<int> keyCodes = utf8.encode(key);

    for (int i = 0; i < textCodes.length; i++) {
      int encryptedByte = (textCodes[i] + keyCodes[i % keyCodes.length]) % 256;
      result.add(encryptedByte);
    }
    // تحويل الـ Bytes إلى نص Base64 آمن للطباعة والتخزين
    return base64.encode(result);
  }

  String decryptPass(String key) {
    // تحويل نص الـ Base64 لـ Bytes أولاً
    List<int> textCodes = base64.decode(this);
    List<int> keyCodes = utf8.encode(key);
    List<int> result = [];

    for (int i = 0; i < textCodes.length; i++) {
      int decryptedByte =
          (textCodes[i] - keyCodes[i % keyCodes.length] + 256) % 256;
      result.add(decryptedByte);
    }
    return utf8.decode(result);
  }
}
