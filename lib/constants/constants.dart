import "dart:io";


sealed class Constants {
  Constants._();

  static const String baseUrl = "https://nbu.uz/";

  static final String appLink = Platform.isIOS
      ? "https://apps.apple.com/app/pizza-hut/id6575347690"
      : "https://play.google.com/store/apps/details?id=uz.delever.pizza_hut_client_mobile";

}

sealed class AppKeys {
  AppKeys._();

  static const String locale = "locale";
  static const String hasLocale = "has_locale";
  static const String themeMode = "theme_mode";

}

sealed class Urls {
  Urls._();

  static const String exChange = "uz/exchange-rates/json/";

}

sealed class Slugs {
  Slugs._();
}

sealed class DatabaseKeys {
  DatabaseKeys._();
}
