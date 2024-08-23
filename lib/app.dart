import "package:flutter/material.dart";

import "package:currency_clean_architecture/core/extension/extension.dart";
import "package:currency_clean_architecture/core/l10n/app_localizations_setup.dart";
import "package:currency_clean_architecture/core/theme/themes.dart";
import "package:currency_clean_architecture/router/app_routes.dart";

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
