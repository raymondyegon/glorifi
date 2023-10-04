import 'package:intl/intl.dart';

extension NumberX on double {
  String formatSimpleCurrencyZeroDecimal() {
    NumberFormat numberFormat =
        NumberFormat.simpleCurrency(decimalDigits: 0, locale: 'en_US');
    return numberFormat.format(this);
  }

  ///Show decimal if not 0
  String formatSimpleCurrencyWithDynamicDecimal() {
    final isZero = truncateToDouble() == this;
    NumberFormat numberFormat = NumberFormat.simpleCurrency(
        decimalDigits: isZero ? 0 : 2, locale: 'en_US');
    return numberFormat.format(this);
  }

  String formatCurrencyWithZero() {
    // ignore: use_raw_strings
    NumberFormat numberFormat = NumberFormat.currency(name: '', symbol: '\$');
    return numberFormat.format(this);
  }
}

extension NumberY on int {
  String formatSimpleCurrencyZeroInt() {
    NumberFormat numberFormat =
    NumberFormat.simpleCurrency(decimalDigits: 0, locale: 'en_US');
    return numberFormat.format(this);
  }

  ///Show decimal if not 0
  String formatSimpleCurrencyWithDynamicInt() {
    final isZero = truncateToDouble() == this;
    NumberFormat numberFormat = NumberFormat.simpleCurrency(
        decimalDigits: isZero ? 0 : 2, locale: 'en_US');
    return numberFormat.format(this);
  }

  String formatCurrencyWithZero() {
    // ignore: use_raw_strings
    NumberFormat numberFormat = NumberFormat.currency(name: '', symbol: '\$');
    return numberFormat.format(this);
  }
}
