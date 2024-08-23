// ignore_for_file: avoid_redundant_argument_values

import "dart:developer";
import "dart:io";

import "package:dio/dio.dart";
import "package:dio/io.dart";
import "package:dio_retry_plus/dio_retry_plus.dart";
import "package:flutter/foundation.dart";
import "package:get_it/get_it.dart";
import "package:go_router/go_router.dart";
import "package:hive/hive.dart";
import "package:package_info_plus/package_info_plus.dart";
import "package:path_provider/path_provider.dart";
import "package:pizza_hut_client_mobile/constants/constants.dart";
import "package:pizza_hut_client_mobile/core/connectivity/network_info.dart";
import "package:pizza_hut_client_mobile/core/local_source/hive_database.dart";
import "package:pizza_hut_client_mobile/core/local_source/local_source.dart";
import "package:pizza_hut_client_mobile/core/local_source/product_hive.dart";
import "package:pizza_hut_client_mobile/features/auth/domain/repository/auth_repository.dart";
import "package:pizza_hut_client_mobile/features/auth/presentation/bloc/confirm/confirm_code_bloc.dart";
import "package:pizza_hut_client_mobile/features/auth/presentation/bloc/login/auth_bloc.dart";
import "package:pizza_hut_client_mobile/features/auth/presentation/bloc/register/register_bloc.dart";
import "package:pizza_hut_client_mobile/features/home/data/datasource/local/home_local_data_source.dart";
import "package:pizza_hut_client_mobile/features/home/data/datasource/remote/home_remote_data_source.dart";
import "package:pizza_hut_client_mobile/features/home/domain/repository/home_repository.dart";
import "package:pizza_hut_client_mobile/features/home/presentation/bloc/basket/basket_bloc.dart";
import "package:pizza_hut_client_mobile/features/home/presentation/bloc/checkout/checkout_order_bloc.dart";
import "package:pizza_hut_client_mobile/features/home/presentation/bloc/delivery_address/delivery_address_bloc.dart";
import "package:pizza_hut_client_mobile/features/home/presentation/bloc/home/home_bloc.dart";
import "package:pizza_hut_client_mobile/features/home/presentation/bloc/notification/notification_bloc.dart";
import "package:pizza_hut_client_mobile/features/home/presentation/bloc/notification_detail/notification_detail_bloc.dart";
import "package:pizza_hut_client_mobile/features/home/presentation/bloc/product/product_detail_bloc.dart";
import "package:pizza_hut_client_mobile/features/home/presentation/bloc/product_review/product_review_bloc.dart";
import "package:pizza_hut_client_mobile/features/home/presentation/bloc/user_addresses/user_addresses_bloc.dart";
import "package:pizza_hut_client_mobile/features/main/data/datasource/local/main_local_data_source.dart";
import "package:pizza_hut_client_mobile/features/main/data/datasource/remote/main_remote_data_source.dart";
import "package:pizza_hut_client_mobile/features/main/domain/repository/main_repository.dart";
import "package:pizza_hut_client_mobile/features/main/presentation/bloc/main_bloc.dart";
import "package:pizza_hut_client_mobile/features/orders/data/datasource/local/orders_local_data_source.dart";
import "package:pizza_hut_client_mobile/features/orders/data/datasource/remote/orders_remote_data_source.dart";
import "package:pizza_hut_client_mobile/features/orders/domain/repository/orders_repository.dart";
import "package:pizza_hut_client_mobile/features/orders/presentation/bloc/current_order_detail/current_order_detail_bloc.dart";
import "package:pizza_hut_client_mobile/features/orders/presentation/bloc/history_order_detail/history_order_detail_bloc.dart";
import "package:pizza_hut_client_mobile/features/orders/presentation/bloc/orders/orders_bloc.dart";
import "package:pizza_hut_client_mobile/features/profile/data/datasource/local/profile_local_data_source.dart";
import "package:pizza_hut_client_mobile/features/profile/data/datasource/remote/profile_remote_data_source.dart";
import "package:pizza_hut_client_mobile/features/profile/domain/repository/profile_repository.dart";
import "package:pizza_hut_client_mobile/features/profile/presentation/bloc/branches/branches_bloc.dart";
import "package:pizza_hut_client_mobile/features/profile/presentation/bloc/gallery/gallery_bloc.dart";
import "package:pizza_hut_client_mobile/features/profile/presentation/bloc/my_address/my_address_bloc.dart";
import "package:pizza_hut_client_mobile/features/profile/presentation/bloc/news/news_bloc.dart";
import "package:pizza_hut_client_mobile/features/profile/presentation/bloc/profile/delete_account/delete_account_bloc.dart";
import "package:pizza_hut_client_mobile/features/profile/presentation/bloc/profile/edit/profile_edit_bloc.dart";
import "package:pizza_hut_client_mobile/features/profile/presentation/bloc/profile/profile_bloc.dart";
import "package:pizza_hut_client_mobile/features/profile/presentation/bloc/promos/promos_bloc.dart";
import "package:pizza_hut_client_mobile/features/profile/presentation/bloc/recipes/detail/recipe_detail_bloc.dart";
import "package:pizza_hut_client_mobile/features/profile/presentation/bloc/recipes/recipes_bloc.dart";
import "package:pizza_hut_client_mobile/features/profile/presentation/bloc/vacancies/vacancies_bloc.dart";
import "package:pizza_hut_client_mobile/router/app_routes.dart";
import "package:pizza_hut_client_mobile/services/location_service.dart";
import "package:sms_autofill/sms_autofill.dart";

