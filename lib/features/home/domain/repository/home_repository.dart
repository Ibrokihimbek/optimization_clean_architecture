import "dart:developer";

import "package:currency_clean_architecture/core/either/either.dart";
import "package:currency_clean_architecture/core/error/failure.dart";
import "package:currency_clean_architecture/core/error/server_error.dart";
import "package:currency_clean_architecture/core/extension/extension.dart";
import "package:currency_clean_architecture/features/home/data/datasource/local/home_local_data_source.dart";
import "package:currency_clean_architecture/features/home/data/datasource/remote/home_remote_data_source.dart";
import "package:currency_clean_architecture/features/home/data/models/currency_response_model.dart";

part "../../data/repository/home_repository_impl.dart";

abstract class HomeRepository {
  const HomeRepository();

  Future<Either<Failure, List<CurrencyResponseModel>>> getCurrency();
}
