import 'package:bank_system/data_access/repositories/currency_repos.dart';
import 'package:bank_system/models/currency_model.dart';

class CurrencyController {
  static List<CurrencyModel> _currenciesCache = [];

  static void _syncCacheWithFile() {
    _currenciesCache = CurrencyRepos.loadCurrencies();
  }

  static List<CurrencyModel> getCurrenciesList() {
    if (_currenciesCache.isEmpty) {
      _syncCacheWithFile();
    }
    return _currenciesCache;
  }

  static CurrencyModel findCurrencyByCodeORCountry({
    required String currencyCode,
    String countryName = "",
    bool withCountryCheck = false,
  }) {
    return getCurrenciesList().firstWhere(
      (currency) =>
          _isMatch(currency, currencyCode, countryName, withCountryCheck),
      orElse: () => CurrencyModel.empty(),
    );
  }

  static bool _isMatch(
    CurrencyModel c,
    String code,
    String country,
    bool checkCountry,
  ) {
    bool codeMatch =
        c.currencyCode.trim().toLowerCase() == code.trim().toLowerCase();
    bool countryMatch =
        c.country.trim().toLowerCase() == country.trim().toLowerCase();

    // bool cc =
    //     c.currencyCode.trim().toLowerCase() == code.trim().toLowerCase() &&
    //     (!checkCountry ||
    //         c.country.trim().toLowerCase() == country.trim().toLowerCase());

    if (checkCountry) {
      return codeMatch || countryMatch; // يبحث بالاثنين
    }
    return codeMatch;
  }

  static bool isCurrencyExist(String currencyCode) {
    return !findCurrencyByCodeORCountry(
      currencyCode: currencyCode,
      countryName: '',
    ).isEmpty;
  }

  static void updateRate(String code, num newRate) {
    CurrencyModel currency = findCurrencyByCodeORCountry(currencyCode: code);

    if (!currency.isEmpty) {
      CurrencyModel updated = currency.copyWith(rate: newRate);

      CurrencyRepos.updateCurrency(updated);

      _syncCacheWithFile();
    }
  }

  static double calculateExchange(
    CurrencyModel from,
    CurrencyModel to,
    num amount,
  ) {
    if (from.rate == 0 || to.rate == 0) return 0.0;
    if (from.currencyCode == to.currencyCode) return amount.toDouble();
    double amountInUSD = amount / from.rate;

    return double.parse((amountInUSD * to.rate).toStringAsFixed(4));
  }
}