final GetIt sl = GetIt.instance;
late Box<dynamic> _box;
late Box<ProductHive> _boxProduct;
late Box<dynamic> _boxDeliveryAddress;

final LocationService locationService = sl<LocationService>();
final LocalSource localSource = sl<LocalSource>();
final PackageInfo packageInfo = sl<PackageInfo>();
final NetworkInfo networkInfo = sl<NetworkInfo>();
final HiveDatabase database = sl<HiveDatabase>();

Future<void> init() async {
  /// External
  await _initHive();

  /// Dio
  sl.registerLazySingleton(
    () => Dio()
      ..options = BaseOptions(
        contentType: "application/json",
        sendTimeout: const Duration(seconds: 30),
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: <String, String>{"Shipper": Constants.shipperId},
      )
      ..httpClientAdapter = IOHttpClientAdapter(
        createHttpClient: () {
          final HttpClient client = HttpClient()
            ..badCertificateCallback = (X509Certificate cert, String host, __) {
              log("cert: ${cert.pem}");
              log("host: $host");
              // return cert.pem == certificate;
              return true;
            };
          return client;
        },
        validateCertificate: (X509Certificate? cert, String host, __) {
          // log("cert: ${cert?.pem}");
          // log("host: $host");
          if (cert == null) {
            return true;
          }
          // Clipboard.setData(ClipboardData(text: cert.pem));
          return true;
          // return cert.pem == certificate;
        },
      )
      ..interceptors.add(
        LogInterceptor(
          error: kDebugMode,
          request: kDebugMode,
          requestBody: kDebugMode,
          responseBody: kDebugMode,
          requestHeader: kDebugMode,
          responseHeader: kDebugMode,
          logPrint: (Object object) {
            if (kDebugMode) {
              log("dio: $object");
            }
          },
        ),
      ),
  );

  sl<Dio>().interceptors.addAll(
    <Interceptor>[
      chuck.getDioInterceptor(),
      RetryInterceptor(
        dio: sl<Dio>(),
        retries: 1,
        toNoInternetPageNavigator: () async {
          final RouteMatch lastMatch =
              router.routerDelegate.currentConfiguration.last;
          final RouteMatchList matchList = lastMatch is ImperativeRouteMatch
              ? lastMatch.matches
              : router.routerDelegate.currentConfiguration;
          final String location = matchList.uri.toString();
          if (location.contains(Routes.noInternet)) {
            return;
          }
          await router.pushNamed(Routes.noInternet);
        },
        accessTokenGetter: () => "Bearer ${localSource.accessToken}",
        refreshTokenFunction: () async {
          await localSource.clear().then(
            (_) {
              router.goNamed(Routes.home);
            },
          );
        },
        forbiddenFunction: () async {
          await localSource.clear().then(
            (_) {
              router.goNamed(Routes.home);
            },
          );
        },
        logPrint: (String message) {
          if (kDebugMode) {
            log("dio: $message");
          }
        },
      ),
    ],
  );

  /// Core
  sl
    ..registerSingleton<LocalSource>(LocalSource(_box))
    ..registerLazySingleton<HiveDatabase>(
      () => HiveDatabase(
        boxProduct: _boxProduct,
        deliveryAddressBox: _boxDeliveryAddress,
      ),
    )
    ..registerLazySingleton(
      () => InternetConnectionChecker.createInstance(
        checkInterval: const Duration(seconds: 3),
      ),
    )
    ..registerLazySingleton<LocationService>(
      () => LocationServiceImpl(location: Location()),
    )
    ..registerLazySingleton<SmsAutoFill>(SmsAutoFill.new)
    ..registerSingletonAsync<PackageInfo>(PackageInfo.fromPlatform)
    ..registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  /// features
  _authFeature();
  _mainFeature();
  _homeFeature();
  _ordersFeature();
  _profileFeature();
}

void _authFeature() {
  /// use cases
  sl

    /// repositories
    ..registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(dio: sl()))

    /// bloc
    ..registerFactory(() => AuthBloc(authRepository: sl()))
    ..registerFactory(() => ConfirmCodeBloc(sl()))
    ..registerFactory(() => RegisterBloc(repository: sl()));
}

