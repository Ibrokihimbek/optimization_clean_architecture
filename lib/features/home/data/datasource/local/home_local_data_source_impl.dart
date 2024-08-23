part of "home_local_data_source.dart";

class HomeLocalDataSourceImpl implements HomeLocalDataSource {
  const HomeLocalDataSourceImpl({
    required this.localSource,
  });

  final LocalSource localSource;

  @override
  Map<String, dynamic>? getSourceSettings(String shipperId) {
    final String json = localSource.getKey(Urls.sourceSettings + shipperId);
    if (json.isNotEmpty) {
      return jsonDecode(json) as Map<String, dynamic>;
    }
    return null;
  }

  @override
  Future<void> saveSourceSettings(
    String shipperId,
    Map<String, dynamic> json,
  ) async {
    await localSource.setKey(Urls.sourceSettings + shipperId, jsonEncode(json));
  }
}
