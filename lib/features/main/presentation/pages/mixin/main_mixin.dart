import "package:flutter/material.dart";
import "package:pizza_hut_client_mobile/constants/constants.dart";
import "package:pizza_hut_client_mobile/core/widgets/bottom_sheet/custom_bottom_sheet.dart";
import "package:pizza_hut_client_mobile/core/widgets/bottom_sheet/update_app_sheet.dart";
import "package:pizza_hut_client_mobile/features/main/presentation/bloc/main_bloc.dart";
import "package:url_launcher/url_launcher.dart";

mixin MainMixin {
  Future<void> onListener(BuildContext context, MainState state) async {
    if (state.status.isForceUpdate && state.isForceUpdate != null) {
      await appUpdateBottomSheet(context, isForceUpdate: state.isForceUpdate!);
    }
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
