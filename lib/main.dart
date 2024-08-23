import "dart:io";

import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_bloc/flutter_bloc.dart";

import "package:currency_clean_architecture/app.dart";
import "package:currency_clean_architecture/app_options.dart";
import "package:currency_clean_architecture/core/utils/utils.dart";
import "package:currency_clean_architecture/core/widgets/native_splash/flutter_native_splash.dart";
import "package:currency_clean_architecture/injector_container.dart" as di;
import "package:currency_clean_architecture/injector_container.dart";
import "package:currency_clean_architecture/services/notification_service.dart";

void main() async {

  /// flutter_native_splash
  final WidgetsBinding binding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: binding);

  await Future.wait(
    <Future<void>>[
      /// set orientation
      SystemChrome.setPreferredOrientations(
        <DeviceOrientation>[DeviceOrientation.portraitUp],
      ),
      SystemChrome.setEnabledSystemUIMode(
        SystemUiMode.manual,
        overlays: <SystemUiOverlay>[
          SystemUiOverlay.top,
          SystemUiOverlay.bottom,
        ],
      ),

      /// notification initialize
      NotificationService.initialize(),

      /// di initialize
      di.init(),
    ],
  );

  /// bloc logger
  if (kDebugMode) {
    Bloc.observer = LogBlocObserver();
  }

  /// global CERTIFICATE_VERIFY_FAILEd_KEY
  HttpOverrides.global = _HttpOverrides();
  runApp(
    ModelBinding(
      initialModel: AppOptions(
        themeMode: ThemeMode.light,
        // themeMode: localSource.themeMode,
        locale: Locale(localSource.locale),
      ),
      child: const App(),
    ),
  );
  FlutterNativeSplash.remove();
}

class _HttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) =>
      super.createHttpClient(context)
        ..badCertificateCallback = (_, __, ___) => true;
}

/// flutter pub run flutter_launcher_icons:main
/// flutter run -d windows
/// flutter build apk --release
/// flutter build apk --split-per-abi
/// flutter build appbundle --release
/// flutter pub run build_runner watch --delete-conflicting-outputs
/// flutter pub ipa
/// dart fix --apply
