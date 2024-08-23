import "package:flutter/material.dart";
import "package:hive/hive.dart";
import "package:currency_clean_architecture/constants/constants.dart";
import "package:currency_clean_architecture/core/utils/utils.dart";
import "package:currency_clean_architecture/injector_container.dart";

final class LocalSource {
  LocalSource(this.box);

  final Box<dynamic> box;

  bool get hasProfile => box.get(AppKeys.hasProfile, defaultValue: false);

  Future<void> setHasProfile({required bool value}) async {
    await box.put(AppKeys.hasProfile, value);
  }

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

  Future<void> setAccessToken(String accessToken) async {
    await box.put(AppKeys.accessToken, accessToken);
  }

  String get accessToken => box.get(AppKeys.accessToken, defaultValue: "");

  Future<void> setCashBackBalance(num price) async {
    await box.put(AppKeys.cashbackBalance, price);
  }

  num get cashbackBalance => box.get(AppKeys.cashbackBalance, defaultValue: 0);

  Future<void> setName(String firstName) async {
    await box.put(AppKeys.name, firstName);
  }

  String get name => box.get(AppKeys.name, defaultValue: "");

  Future<void> setPhone(String lastName) async {
    await box.put(AppKeys.phone, lastName);
  }

  String get phone => box.get(AppKeys.phone, defaultValue: "");

  Future<void> setDob(String lastName) async {
    await box.put(AppKeys.dob, lastName);
  }

  String get dob => box.get(AppKeys.dob, defaultValue: "");

  Future<void> setCustomerId(String id) async {
    await box.put(AppKeys.customerId, id);
  }

  String get customerId => box.get(AppKeys.customerId, defaultValue: "");

  Future<void> setDeliveryType(String id) async {
    await box.put(AppKeys.deliveryType, id);
  }

  String get deliveryType => box.get(
        AppKeys.deliveryType,
        defaultValue: "delivery",
      );

  Future<void> setMenuId(String menuId) async {
    await box.put(AppKeys.menuId, menuId);
  }

  String get menuId => box.get(AppKeys.menuId, defaultValue: "");

  Future<void> setDeliveryTime(int value) async {
    await box.put(AppKeys.deliveryTime, value);
  }

  int get deliveryTime => box.get(AppKeys.deliveryTime, defaultValue: 50);

  Future<void> setYandexKeyList(List<String> value) async {
    await box.put(AppKeys.yandexKeyList, value);
  }

  List<String> get yanKeyList =>
      box.get(AppKeys.yandexKeyList, defaultValue: <String>[]);

  String getKey(String key) => box.get(key, defaultValue: "");

  Future<void> setKey(String key, String value) async {
    await box.put(key, value);
  }

  Future<void> clear() async {
    final String locale = this.locale;
    await Future.wait(
      <Future<void>>[
        box.clear(),
        database.clear(),
      ],
    );
    await setLocale(locale);
  }
}

extension LocalSourceExtension on LocalSource {
  String get mapLocale {
    switch (locale) {
      case "ru":
        return "ru_RU";
      case "en":
        return "en_US";
      case "uz":
        return "uz_UZ";
      default:
        return "ru_RU";
    }
  }
}
