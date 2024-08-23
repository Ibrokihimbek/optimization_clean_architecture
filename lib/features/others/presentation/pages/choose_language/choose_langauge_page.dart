// ignore_for_file: discarded_futures

import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:currency_clean_architecture/core/extension/extension.dart";
import "package:currency_clean_architecture/core/utils/utils.dart";
import "package:currency_clean_architecture/features/others/presentation/pages/choose_language/widget/language_item_widget.dart";
import "package:currency_clean_architecture/injector_container.dart";
import "package:currency_clean_architecture/router/app_routes.dart";

class ChooseLanguagePage extends StatelessWidget {
  const ChooseLanguagePage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: context.colorScheme.surface,
        appBar: AppBar(toolbarHeight: 0),
        body: SafeArea(
          minimum: AppUtils.kPaddingAll16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              AppUtils.kSpacer,
              alignLogo,
              AppUtils.kSpacer,
              const Text(
                "Выберите язык:",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
              AppUtils.kGap12,
              LanguageItemWidget(
                onTap: () {
                  localSource.setLocale("uz");
                  context
                    ..setLocale(const Locale("uz"))
                    ..goNamed(Routes.home);
                },
                text: "O`zbekcha",
                assets: "ic_uz",
              ),
              AppUtils.kGap16,
              LanguageItemWidget(
                onTap: () {
                  localSource.setLocale("ru");
                  context
                    ..setLocale(const Locale("ru"))
                    ..goNamed(Routes.home);
                },
                text: "Русский",
                assets: "ic_ru",
              ),
              AppUtils.kGap16,
              LanguageItemWidget(
                onTap: () {
                  localSource.setLocale("en");
                  context
                    ..setLocale(const Locale("en"))
                    ..goNamed(Routes.home);
                },
                text: "English",
                assets: "ic_en",
              ),
              AppUtils.kSpacer2,
            ],
          ),
        ),
      );
}
