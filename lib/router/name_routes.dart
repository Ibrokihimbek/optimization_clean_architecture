part of "app_routes.dart";

sealed class Routes {
  Routes._();

  static const String initial = "/";
  static const String chooseLanguage = "/choose-language";

  /// Auth
  static const String auth = "/auth";
  static const String confirmCode = "/confirm-code";
  static const String register = "/register";

  /// Home
  static const String home = "/home";
  static const String search = "/search";
  static const String notification = "/notification";
  static const String deliveryAddress = "/delivery-address";
  static const String product = "/product";
  static const String reviews = "/reviews";
  static const String basket = "/basket";
  static const String checkoutOrder = "/checkout-order";
  static const String notificationDetail = "/notification-detail";

  // static const String scanner = "/scanner";

  /// Orders
  static const String orders = "/orders";
  static const String currentOrderDetail = "/current-order-detail";
  static const String historyOrderDetail = "/history-order-detail";

  /// Profile
  static const String profile = "/profile";
  static const String profileEdit = "/profile-edit";
  static const String settings = "/settings";
  static const String promos = "/promos";
  static const String promosDetail = "/promos-detail";
  static const String vacancies = "/vacancies";
  static const String vacancyDetail = "/vacancy-detail";
  static const String restaurants = "/restaurants";
  static const String restaurantDetail = "/restaurant-detail";
  static const String news = "/news";
  static const String newsDetail = "/news-detail";
  static const String gallery = "/gallery";
  static const String galleryDetail = "/gallery-detail";
  static const String recipes = "/recipes";
  static const String recipeDetail = "/recipe-detail";
  static const String qrcode = "/qrcode";
  static const String support = "/support";
  static const String accountManagement = "/account-management";
  static const String publicOffer = "/public-offer";
  static const String privacyPolicy = "/privacy-policy";
  static const String myAddress = "/my-address";

  /// internet connection
  static const String noInternet = "/no-internet";
}
