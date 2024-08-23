import "package:flutter/material.dart";
import "package:currency_clean_architecture/constants/constants.dart";
import "package:currency_clean_architecture/core/widgets/bottom_sheet/custom_bottom_sheet.dart";
import "package:currency_clean_architecture/core/widgets/bottom_sheet/update_app_sheet.dart";
import "package:currency_clean_architecture/features/main/presentation/bloc/main_bloc.dart";
import "package:url_launcher/url_launcher.dart";

mixin MainMixin {
  Future<void> onListener(BuildContext context, MainState state) async {
  }

  Future<void> appUpdateBottomSheet(
    BuildContext context, {
    required bool isForceUpdate,
  }) async {
    await customModalBottomSheet<bool>(
      enableDrag: false,
      context: context,
      builder: (_, __) => AppUpdateBottomSheetWidget(
        isForceUpdate: isForceUpdate,
        onTap: () async {
          await launchUrl(
            Uri.parse(Constants.appLink),
            mode: LaunchMode.externalApplication,
          ).then(
            (bool value) async {
              if (context.mounted) {
                Navigator.pop(context);
              }
            },
          );
        },
      ),
    );
  }
}
