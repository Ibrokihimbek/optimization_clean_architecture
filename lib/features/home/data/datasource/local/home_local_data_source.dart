import "dart:convert";

import "package:pizza_hut_client_mobile/constants/constants.dart";
import "package:pizza_hut_client_mobile/core/local_source/local_source.dart";

part "home_local_data_source_impl.dart";

abstract class HomeLocalDataSource {
  const HomeLocalDataSource();

  Future<void> saveSourceSettings(
    String shipperId,
    Map<String, dynamic> json,
  );

  Map<String, dynamic>? getSourceSettings(String shipperId);
}
