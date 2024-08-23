part of "extension.dart";

extension VersionParsing on String {
  int get toVersion => int.tryParse(replaceAll(".", "")) ?? 0;
}

extension ColorExtension on String {
  Color get toColor => Color(int.parse("0xff${substring(1)}"));
}

