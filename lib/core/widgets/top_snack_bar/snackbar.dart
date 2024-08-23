import "package:flutter/material.dart";
import "package:pizza_hut_client_mobile/core/extension/extension.dart";

import "package:pizza_hut_client_mobile/core/widgets/top_snack_bar/top_snack_bar.dart";

void showErrorMessage(
  BuildContext context, {
  required String message,
}) {
  showTopSnackBar(
    Overlay.of(context),
    CustomSnackBar.error(
      title: context.tr("error"),
      message: message,
      backgroundColor: context.colorScheme.error,
    ),
  );
}

void showSuccessMessage(
  BuildContext context, {
  required String message,
}) {
  showTopSnackBar(
    Overlay.of(context),
    CustomSnackBar.success(
      title: context.tr("success"),
      message: message,
      backgroundColor: context.colorScheme.error,
    ),
  );
}

void showInfoMessage(
  BuildContext context, {
  required String message,
}) {
  showTopSnackBar(
    Overlay.of(context),
    CustomSnackBar.info(
      title: context.tr("info"),
      message: message,
      backgroundColor: context.colorScheme.error,
    ),
  );
}