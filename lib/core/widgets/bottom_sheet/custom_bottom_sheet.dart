import "package:flutter/material.dart";
import "package:pizza_hut_client_mobile/core/extension/extension.dart";

typedef WidgetScrollBuilder = Widget Function(
  BuildContext context,
  ScrollController? controller,
);

Future<T?> customModalBottomSheet<T>({
  required BuildContext context,
  required WidgetScrollBuilder builder,
  bool isScrollControlled = false,
  bool enableDrag = true,
  bool showDragHandle = true,
}) async =>
    showModalBottomSheet(
      context: context,
      enableDrag: enableDrag,
      isScrollControlled: true,
      showDragHandle: showDragHandle,
      clipBehavior: Clip.antiAlias,
      backgroundColor: context.theme.bottomSheetTheme.backgroundColor,
      constraints: BoxConstraints(
        maxHeight: context.height * 0.9,
        minHeight: context.height * 0.2,
      ),
      builder: (_) {
        if (isScrollControlled) {
          return DraggableScrollableSheet(
            initialChildSize: 1,
            minChildSize: 0.5,
            expand: false,
            snap: true,
            builder: builder,
          );
        } else {
          return builder(context, null);
        }
      },
    );
