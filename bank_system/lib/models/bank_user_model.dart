// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:bank_system/core/enums/mode.dart';
import 'package:bank_system/core/extensions/encryption_helper.dart';
import 'package:bank_system/core/utils/constance.dart';
import 'package:bank_system/models/person_model.dart';

class BankUserModel extends PersonModel {
  final EnMode mode;
  final String username;
  final String password;
  final int permission;

  bool get isEmpty => mode == EnMode.emptyMode;

  BankUserModel({
    required super.firstName,
    required super.lastName,
    required super.email,
    required super.phone,
    required this.mode,
    required this.username,
    required this.password,
    required this.permission,
  });
  factory BankUserModel.empty() {
    return BankUserModel(
      mode: EnMode.emptyMode,
      firstName: '',
      lastName: '',
      email: '',
      phone: '',
      username: '',
      password: '',
      permission: 0,
    );
  }

  BankUserModel copyWith({
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    EnMode? mode,
    String? username,
    String? password,
    int? permission,
  }) {
    return BankUserModel(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      mode: mode ?? this.mode,
      username: username ?? this.username,
      password: password ?? this.password,
      permission: permission ?? this.permission,
    );
  }

  factory BankUserModel.getAddNewUser(String username) {
    return BankUserModel(
      mode: EnMode.addNewMode,
      username: username,
      firstName: '',
      lastName: '',
      email: '',
      phone: '',
      password: '',
      permission: 0,
    );
  }

  factory BankUserModel.fromLine(String line, {String sep = "#//#"}) {
    List<String> p = line.split(sep);
    return BankUserModel(
      mode: EnMode.updateMode,
      firstName: p[0],
      lastName: p[1],
      email: p[2],
      phone: p[3],
      username: p[4],
      password: p[5].decryptPass(encryptionKey),
      permission: int.parse(p[6]),
    );
  }

  String toLine({String sep = "#//#"}) {
    return [
      firstName,
      lastName,
      email,
      phone,
      username,
      password.encryptPass(encryptionKey),
      permission,
    ].map((e) => e.toString()).join(sep);
  }
}
