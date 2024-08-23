import "dart:developer";

import "package:currency_clean_architecture/features/home/data/models/currency_response_model.dart";
import "package:dio/dio.dart";
import "package:currency_clean_architecture/constants/constants.dart";
import "package:currency_clean_architecture/core/error/server_error.dart";

part "home_remote_data_source_impl.dart";

abstract class HomeRemoteDataSource {
  const HomeRemoteDataSource();

  Future<List<CurrencyResponseModel>> getCurrency();
}
