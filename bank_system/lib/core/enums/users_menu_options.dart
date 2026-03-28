enum ManageUsersMenuOptions {
  listUsers(1),
  addUser(2),
  deleteUser(3),
  updateUser(4),
  findUser(5),
  showMainMenu(6);

  final int value;

  const ManageUsersMenuOptions(this.value);

  static ManageUsersMenuOptions fromInt(int value) {
    return ManageUsersMenuOptions.values.firstWhere(
      (option) => option.value == value,
      orElse: () => ManageUsersMenuOptions.showMainMenu,
    );
  }
}

enum EnLogStatus {
  login("Login"),
  logout("Logout"),
  addedUser("Added User"),
  deletedUser("Deleted User"),
  updatedUser("Updated User"),
  logsLoaded("Logs Loaded");

  final String title;
  const EnLogStatus(this.title);
}