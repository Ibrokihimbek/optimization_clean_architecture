import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:pizza_hut_client_mobile/core/extension/extension.dart";

import "package:pizza_hut_client_mobile/core/utils/utils.dart";

class AppUpdateBottomSheetWidget extends StatelessWidget {
  const AppUpdateBottomSheetWidget({
    required this.isForceUpdate,
    super.key,
    this.onTap,
  });

  final void Function()? onTap;
  final bool isForceUpdate;

  @override
  Widget build(BuildContext context) => PopScope(
        canPop: false,
        child: SafeArea(
          minimum: AppUtils.kPaddingAllT16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                context.tr("new_version_available_update_application"),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
              AppUtils.kGap16,
              ElevatedButton(
                onPressed: onTap,
                child: Text(context.tr("update")),
              ),
              if (!isForceUpdate) AppUtils.kGap8,
              if (!isForceUpdate)
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll<Color>(
                      context.color.background,
                    ),
                  ),
                  child: Text(context.tr("later")),
                ),
            ],
          ),
        ),
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ObjectFlagProperty<void Function()?>.has("onTap", onTap))
      ..add(DiagnosticsProperty<bool>("isForceUpdate", isForceUpdate));
  }
}
