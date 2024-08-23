// ignore_for_file: use_build_context_synchronously
import "dart:io";

import "package:flutter/cupertino.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:map_launcher/map_launcher.dart";
import "package:pizza_hut_client_mobile/core/extension/extension.dart";
import "package:pizza_hut_client_mobile/core/utils/utils.dart";
import "package:pizza_hut_client_mobile/core/widgets/bottom_sheet/custom_bottom_sheet.dart";

sealed class MapsSheet {
  MapsSheet._();

  static Future<T?> show<T>({
    required BuildContext context,
    required ValueChanged<AvailableMap> onMapTap,
  }) async =>
      MapLauncher.installedMaps.then(
        (List<AvailableMap> availableMaps) {
          if (Platform.isAndroid && context.mounted) {
            return customModalBottomSheet(
              context: context,
              builder: (_, __) => SafeArea(
                minimum: AppUtils.kPaddingAllT16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      context.tr("open_with"),
                      style: context.textTheme.titleMedium,
                    ),
                    AppUtils.kGap16,
                    SizedBox(
                      height: 90,
                      child: ListView.separated(
                        itemCount: availableMaps.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (_, int index) => Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () => onMapTap(availableMaps[index]),
                              child: Container(
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                  color: context.colorScheme.surface,
                                  borderRadius: AppUtils.kBorderRadius12,
                                  boxShadow: const <BoxShadow>[
                                    BoxShadow(
                                      color: Color.fromRGBO(0, 0, 0, 0.1),
                                      blurRadius: 2,
                                      spreadRadius: 1,
                                      offset: Offset(1, 1),
                                    ),
                                  ],
                                ),
                                width: 55,
                                height: 55,
                                child: SvgPicture.asset(
                                  availableMaps[index].icon,
                                  height: 40,
                                  width: 40,
                                ),
                              ),
                            ),
                            AppUtils.kGap12,
                            Text(
                              availableMaps[index].mapName,
                              textAlign: TextAlign.center,
                              style: context.textTheme.titleMedium?.copyWith(
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                        separatorBuilder: (_, __) => AppUtils.kGap16,
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return showCupertinoModalPopup(
              context: context,
              builder: (_) => CupertinoActionSheet(
                title: Text(
                  context.tr("open_with"),
                  style: context.textTheme.titleMedium,
                ),
                actions: <Widget>[
                  SizedBox(
                    height: 122,
                    child: ListView.separated(
                      padding: AppUtils.kPaddingAll16,
                      itemCount: availableMaps.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (_, int index) => Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () => onMapTap(availableMaps[index]),
                            child: Container(
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                color: context.colorScheme.surface,
                                borderRadius: AppUtils.kBorderRadius12,
                                boxShadow: const <BoxShadow>[
                                  BoxShadow(
                                    color: Color.fromRGBO(0, 0, 0, 0.1),
                                    blurRadius: 2,
                                    spreadRadius: 1,
                                    offset: Offset(1, 1),
                                  ),
                                ],
                              ),
                              width: 55,
                              height: 55,
                              child: SvgPicture.asset(
                                availableMaps[index].icon,
                                height: 40,
                                width: 40,
                              ),
                            ),
                          ),
                          AppUtils.kGap12,
                          Text(
                            availableMaps[index].mapName,
                            textAlign: TextAlign.center,
                            style: context.textTheme.titleMedium?.copyWith(
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                      separatorBuilder: (_, __) => AppUtils.kGap16,
                    ),
                  ),
                ],
                cancelButton: CupertinoActionSheetAction(
                  child:  Text(context.tr("cancel")),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            );
          }
        },
      );
}
