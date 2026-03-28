enum EnCurrencyMode { emptyMode, updateMode }

enum EnCurrenciesMainMenuOptions {
  eListCurrencies(1),
  eFindCurrency(2),
  eUpdateRateCurrency(3),
  eCalculatorCurrency(4),
  eMainMenu(5);

  const EnCurrenciesMainMenuOptions(this.value);
  final int value;

  static EnCurrenciesMainMenuOptions fromInt(int value) {
    return EnCurrenciesMainMenuOptions.values.firstWhere(
      (option) => option.value == value,
      orElse: () => EnCurrenciesMainMenuOptions.eMainMenu,
    );
  }
}
