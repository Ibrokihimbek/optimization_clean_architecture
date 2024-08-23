import "package:flutter/material.dart";
import "package:hive/hive.dart";
import "package:currency_clean_architecture/constants/constants.dart";
import "package:currency_clean_architecture/core/utils/utils.dart";

final class LocalSource {
  LocalSource(this.box);

  final Box<dynamic> box;


  Future<void> setLocale(String locale) async {
    await box.put(AppKeys.hasLocale, true);
    await box.put(AppKeys.locale, locale);
  }

  String get locale => box.get(AppKeys.locale, defaultValue: defaultLocale);

  bool get hasLocale => box.get(AppKeys.hasLocale, defaultValue: false);

  ThemeMode get themeMode => switch (box.get(AppKeys.themeMode)) {
        "system" => ThemeMode.system,
        "light" => ThemeMode.light,
        "dark" => ThemeMode.dark,
        _ => ThemeMode.system,
      };

  Future<void> setThemeMode(ThemeMode mode) async {
    await box.put(AppKeys.themeMode, mode.name);
  }


  String getKey(String key) => box.get(key, defaultValue: "");

  Future<void> setKey(String key, String value) async {
    await box.put(key, value);
  }

  Future<void> clear() async {
    final String locale = this.locale;
    await Future.wait(
      <Future<void>>[
        box.clear(),
      ],
    );
    await setLocale(locale);
  }
}

