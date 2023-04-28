import 'package:intl/intl.dart';

class Currencies {
  static String selectedCurrency = 'USD';
  static const Map<String, String> _currencySymbols = {
    'USD': '\$',
    'EUR': '€',
    'RUB': '₽',
    'UAH': '₴',
  };

  static const _apiEndpoint = 'https://api.exchangeratesapi.io/latest';

  static double convert(double amount) {
    // Hardcoded exchange rate values for EUR, USD, RUB, and UAH
    final exchangeRates = {
      'EUR': 0.85,
      'USD': 1.0,
      'RUB': 74.17,
      'UAH': 27.5,
    };

    // Convert the amount to the target currency
    final exchangeRate = exchangeRates[selectedCurrency];
    return amount * exchangeRate!;
  }

  static String format(double amount) {
    final symbol = _currencySymbols[selectedCurrency] ?? selectedCurrency;
    final numberFormat = NumberFormat.decimalPattern('en-US');
    String formattedAmount;

    bool billion = false;
    bool million = false;

    if (amount >= 1000000000) {
      amount = amount / 1000000000;
      billion = true;
    } else if (amount >= 1000000) {
      amount = amount / 1000000;
      million = true;
    }

    amount = double.parse(amount.toStringAsFixed(2));

    if (selectedCurrency == 'EUR') {
      formattedAmount = numberFormat.format(amount);
      formattedAmount = formattedAmount.replaceAll(',', ' ');
      if (billion) {
        formattedAmount = '$formattedAmount B €';
      } else if (million) {
        formattedAmount = '$formattedAmount M €';
      } else {
        formattedAmount = '$formattedAmount €';
      }
    } else if (selectedCurrency == 'USD') {
      formattedAmount = '\$${numberFormat.format(amount)}';
      if (billion) {
        formattedAmount = '$formattedAmount B';
      } else if (million) {
        formattedAmount = '$formattedAmount M';
      }
    } else {
      formattedAmount = '${numberFormat.format(amount)} $symbol';
      if (billion) {
        formattedAmount = '$formattedAmount B';
      } else if (million) {
        formattedAmount = '$formattedAmount M';
      }
    }

    return formattedAmount;
  }
}
