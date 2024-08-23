import "dart:io";

import "package:pizza_hut_client_mobile/constants/.env.dart";

sealed class Constants {
  Constants._();

  static final String baseUrl = AppEnvironment.instance.config.baseUrl;
  static final String cdnUrl = AppEnvironment.instance.config.cdnUrl;
  static final String shipperId = AppEnvironment.instance.config.shipperId;
  static final String platformId = AppEnvironment.instance.config.platformId;
  static const String yandexUrl = "https://geocode-maps.yandex.ru/1.x/";
  static const String appName = "PizzaHut";

  static final String appLink = Platform.isIOS
      ? "https://apps.apple.com/app/pizza-hut/id6575347690"
      : "https://play.google.com/store/apps/details?id=uz.delever.pizza_hut_client_mobile";

  static const int deliveryPrice = 0;

  static const List<String> currentOrders = <String>[
    "986a0d09-7b4d-4ca9-8567-aa1c6d770505",
    "ccb62ffb-f0e1-472e-bf32-d130bea90617",
    "1b6dc9a3-64aa-4f68-b54f-71ffe8164cd3",
    "b0cb7c69-5e3d-47c7-9813-b0a7cc3d81fd",
    "8781af8e-f74d-4fb6-ae23-fd997f4a2ee0",
    "84be5a2f-3a92-4469-8283-220ca34a0de4",
    "bf9cc968-367d-4391-93fa-f77eda2a7a99",
  ];

  static const List<String> cancelOrders = <String>[
    "d39cb255-6cf5-4602-896d-9c559d40cbbe",
    "b5d1aa93-bccd-40bb-ae29-ea5a85a2b1d1",
    "c4227d1b-c317-46f8-b1e3-a48c2496206f",
    "6ba783a3-1c2e-479c-9626-25526b3d9d36",
  ];

  static const String newId = "986a0d09-7b4d-4ca9-8567-aa1c6d770505";
  static const String operatorAccepted = "ccb62ffb-f0e1-472e-bf32-d130bea90617";
  static const String futureTime = "bf9cc968-367d-4391-93fa-f77eda2a7a99";
  static const String vendorAccepted = "1b6dc9a3-64aa-4f68-b54f-71ffe8164cd3";
  static const String courierAccepted = "8781af8e-f74d-4fb6-ae23-fd997f4a2ee0";
  static const String courierCancelled = "6ba783a3-1c2e-479c-9626-25526b3d9d36";
  static const String vendorReady = "b0cb7c69-5e3d-47c7-9813-b0a7cc3d81fd";
  static const String courierPickedUp = "84be5a2f-3a92-4469-8283-220ca34a0de4";
  static const String serverCancelled = "d39cb255-6cf5-4602-896d-9c559d40cbbe";
  static const String operatorCancelled =
      "b5d1aa93-bccd-40bb-ae29-ea5a85a2b1d1";
  static const String delivered = "79413606-a56f-45ed-97c3-f3f18e645972";
  static const String finished = "e665273d-5415-4243-a329-aee410e39465";
  static const String vendorCancelled = "c4227d1b-c317-46f8-b1e3-a48c2496206f";
}

class Validations {
  Validations._();

  static const String emailEmpty = "Email cannot be empty";
  static const String notEmail = "This is not email";
  static const String passwordEmpty = "Password cannot be empty";
  static const String passwordShort = "Password too short";
  static const String passwordLong = "Password too long";
  static const String firstnameEmpty = "Firstname cannot be empty";
  static const String firstnameShort = "Firstname too short";
  static const String firstnameLong = "Firstname too long";
  static const String lastnameEmpty = "Last name cannot be empty";
  static const String lastnameShort = "Lastname too short";
  static const String lastnameLong = "Lastname too long";
  static const String passwordNotMatch = "Passwords do not match";
  static const String internetFailure = "No Internet";
  static const String somethingWentWrong = "Something went wrong!";
}

sealed class AppKeys {
  AppKeys._();

  static const String locale = "locale";
  static const String hasLocale = "has_locale";
  static const String themeMode = "theme_mode";

  /// Profile
  static const String hasProfile = "has_profile";
  static const String accessToken = "access_token";
  static const String name = "firstname";
  static const String phone = "phone";
  static const String dob = "dob";
  static const String customerId = "customer_id";
  static const String cashbackBalance = "cashback_balance";
  static const String deliveryType = "delivery_type";

  /// delivery address
  static const String deliveryTime = "delivery_time";
  static const String menuId = "menu_id";
  static const String selectedDeliveryType = "selected_delivery_type";

  ///
  static const String yandexKeyList = "yandex_key_list";

  /// Database
  static const String productDb = "product.db";
  static const String deliveryAddress = "delivery_address";
  static const String deliveryAddressDb = "delivery_address.db";
  static const String pickUpBranch = "pick_up_branch";
  static const String pickUpBranchDb = "pick_up_branch.db";
}

sealed class Urls {
  Urls._();

  /// Auth
  static const String customerPhone = "v1/customers/phone";
  static const String login = "v1/customers/login";
  static const String register = "v1/customers/register";
  static const String registerConfirm = "v1/customers/register-confirm";
  static const String confirmLogin = "v1/customers/confirm-login";
  static const String customers = "v1/customers/";
  static const String deleteAccount = "v2/customers/self-delete";
  static const String customerAddress = "v1/customer_address";
  static const String recipes = "v2/recipes";

  /// Profile
  static const String promo = "v1/promo";
  static const String news = "v2/news-events";
  static const String branches = "v1/branches";
  static const String customerInfo = "v2/crm/iiko-customer-info";
  static const String customerProfile = "v1/customer-profile";
  static const String vacancy = "v2/vacancy";

  /// products
  static const String categoryProducts = "v2/category-with-products";
  static const String categoryChildren = "v2/category-with-children";
  static const String banner = "v1/banner";
  static const String productNonVariant = "v2/product-non-variant-modifier";
  static const String combo = "v2/combo/";
  static const String product = "v2/product";
  static const String menuProducts = "v2/menu-products";
  static const String productFavourites = "v2/product-favourites";
  static const String productModifier = "v2/modifier";
  static const String autoAddProduct = "v2/auto-add-product";
  static const String sourceSettings = "v2/source-settings";
  static const String discountOrder = "v2/discount-with-order-price";
  static const String discountProducts = "v2/discount-with-products";
  static const String checkPointDeliveryZones = "v1/check_point_delivery_zones";
  static const String nearestBranch = "v1/nearest-branch";
  static const String createOrder = "v2/ondemand-order";
  static const String deliveryZones = "v2/active-delivery-zones";
  static const String computePrice = "v1/fares/compute-price";
  static const String shippers = "v1/shippers";
  static const String tags = "v1/tags";
  static const String userReview = "v1/user_reviews";
  static const String notifications = "v2/notifications";
  static const String vacancyCandidate = "v2/vacancy-candidate";

  /// Orders
  static const String order = "v1/order";
  static const String orderV2 = "v2/order";

  /// force update
  static const String forceUpdate = "v1/mobile_app";
}

sealed class Slugs {
  Slugs._();

  static const String patients = "/patients";
}

sealed class DatabaseKeys {
  DatabaseKeys._();

  static const String categoryList = "category_list/";
  static const String guidList = "guid_list/";
  static const String article = "article/";
}
