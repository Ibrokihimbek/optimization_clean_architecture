part of "home_remote_data_source.dart";

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  const HomeRemoteDataSourceImpl({required this.dio});

  final Dio dio;

  @override
  Future<List<CurrencyResponseModel>> getCurrency() async {
    try {
      final response = await dio.get(
        Constants.baseUrl + Urls.exChange,
      );
      final int statusCode = response.statusCode ?? 500;
      if (statusCode >= 200 && statusCode < 300) {
        List json = response.data as List;
        return json.map((e) => CurrencyResponseModel.fromJson(e)).toList();
      } else {
        throw ServerError.withError(error: response.data);
      }
    } on DioException catch (error, stacktrace) {
      log("Exception occurred: $error stacktrace: $stacktrace");
      throw ServerError.withDioError(error: error);
    } on Exception catch (error, stacktrace) {
      log("Exception occurred: $error stacktrace: $stacktrace");
      throw ServerError.withException(error: error);
    }
  }
}
