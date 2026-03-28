import 'package:bank_system/core/enums/mode.dart';
import 'package:bank_system/data_access/repositories/user_repository.dart';
import 'package:bank_system/models/bank_user_model.dart';

class BankUserController {
  static List<BankUserModel> _usersCache = [];

  static void _syncCacheWithFile() {
    _usersCache = UserRepository.loadUsers();
  }

  static List<BankUserModel> getUsersList() {
    if (_usersCache.isEmpty) {
      _syncCacheWithFile();
    }
    return _usersCache;
  }

  static BankUserModel find({
    required String username,
    String password = '',
    bool withPasswordCheck = false,
  }) {
    final users = UserRepository.loadUsers();
    return users.firstWhere(
      (user) => _isMatch(user, username, password, withPasswordCheck),
      orElse: () => BankUserModel.empty(),
    );
  }

  static bool _isMatch(
    BankUserModel u,
    String name,
    String pass,
    bool checkPass,
  ) {
    bool nameMatch =
        u.username.trim().toLowerCase() == name.trim().toLowerCase();
    if (!nameMatch) return false;
    if (checkPass) return u.password == pass;
    return true;
  }

  static bool isUserExist(String username) {
    return !find(username: username).isEmpty;
  }

  static EnSaveResults save(BankUserModel user) {
    switch (user.mode) {
      case EnMode.emptyMode:
        return EnSaveResults.svFailedEmptyObject;
      case EnMode.updateMode:
        _update(user);
        return EnSaveResults.svSucceed;
      case EnMode.addNewMode:
        if (isUserExist(user.username)) {
          return EnSaveResults.svFailedAccountNumberExists;
        } else {
          UserRepository.addUser(user);
          var newMode = EnMode.updateMode;
          user = user.copyWith(mode: newMode);
          return EnSaveResults.svSucceed;
        }
    }
  }

  static void _update(BankUserModel user) {
    final users = UserRepository.loadUsers();
    int index = users.indexWhere(
      (u) => u.username.toLowerCase() == user.username.toLowerCase(),
    );
    if (index != -1) {
      users[index] = user;
      UserRepository.updateSpecificUser(user);
    }
  }

  static void updateCashedUser(BankUserModel user) {
    BankUserModel existingUser = find(username: user.username);
    if (!existingUser.isEmpty) {
      BankUserModel updatedUser = existingUser.copyWith(
        firstName: user.firstName,
        lastName: user.lastName,
        email: user.email,
        phone: user.phone,
        password: user.password,
        permission: user.permission,
      );
      UserRepository.updateSpecificUser(updatedUser);
      _syncCacheWithFile();
    }
  }

  static bool delete(String username) {
    final users = UserRepository.loadUsers();
    int initialLength = users.length;
    users.removeWhere(
      (u) => u.username.toLowerCase() == username.toLowerCase(),
    );

    if (users.length < initialLength) {
      UserRepository.saveUsers(users);
      return true;
    }
    return false;
  }
}
