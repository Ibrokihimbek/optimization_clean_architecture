import "package:flutter/material.dart";

import "package:pizza_hut_client_mobile/core/extension/extension.dart";
import "package:pizza_hut_client_mobile/core/l10n/app_localizations_setup.dart";
import "package:pizza_hut_client_mobile/core/theme/themes.dart";
import "package:pizza_hut_client_mobile/router/app_routes.dart";

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp.router(
        debugShowCheckedModeBanner: false,

        /// router
        routerConfig: router,

        /// theme style
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: context.options.themeMode,

        /// locale
        locale: context.options.locale,
        supportedLocales: AppLocalizationsSetup.supportedLocales,
        localizationsDelegates: AppLocalizationsSetup.localizationsDelegates,
      );
}
