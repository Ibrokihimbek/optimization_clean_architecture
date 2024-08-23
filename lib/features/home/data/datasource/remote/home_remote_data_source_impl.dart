part of "home_remote_data_source.dart";

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  const HomeRemoteDataSourceImpl({required this.dio});

  final Dio dio;

  @override
  Future<Map<String, dynamic>> getCategoriesWithProduct({
    required Map<String, dynamic> queryParameters,
  }) async {
    try {
      final Response<dynamic> response = await dio.get(
        Constants.baseUrl + Urls.categoryProducts,
        queryParameters: queryParameters,
      );
      final int statusCode = response.statusCode ?? 500;
      if (statusCode >= 200 && statusCode < 300) {
        return response.data;
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

  @override
  Future<Map<String, dynamic>> getCategoryById({
    required String categoryId,
    required Map<String, dynamic> queryParameters,
  }) async {
    try {
      final Response<dynamic> response = await dio.get(
        "${Constants.baseUrl}${Urls.categoryChildren}/$categoryId",
        queryParameters: queryParameters,
      );
      final int statusCode = response.statusCode ?? 500;
      if (statusCode >= 200 && statusCode < 300) {
        return response.data;
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

  @override
  Future<Map<String, dynamic>> getBanners() async {
    try {
      final Response<dynamic> response = await dio.get(
        "${Constants.baseUrl}${Urls.banner}",
        queryParameters: <String, int>{"page": 1, "limit": 100},
      );
      final int statusCode = response.statusCode ?? 500;
      if (statusCode >= 200 && statusCode < 300) {
        return response.data;
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

  @override
  Future<Map<String, dynamic>> getProductNonVariantModifier({
    required Map<String, dynamic> queryParameters,
  }) async {
    try {
      final Response<dynamic> response = await dio.get(
        "${Constants.baseUrl}${Urls.productNonVariant}",
        queryParameters: queryParameters,
      );
      final int statusCode = response.statusCode ?? 500;
      if (statusCode >= 200 && statusCode < 300) {
        return response.data is String
            ? jsonDecode(response.data)
            : response.data;
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

  @override
  Future<Map<String, dynamic>> getCombo({
    required String comboId,
  }) async {
    try {
      final Response<dynamic> response = await dio.get(
        "${Constants.baseUrl}${Urls.combo}$comboId",
        options: Options(
          headers: <String, String>{
            "Shipper": Constants.shipperId,
            "Authorization": localSource.accessToken,
          },
        ),
      );
      final int statusCode = response.statusCode ?? 500;
      if (statusCode >= 200 && statusCode < 300) {
        return response.data;
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

  @override
  Future<Map<String, dynamic>> getProductDetail({
    required String productId,
    required Map<String, dynamic> queryParameters,
  }) async {
    try {
      final Response<dynamic> response = await dio.get(
        "${Constants.baseUrl}${Urls.product}/$productId",
        queryParameters: queryParameters,
      );
      final int statusCode = response.statusCode ?? 500;
      if (statusCode >= 200 && statusCode < 300) {
        return response.data;
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

  @override
  Future<Map<String, dynamic>> getProductFavourites({
    required Map<String, dynamic> queryParameters,
  }) async {
    try {
      final Response<dynamic> response = await dio.get(
        "${Constants.baseUrl}${Urls.productFavourites}",
        queryParameters: queryParameters,
      );
      final int statusCode = response.statusCode ?? 500;
      if (statusCode >= 200 && statusCode < 300) {
        return response.data;
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

  @override
  Future<Map<String, dynamic>> getProductModifier({
    required Map<String, dynamic> queryParameters,
  }) async {
    try {
      final Response<dynamic> response = await dio.get(
        "${Constants.baseUrl}${Urls.productModifier}",
        queryParameters: queryParameters,
      );
      final int statusCode = response.statusCode ?? 500;
      if (statusCode >= 200 && statusCode < 300) {
        return response.data;
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

  @override
  Future<Map<String, dynamic>> getAutoAddProduct({
    required Map<String, dynamic> queryParameters,
  }) async {
    try {
      final Response<dynamic> response = await dio.get(
        "${Constants.baseUrl}${Urls.autoAddProduct}",
        queryParameters: queryParameters,
      );
      final int statusCode = response.statusCode ?? 500;
      if (statusCode >= 200 && statusCode < 300) {
        return response.data;
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

  @override
  Future<Map<String, dynamic>> sourceSettings({
    required String shipperId,
  }) async {
    try {
      final Response<dynamic> response = await dio.get(
        "${Constants.baseUrl}${Urls.sourceSettings}/$shipperId",
      );
      final int statusCode = response.statusCode ?? 500;
      if (statusCode >= 200 && statusCode < 300) {
        return response.data;
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

  @override
  Future<Map<String, dynamic>> getOrderDiscount({
    required Map<String, dynamic> queryParameters,
  }) async {
    try {
      final Response<dynamic> response = await dio.get(
        "${Constants.baseUrl}${Urls.discountOrder}",
        options: Options(
          headers: <String, String>{
            "Shipper": Constants.shipperId,
            "Authorization": localSource.accessToken,
          },
        ),
        queryParameters: queryParameters,
      );
      final int statusCode = response.statusCode ?? 500;
      if (statusCode >= 200 && statusCode < 300) {
        return response.data is String ? <String, dynamic>{} : response.data;
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

  @override
  Future<Map<String, dynamic>> getProductsDiscount({
    required Map<String, dynamic> queryParameters,
  }) async {
    try {
      final Response<dynamic> response = await dio.get(
        "${Constants.baseUrl}${Urls.discountProducts}",
        options: Options(
          headers: <String, String>{"Authorization": localSource.accessToken},
        ),
        queryParameters: queryParameters,
      );
      final int statusCode = response.statusCode ?? 500;
      if (statusCode >= 200 && statusCode < 300) {
        return response.data;
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

  @override
  Future<Map<String, dynamic>?> checkPointDeliveryZones({
    required Map<String, dynamic> queryParameters,
  }) async {
    try {
      final Response<dynamic> response = await dio.get(
        "${Constants.baseUrl}${Urls.checkPointDeliveryZones}",
        queryParameters: queryParameters,
      );
      final int statusCode = response.statusCode ?? 500;
      if (statusCode >= 200 && statusCode < 300) {
        if (response.data is String) {
          return null;
        }
        return response.data;
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

  @override
  Future<Map<String, dynamic>> getNearBranches({
    required Map<String, dynamic> queryParameters,
  }) async {
    try {
      final Response<dynamic> response = await dio.get(
        "${Constants.baseUrl}${Urls.nearestBranch}",
        options: Options(
          headers: <String, String>{"Authorization": localSource.accessToken},
        ),
        queryParameters: queryParameters,
      );
      final int statusCode = response.statusCode ?? 500;
      if (statusCode >= 200 && statusCode < 300) {
        return response.data;
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

  @override
  Future<Map<String, dynamic>> createOrder({
    required OnDemandOrderRequest request,
  }) async {
    try {
      final Response<dynamic> response = await dio.post(
        "${Constants.baseUrl}${Urls.createOrder}",
        options: Options(
          headers: <String, String>{"Authorization": localSource.accessToken},
        ),
        data: request.toJson(),
      );
      final int statusCode = response.statusCode ?? 500;
      if (statusCode >= 200 && statusCode < 300) {
        return response.data;
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

  @override
  Future<Map<String, dynamic>> deliveryZones() async {
    try {
      final Response<dynamic> response = await dio.get(
        "${Constants.baseUrl}${Urls.deliveryZones}",
      );
      final int statusCode = response.statusCode ?? 500;
      if (statusCode >= 200 && statusCode < 300) {
        return response.data;
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

  @override
  Future<Map<String, dynamic>> computePrice({
    required ComputePriceRequest request,
  }) async {
    try {
      final Response<dynamic> response = await dio.patch(
        "${Constants.baseUrl}${Urls.computePrice}",
        options: Options(
          headers: <String, String>{"Authorization": localSource.accessToken},
        ),
        data: request.toJson(),
      );
      final int statusCode = response.statusCode ?? 500;
      if (statusCode >= 200 && statusCode < 300) {
        return response.data;
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

  @override
  Future<Map<String, dynamic>> getNotifications({
    required int page,
  }) async {
    try {
      final Response<dynamic> response = await dio.get(
        "${Constants.baseUrl}${Urls.notifications}",
        queryParameters: <String, int>{
          "page": page,
          "limit": 10,
        },
        options: Options(
          headers: <String, String>{"Authorization": localSource.accessToken},
        ),
      );
      final int statusCode = response.statusCode ?? 500;
      if (statusCode >= 200 && statusCode < 300) {
        return response.data;
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

  @override
  Future<Map<String, dynamic>> getNotificationDetail({
    required String id,
  }) async {
    try {
      final Response<dynamic> response = await dio.get(
        "${Constants.baseUrl}${Urls.notifications}/$id",
        options: Options(
          headers: <String, String>{"Authorization": localSource.accessToken},
        ),
      );
      final int statusCode = response.statusCode ?? 500;
      if (statusCode >= 200 && statusCode < 300) {
        return response.data;
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

  @override
  Future<Map<String, dynamic>> getShipper({required String shipperId}) async {
    try {
      final Response<dynamic> response = await dio.get(
        "${Constants.baseUrl}${Urls.shippers}/$shipperId",
      );
      final int statusCode = response.statusCode ?? 500;
      if (statusCode >= 200 && statusCode < 300) {
        return response.data;
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

  @override
  Future<Map<String, dynamic>> getProductReviews({
    required String productId,
    required int page,
  }) async {
    try {
      final Response<dynamic> response = await dio.get(
        "${Constants.baseUrl}${Urls.userReview}",
        queryParameters: <String, dynamic>{
          "product_id": productId,
          "related_subject": "product",
          "page": page,
          "limit": 10,
        },
        options: Options(
          headers: <String, String>{"Authorization": localSource.accessToken},
        ),
      );
      final int statusCode = response.statusCode ?? 500;
      if (statusCode >= 200 && statusCode < 300) {
        return response.data;
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

  @override
  Future<Map<String, dynamic>> getTags({
    required Map<String, dynamic> query,
  }) async {
    try {
      final Response<dynamic> response = await dio.get(
        "${Constants.baseUrl}${Urls.tags}",
        queryParameters: query,
      );
      final int statusCode = response.statusCode ?? 500;
      if (statusCode >= 200 && statusCode < 300) {
        return response.data;
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

  @override
  Future<Map<String, dynamic>> getProducts({
    required Map<String, dynamic> queryParameters,
  }) async {
    try {
      final Response<dynamic> response = await dio.get(
        "${Constants.baseUrl}${Urls.product}",
        queryParameters: queryParameters,
      );
      final int statusCode = response.statusCode ?? 500;
      if (statusCode >= 200 && statusCode < 300) {
        return response.data;
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

  @override
  Future<Map<String, dynamic>> getProductsStatus({
    required Map<String, dynamic> queryParameters,
  }) async {
    try {
      final Response<dynamic> response = await dio.get(
        "${Constants.baseUrl}${Urls.menuProducts}",
        options: Options(
          headers: <String, String>{"Authorization": localSource.accessToken},
        ),
        queryParameters: queryParameters,
      );
      final int statusCode = response.statusCode ?? 500;
      if (statusCode >= 200 && statusCode < 300) {
        return response.data;
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