void _mainFeature() {
  /// features
  sl
    ..registerLazySingleton<MainRemoteDataSource>(
      () => MainRemoteDataSourceImpl(dio: sl()),
    )
    ..registerLazySingleton<MainLocalDataSource>(
      () => MainLocalDataSourceImpl(localSource: sl()),
    )

    /// repositories
    ..registerLazySingleton<MainRepository>(
      () => MainRepositoryImpl(
        localSource: sl(),
        remoteSource: sl(),
      ),
    )

    /// bloc
    ..registerFactory(() => MainBloc(repository: sl()));
}

void _profileFeature() {
  /// use cases
  sl
    ..registerLazySingleton<ProfileRemoteDataSource>(
      () => ProfileRemoteDataSourceImpl(dio: sl()),
    )
    ..registerLazySingleton<ProfileLocalDataSource>(
      () => ProfileLocalDataSourceImpl(localSource: sl()),
    )

    /// repositories
    ..registerLazySingleton<ProfileRepository>(
      () => ProfileRepositoryImpl(
        remoteSource: sl(),
        localSource: sl(),
      ),
    )

    /// bloc
    ..registerFactory(() => ProfileBloc(repository: sl()))
    ..registerFactory(
      () => MyAddressBloc(repository: sl(), profileRepository: sl()),
    )
    ..registerFactory(() => ProfileEditBloc(repository: sl()))
    ..registerFactory(() => PromosBloc(repository: sl()))
    ..registerFactory(() => NewsBloc(repository: sl()))
    ..registerFactory(() => RecipesBloc(repository: sl()))
    ..registerFactory(() => RecipeDetailBloc(repository: sl()))
    ..registerFactory(() => VacanciesBloc(repository: sl()))
    ..registerFactory(() => GalleryBloc(repository: sl()))
    ..registerFactory(() => BranchesBloc(repository: sl()))
    ..registerFactory(() => DeleteAccountBloc(repository: sl()));
}

void _homeFeature() {
  /// use cases
  sl
    ..registerLazySingleton<HomeRemoteDataSource>(
      () => HomeRemoteDataSourceImpl(dio: sl()),
    )
    ..registerLazySingleton<HomeLocalDataSource>(
      () => HomeLocalDataSourceImpl(localSource: sl()),
    )

    /// repositories
    ..registerLazySingleton<HomeRepository>(
      () => HomeRepositoryImpl(
        remoteSource: sl(),
        localSource: sl(),
      ),
    )

    /// bloc
    ..registerFactory(() => HomeBloc(repository: sl()))
    ..registerFactory(() => ProductDetailBloc(repository: sl()))
    ..registerFactory(() => BasketBloc(repository: sl()))
    ..registerFactory(() => NotificationBloc(repository: sl()))
    ..registerFactory(() => NotificationDetailBloc(repository: sl()))
    ..registerFactory(() => ProductReviewBloc(repository: sl()))
    ..registerFactory(
      () => DeliveryAddressBloc(
        repository: sl(),
        profileRepository: sl(),
      ),
    )
    ..registerFactory(
      () => UserAddressesBloc(
        repository: sl(),
        profileRepository: sl(),
      ),
    )
    ..registerFactory(
      () => CheckoutOrderBloc(
        repository: sl(),
        profileRepository: sl(),
      ),
    );
}

void _ordersFeature() {
  /// use cases
  sl
    ..registerLazySingleton<OrdersRemoteDataSource>(
      () => OrdersRemoteDataSourceImpl(dio: sl()),
    )
    ..registerLazySingleton<OrdersLocalDataSource>(
      () => OrdersLocalDataSourceImpl(localSource: sl()),
    )

    /// repositories
    ..registerLazySingleton<OrdersRepository>(
      () => OrdersRepositoryImpl(
        remoteSource: sl(),
        localSource: sl(),
      ),
    )

    /// bloc
    ..registerFactory(() => OrdersBloc(repository: sl()))
    ..registerFactory(() => CurrentOrderDetailBloc(repository: sl()))
    ..registerFactory(() => HistoryOrderDetailBloc(repository: sl()));
}

Future<void> _initHive() async {
  const String boxName = "pizza_hut_client_mobile_box";
  final Directory directory = await getApplicationDocumentsDirectory();
  await Hive.deleteFromDisk();

  Hive
    ..init(directory.path)
    ..registerAdapter(ProductHiveAdapter())
    ..registerAdapter(ModifierAdapter())
    ..registerAdapter(ComboAdapter())
    ..registerAdapter(NameTitleAdapter());

  /// Open box
  _box = await Hive.openBox<dynamic>(boxName);
  _boxProduct = await Hive.openBox<ProductHive>(AppKeys.productDb);
  _boxDeliveryAddress = await Hive.openBox<dynamic>(AppKeys.deliveryAddressDb);
}
