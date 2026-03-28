class LoginRecordModel {
  final String username;
  final String status;
  final String dateTime;
  final String password;
  final int permissions;

  LoginRecordModel({
    required this.username,
    required this.status,
    required this.dateTime,
    required this.password,
    required this.permissions,
  });


  factory LoginRecordModel.fromLine(String line, {String sep = "#//#"}) {
    List<String> data = line.split(sep);
    return LoginRecordModel(
      username: data[0].trim(),
      status: data[1].trim(),
      dateTime: data[2].trim(),
      password: data[3].trim(),
      permissions: int.parse(data[4].trim()),
    );
  }

  String toLine({String sep = "#//#"}) {
    return [
      username,
      status,
      dateTime,
      password,
      permissions.toString(),
    ].join(sep);
  }
}
