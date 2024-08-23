part of "extension.dart";

extension MoneyFormatExtension on num {
  String get moneyFormat => isNegative
      ? "-${NumberFormat().format(abs()).split(",").join(" ")}"
      : NumberFormat().format(this).split(",").join(" ");

  String get moneyFormatSymbol => "$moneyFormat ${"sum".tr()}";

  String formatter() {
    final num currentBalance = this;
    final bool t = currentBalance.isNegative;
    final num value = currentBalance.abs();
    if (value < 10) {
      return (t ? "-" : "") + value.toInt().toString();
    } else if (value < 1000) {
      final String text = value.round().toString();
      return (t ? "-" : "") + text;
    } else if (value >= 1000 && value < 1000000) {
      return (t ? "-" : "") +
          NumberFormat.compactCurrency(decimalDigits: 3, symbol: "")
              .format(value.round());
    } else if (value >= 1000000 && value < (1000000 * 1000)) {
      return (t ? "-" : "") +
          NumberFormat.compactCurrency(decimalDigits: 6, symbol: "")
              .format(value.round());
    } else if (value >= (1000000 * 1000) && value < (1000000 * 1000 * 100)) {
      return (t ? "-" : "") +
          NumberFormat.compactCurrency(decimalDigits: 9, symbol: "")
              .format(value.round());
    } else if (value >= (1000000 * 1000 * 1000) &&
        value < (1000000 * 1000 * 1000 * 1000)) {
      return (t ? "-" : "") +
          NumberFormat.compactCurrency(decimalDigits: 12, symbol: "")
              .format(value.round());
    } else {
      return "";
    }
  }
}

extension PhoneNumberFormat on String {
  String get phoneNumberFormat => formatPhoneNumber();

  String formatPhoneNumber() {
    String cleaned = trim();
    if (cleaned.endsWith(";")) {
      cleaned = cleaned.substring(0, cleaned.length - 1);
    }

    if (cleaned.length != 13 || !cleaned.startsWith("+998")) {
      return cleaned;
    }

    final String countryCode = cleaned.substring(0, 4);
    final String part1 = cleaned.substring(4, 6);
    final String part2 = cleaned.substring(6, 9);
    final String part3 = cleaned.substring(9, 11);
    final String part4 = cleaned.substring(11, 13);

    return "$countryCode $part1-$part2-$part3-$part4";
  }
}
