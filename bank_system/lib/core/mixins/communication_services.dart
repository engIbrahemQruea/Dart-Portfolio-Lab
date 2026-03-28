mixin EmailService {
  void sendEmail(String title, String body) {
    print("Sending Email: $title - $body");
  }
}

mixin SmsService {
  void sendSms(String title, String body) {
    print("Sending SMS: $title - $body");
  }
}

mixin FaxService {
  void sendFax(String title, String body) {
    print("Sending Fax: $title - $body");
  }
}
