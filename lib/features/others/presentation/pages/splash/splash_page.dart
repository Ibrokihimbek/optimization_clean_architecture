import "dart:async";

import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:go_router/go_router.dart";
import "package:currency_clean_architecture/constants/constants.dart";
import "package:currency_clean_architecture/core/extension/extension.dart";
import "package:currency_clean_architecture/core/theme/themes.dart";
import "package:currency_clean_architecture/core/widgets/bottom_sheet/custom_bottom_sheet.dart";
import "package:currency_clean_architecture/core/widgets/bottom_sheet/update_app_sheet.dart";
import "package:currency_clean_architecture/core/widgets/loading/circular_progress_indicator.dart";
import "package:currency_clean_architecture/injector_container.dart";
import "package:currency_clean_architecture/router/app_routes.dart";
import "package:url_launcher/url_launcher.dart";

part "mixins/splash_mixin.dart";

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with SplashMixin {
  @override
  Widget build(BuildContext context) => AnnotatedRegion<SystemUiOverlayStyle>(
        value: systemLightUiOverlayStyle,
        child: Scaffold(
          backgroundColor: context.colorScheme.surface,
          body: Stack(
            children: <Widget>[
              Positioned(
                left: 0,
                right: 0,
                bottom: context.padding.bottom + 24,
                child: const Center(
                  child: CustomCircularProgressIndicator(),
                ),
              ),
              const Positioned.fill(
                child: Center(
                  child: Icon(Icons.currency_exchange, size: 64),
                ),
              ),
            ],
          ),
        ),
      );
}
