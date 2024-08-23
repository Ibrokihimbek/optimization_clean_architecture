part of "extension.dart";

extension VersionParsing on String {
  int get toVersion => int.tryParse(replaceAll(".", "")) ?? 0;
}

extension ColorExtension on String {
  Color get toColor => Color(int.parse("0xff${substring(1)}"));
}

extension PaymentMethodExtension on PaymentTypes {
  String get assets {
    switch (value) {
      case "cash":
        return Images.icCash;
      case "click":
        return Images.icClick;
      case "uzum":
        return Images.icUzum;
      case "payme":
        return Images.icPayme;
      default:
        return Images.icCash;
    }
  }
}
