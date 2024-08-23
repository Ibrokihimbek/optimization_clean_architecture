part of "../../domain/repository/home_repository.dart";

class HomeRepositoryImpl implements HomeRepository {
  const HomeRepositoryImpl({
    required this.remoteSource,
    required this.localSource,
  });

  final HomeLocalDataSource localSource;
  final HomeRemoteDataSource remoteSource;

  @override
  Future<Either<Failure, List<CurrencyResponseModel>>> getCurrency() async {
    try {
      final result = await remoteSource.getCurrency();
      return Right<Failure, List<CurrencyResponseModel>>(
        result,
      );
    } on ServerError catch (error, stacktrace) {
      log("Exception occurred: $error stacktrace: $stacktrace");
      return Left<Failure, List<CurrencyResponseModel>>(error.failure);
    } on Exception catch (error, stacktrace) {
      log("Exception occurred: $error stacktrace: $stacktrace");
      return Left<Failure, List<CurrencyResponseModel>>(
        ServerError.withException(error: error).failure,
      );
    }
  }
}
