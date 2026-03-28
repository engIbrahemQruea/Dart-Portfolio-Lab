enum EnMode { emptyMode, updateMode, addNewMode }

enum EnSaveResults {
  svFailedEmptyObject,
  svSucceed,
  svFailedAccountNumberExists,
}

enum EnPermissions {
  eAll(-1),
  pListClients(1),
  pAddNewClient(2),
  pDeleteClient(4),
  pUpdateClients(8),
  pFindClient(16),
  pTransactions(32),
  pManageUsers(64),
  pLogRegisters(128),
  pCurrencyExchange(256);

  final int value;
  const EnPermissions(this.value);

  static bool hasPermission(
    int userPermissions,
    EnPermissions permissionToCheck,
  ) {
    if (userPermissions == EnPermissions.eAll.value) return true;

    return (userPermissions & permissionToCheck.value) ==
        permissionToCheck.value;
  }
}
