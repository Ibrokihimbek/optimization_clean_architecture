part of "app_routes.dart";

sealed class Routes {
  Routes._();

  static const String initial = "/";
  static const String chooseLanguage = "/choose-language";

  /// Home
  static const String home = "/home";

  // static const String scanner = "/scanner";

  /// Orders
  static const String profile = "/orders";
  static const String currentOrderDetail = "/current-order-detail";
  static const String historyOrderDetail = "/history-order-detail";


  /// internet connection
  static const String noInternet = "/no-internet";
}
