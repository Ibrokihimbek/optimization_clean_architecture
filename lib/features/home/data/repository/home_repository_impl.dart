part of "../../domain/repository/home_repository.dart";

class HomeRepositoryImpl implements HomeRepository {
  const HomeRepositoryImpl({
    required this.remoteSource,
    required this.localSource,
  });

  final HomeLocalDataSource localSource;
  final HomeRemoteDataSource remoteSource;

  @override
  Future<Either<Failure, List<CategoryEntity>>> getCategoriesWithProduct({
    bool isCache = false,
    required Map<String, dynamic> queryParameters,
  }) async {
    try {
      final Map<String, dynamic> result =
          await remoteSource.getCategoriesWithProduct(
        queryParameters: queryParameters,
      );
      return Right<Failure, List<CategoryEntity>>(
        CategoryWithProductResponse.fromJson(result).toEntities,
      );
    } on ServerError catch (error, stacktrace) {
      log("Exception occurred: $error stacktrace: $stacktrace");
      return Left<Failure, List<CategoryEntity>>(error.failure);
    } on Exception catch (error, stacktrace) {
      log("Exception occurred: $error stacktrace: $stacktrace");
      return Left<Failure, List<CategoryEntity>>(
        ServerError.withException(error: error).failure,
      );
    }
  }

  @override
  Future<Either<Failure, CategoryEntity>> getCategoryById({
    bool isCache = false,
    required String categoryId,
    required Map<String, dynamic> queryParameters,
  }) async {
    try {
      final Map<String, dynamic> result = await remoteSource.getCategoryById(
        categoryId: categoryId,
        queryParameters: queryParameters,
      );
      return Right<Failure, CategoryEntity>(
        Categories.fromJson(result).toEntity,
      );
    } on ServerError catch (error, stacktrace) {
      log("Exception occurred: $error stacktrace: $stacktrace");
      return Left<Failure, CategoryEntity>(error.failure);
    } on Exception catch (error, stacktrace) {
      log("Exception occurred: $error stacktrace: $stacktrace");
      return Left<Failure, CategoryEntity>(
        ServerError.withException(error: error).failure,
      );
    }
  }

  @override
  Future<Either<Failure, List<BannerEntity>>> getBanners({
    bool isCache = false,
  }) async {
    try {
      final Map<String, dynamic> result = await remoteSource.getBanners();
      return Right<Failure, List<BannerEntity>>(
        BannersResponse.fromJson(result).banners,
      );
    } on ServerError catch (error, stacktrace) {
      log("Exception occurred: $error stacktrace: $stacktrace");
      return Left<Failure, List<BannerEntity>>(error.failure);
    } on Exception catch (error, stacktrace) {
      log("Exception occurred: $error stacktrace: $stacktrace");
      return Left<Failure, List<BannerEntity>>(
        ServerError.withException(error: error).failure,
      );
    }
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getProductNonVariantModifier({
    required Map<String, dynamic> queryParameters,
  }) async {
    try {
      final Map<String, dynamic> result =
          await remoteSource.getProductNonVariantModifier(
        queryParameters: queryParameters,
      );
      return Right<Failure, List<ProductEntity>>(
        ProductsResponse.fromJson(result).toEntities,
      );
    } on ServerError catch (error, stacktrace) {
      log("Exception occurred: $error stacktrace: $stacktrace");
      return Left<Failure, List<ProductEntity>>(error.failure);
    } on Exception catch (error, stacktrace) {
      log("Exception occurred: $error stacktrace: $stacktrace");
      return Left<Failure, List<ProductEntity>>(
        ServerError.withException(error: error).failure,
      );
    }
  }

  @override
  Future<Either<Failure, List<ComboGroups>>> getCombo({
    required String comboId,
  }) async {
    try {
      final Map<String, dynamic> result = await remoteSource.getCombo(
        comboId: comboId,
      );
      return Right<Failure, List<ComboGroups>>(
        ComboResponse.fromJson(result).groups ?? <ComboGroups>[],
      );
    } on ServerError catch (error, stacktrace) {
      log("Exception occurred: $error stacktrace: $stacktrace");
      return Left<Failure, List<ComboGroups>>(error.failure);
    } on Exception catch (error, stacktrace) {
      log("Exception occurred: $error stacktrace: $stacktrace");
      return Left<Failure, List<ComboGroups>>(
        ServerError.withException(error: error).failure,
      );
    }
  }

  @override
  Future<Either<Failure, ProductByIdResponse>> getProductDetail({
    required String productId,
    required Map<String, dynamic> queryParameters,
  }) async {
    try {
      final Map<String, dynamic> result = await remoteSource.getProductDetail(
        productId: productId,
        queryParameters: queryParameters,
      );
      return Right<Failure, ProductByIdResponse>(
        ProductByIdResponse.fromJson(result),
      );
    } on ServerError catch (error, stacktrace) {
      log("Exception occurred: $error stacktrace: $stacktrace");
      return Left<Failure, ProductByIdResponse>(error.failure);
    } on Exception catch (error, stacktrace) {
      log("Exception occurred: $error stacktrace: $stacktrace");
      return Left<Failure, ProductByIdResponse>(
        ServerError.withException(error: error).failure,
      );
    }
  }

  @override
  Future<Either<Failure, List<Favourites>>> getProductFavourite({
    required Map<String, dynamic> queryParameters,
  }) async {
    try {
      final Map<String, dynamic> result =
          await remoteSource.getProductFavourites(
        queryParameters: queryParameters,
      );
      return Right<Failure, List<Favourites>>(
        ProductFavouritesResponse.fromJson(result).favourites ?? <Favourites>[],
      );
    } on ServerError catch (error, stacktrace) {
      log("Exception occurred: $error stacktrace: $stacktrace");
      return Left<Failure, List<Favourites>>(error.failure);
    } on Exception catch (error, stacktrace) {
      log("Exception occurred: $error stacktrace: $stacktrace");
      return Left<Failure, List<Favourites>>(
        ServerError.withException(error: error).failure,
      );
    }
  }

  @override
  Future<Either<Failure, ProductModifiers?>> getProductModifier({
    required Map<String, dynamic> queryParameters,
  }) async {
    try {
      final Map<String, dynamic> result = await remoteSource.getProductModifier(
        queryParameters: queryParameters,
      );
      return Right<Failure, ProductModifiers?>(
        ModifierResponse.fromJson(result).productModifiers,
      );
    } on ServerError catch (error, stacktrace) {
      log("Exception occurred: $error stacktrace: $stacktrace");
      return Left<Failure, ProductModifiers?>(error.failure);
    } on Exception catch (error, stacktrace) {
      log("Exception occurred: $error stacktrace: $stacktrace");
      return Left<Failure, ProductModifiers?>(
        ServerError.withException(error: error).failure,
      );
    }
  }

  @override
  Future<Either<Failure, List<AutoProducts>>> getAutoAddProduct({
    required Map<String, dynamic> queryParameters,
  }) async {
    try {
      final Map<String, dynamic> result = await remoteSource.getAutoAddProduct(
        queryParameters: queryParameters,
      );
      return Right<Failure, List<AutoProducts>>(
        AutoAddProductResponse.fromJson(result).products,
      );
    } on ServerError catch (error, stacktrace) {
      log("Exception occurred: $error stacktrace: $stacktrace");
      return Left<Failure, List<AutoProducts>>(error.failure);
    } on Exception catch (error, stacktrace) {
      log("Exception occurred: $error stacktrace: $stacktrace");
      return Left<Failure, List<AutoProducts>>(
        ServerError.withException(error: error).failure,
      );
    }
  }

  @override
  Future<Either<Failure, List<Sources>>> sourceSettings({
    bool isCache = false,
    required String shipperId,
  }) async {
    if (isCache) {
      final Map<String, dynamic>? sources = localSource.getSourceSettings(
        shipperId,
      );
      if (sources == null) {
        return Left<Failure, List<Sources>>(
          ServerError.withErrorMessage(error: "No data found").failure,
        );
      }
      return Right<Failure, List<Sources>>(
        SourceSettingsResponse.fromJson(sources).sources,
      );
    } else {
      try {
        final Map<String, dynamic> result = await remoteSource.sourceSettings(
          shipperId: shipperId,
        );
        await localSource.saveSourceSettings(shipperId, result);
        return Right<Failure, List<Sources>>(
          SourceSettingsResponse.fromJson(result).sources,
        );
      } on ServerError catch (error, stacktrace) {
        log("Exception occurred: $error stacktrace: $stacktrace");
        return Left<Failure, List<Sources>>(error.failure);
      } on Exception catch (error, stacktrace) {
        log("Exception occurred: $error stacktrace: $stacktrace");
        return Left<Failure, List<Sources>>(
          ServerError.withException(error: error).failure,
        );
      }
    }
  }

  @override
  Future<Either<Failure, DiscountOrderResponse>> getOrderDiscount({
    required Map<String, dynamic> queryParameters,
  }) async {
    try {
      final Map<String, dynamic> result =
          await remoteSource.getOrderDiscount(queryParameters: queryParameters);
      return Right<Failure, DiscountOrderResponse>(
        DiscountOrderResponse.fromJson(result),
      );
    } on ServerError catch (error, stacktrace) {
      log("Exception occurred: $error stacktrace: $stacktrace");
      return Left<Failure, DiscountOrderResponse>(error.failure);
    } on Exception catch (error, stacktrace) {
      log("Exception occurred: $error stacktrace: $stacktrace");
      return Left<Failure, DiscountOrderResponse>(
        ServerError.withException(error: error).failure,
      );
    }
  }

  @override
  Future<Either<Failure, List<ProductWithDiscount>>> getProductsDiscount({
    required Map<String, dynamic> queryParameters,
  }) async {
    try {
      final Map<String, dynamic> result = await remoteSource
          .getProductsDiscount(queryParameters: queryParameters);
      return Right<Failure, List<ProductWithDiscount>>(
        ProductDiscountResponse.fromJson(result).productWithDiscount ??
            <ProductWithDiscount>[],
      );
    } on ServerError catch (error, stacktrace) {
      log("Exception occurred: $error stacktrace: $stacktrace");
      return Left<Failure, List<ProductWithDiscount>>(error.failure);
    } on Exception catch (error, stacktrace) {
      log("Exception occurred: $error stacktrace: $stacktrace");
      return Left<Failure, List<ProductWithDiscount>>(
        ServerError.withException(error: error).failure,
      );
    }
  }

  @override
  Future<Either<Failure, CheckDeliveryZonesResponse>> checkDeliveryZones({
    required Map<String, dynamic> queryParameters,
  }) async {
    try {
      final Map<String, dynamic>? result =
          await remoteSource.checkPointDeliveryZones(
        queryParameters: queryParameters,
      );
      if (result == null) {
        return Left<Failure, CheckDeliveryZonesResponse>(
          ServerError.withErrorMessage(
            error: "delivery_is_not_available_here".tr(),
          ).failure,
        );
      }
      return Right<Failure, CheckDeliveryZonesResponse>(
        CheckDeliveryZonesResponse.fromJson(result),
      );
    } on ServerError catch (error, stacktrace) {
      log("Exception occurred: $error stacktrace: $stacktrace");
      return Left<Failure, CheckDeliveryZonesResponse>(error.failure);
    } on Exception catch (error, stacktrace) {
      log("Exception occurred: $error stacktrace: $stacktrace");
      return Left<Failure, CheckDeliveryZonesResponse>(
        ServerError.withException(error: error).failure,
      );
    }
  }

  @override
  Future<Either<Failure, List<BranchEntity>>> getNearBranches({
    required Map<String, dynamic> queryParameters,
  }) async {
    try {
      final Map<String, dynamic> result = await remoteSource.getNearBranches(
        queryParameters: queryParameters,
      );
      return Right<Failure, List<BranchEntity>>(
        BranchResponse.fromJson(result).toEntities,
      );
    } on ServerError catch (error, stacktrace) {
      log("Exception occurred: $error stacktrace: $stacktrace");
      return Left<Failure, List<BranchEntity>>(error.failure);
    } on Exception catch (error, stacktrace) {
      log("Exception occurred: $error stacktrace: $stacktrace");
      return Left<Failure, List<BranchEntity>>(
        ServerError.withException(error: error).failure,
      );
    }
  }

  @override
  Future<Either<Failure, OndemandOrderResponse>> createOrder({
    required OnDemandOrderRequest request,
  }) async {
    try {
      final Map<String, dynamic> result = await remoteSource.createOrder(
        request: request,
      );
      return Right<Failure, OndemandOrderResponse>(
        OndemandOrderResponse.fromJson(result),
      );
    } on ServerError catch (error, stacktrace) {
      log("Exception occurred: $error stacktrace: $stacktrace");
      return Left<Failure, OndemandOrderResponse>(error.failure);
    } on Exception catch (error, stacktrace) {
      log("Exception occurred: $error stacktrace: $stacktrace");
      return Left<Failure, OndemandOrderResponse>(
        ServerError.withException(error: error).failure,
      );
    }
  }

  @override
  Future<Either<Failure, List<DeliveryZones>>> getDeliveryZones() async {
    try {
      final Map<String, dynamic> result = await remoteSource.deliveryZones();
      return Right<Failure, List<DeliveryZones>>(
        DeliveryZonesResponse.fromJson(result).deliveryZones,
      );
    } on ServerError catch (error, stacktrace) {
      log("Exception occurred: $error stacktrace: $stacktrace");
      return Left<Failure, List<DeliveryZones>>(error.failure);
    } on Exception catch (error, stacktrace) {
      log("Exception occurred: $error stacktrace: $stacktrace");
      return Left<Failure, List<DeliveryZones>>(
        ServerError.withException(error: error).failure,
      );
    }
  }

  @override
  Future<Either<Failure, ComputePriceResponse>> computePrice({
    required ComputePriceRequest request,
  }) async {
    try {
      final Map<String, dynamic> result = await remoteSource.computePrice(
        request: request,
      );
      return Right<Failure, ComputePriceResponse>(
        ComputePriceResponse.fromJson(result),
      );
    } on ServerError catch (error, stacktrace) {
      log("Exception occurred: $error stacktrace: $stacktrace");
      return Left<Failure, ComputePriceResponse>(error.failure);
    } on Exception catch (error, stacktrace) {
      log("Exception occurred: $error stacktrace: $stacktrace");
      return Left<Failure, ComputePriceResponse>(
        ServerError.withException(error: error).failure,
      );
    }
  }

  @override
  Future<Either<Failure, NotificationEntity>> fetchNotification({
    required int page,
  }) async {
    try {
      final Map<String, dynamic> result = await remoteSource.getNotifications(
        page: page,
      );
      return Right<Failure, NotificationEntity>(
        NotificationsResponse.fromJson(result).toEntity(),
      );
    } on ServerError catch (error, stacktrace) {
      log("Exception occurred: $error stacktrace: $stacktrace");
      return Left<Failure, NotificationEntity>(error.failure);
    } on Exception catch (error, stacktrace) {
      log("Exception occurred: $error stacktrace: $stacktrace");
      return Left<Failure, NotificationEntity>(
        ServerError.withException(error: error).failure,
      );
    }
  }

  @override
  Future<Either<Failure, NotificationInfoEntity>> fetchNotificationDetail({
    required String id,
  }) async {
    try {
      final Map<String, dynamic> result =
          await remoteSource.getNotificationDetail(
        id: id,
      );
      return Right<Failure, NotificationInfoEntity>(
        Notifications.fromJson(result).toEntity(),
      );
    } on ServerError catch (error, stacktrace) {
      log("Exception occurred: $error stacktrace: $stacktrace");
      return Left<Failure, NotificationInfoEntity>(error.failure);
    } on Exception catch (error, stacktrace) {
      log("Exception occurred: $error stacktrace: $stacktrace");
      return Left<Failure, NotificationInfoEntity>(
        ServerError.withException(error: error).failure,
      );
    }
  }

  @override
  Future<Either<Failure, ShipperResponse>> getShipper({
    required String shipperId,
  }) async {
    try {
      final Map<String, dynamic> result = await remoteSource.getShipper(
        shipperId: shipperId,
      );
      return Right<Failure, ShipperResponse>(ShipperResponse.fromJson(result));
    } on ServerError catch (error, stacktrace) {
      log("Exception occurred: $error stacktrace: $stacktrace");
      return Left<Failure, ShipperResponse>(error.failure);
    } on Exception catch (error, stacktrace) {
      log("Exception occurred: $error stacktrace: $stacktrace");
      return Left<Failure, ShipperResponse>(
        ServerError.withException(error: error).failure,
      );
    }
  }

  @override
  Future<Either<Failure, ProductReviewsEntity>> getProductReviews({
    required String productId,
    required int page,
  }) async {
    try {
      final Map<String, dynamic> result = await remoteSource.getProductReviews(
        productId: productId,
        page: page,
      );
      return Right<Failure, ProductReviewsEntity>(
        ProductReviewsResponse.fromJson(result).toEntity(),
      );
    } on ServerError catch (error, stacktrace) {
      log("Exception occurred: $error stacktrace: $stacktrace");
      return Left<Failure, ProductReviewsEntity>(error.failure);
    } on Exception catch (error, stacktrace) {
      log("Exception occurred: $error stacktrace: $stacktrace");
      return Left<Failure, ProductReviewsEntity>(
        ServerError.withException(error: error).failure,
      );
    }
  }

  @override
  Future<Either<Failure, List<Tags>>> getTags({
    required Map<String, dynamic> queryParameters,
  }) async {
    try {
      final Map<String, dynamic> result = await remoteSource.getTags(
        query: queryParameters,
      );
      return Right<Failure, List<Tags>>(TagsResponse.fromJson(result).tags);
    } on ServerError catch (error, stacktrace) {
      log("Exception occurred: $error stacktrace: $stacktrace");
      return Left<Failure, List<Tags>>(error.failure);
    } on Exception catch (error, stacktrace) {
      log("Exception occurred: $error stacktrace: $stacktrace");
      return Left<Failure, List<Tags>>(
        ServerError.withException(error: error).failure,
      );
    }
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getProducts({
    required Map<String, dynamic> queryParameters,
  }) async {
    try {
      final Map<String, dynamic> result = await remoteSource.getProducts(
        queryParameters: queryParameters,
      );
      return Right<Failure, List<ProductEntity>>(
        ProductsResponse.fromJson(result).toEntities,
      );
    } on ServerError catch (error, stacktrace) {
      log("Exception occurred: $error stacktrace: $stacktrace");
      return Left<Failure, List<ProductEntity>>(error.failure);
    } on Exception catch (error, stacktrace) {
      log("Exception occurred: $error stacktrace: $stacktrace");
      return Left<Failure, List<ProductEntity>>(
        ServerError.withException(error: error).failure,
      );
    }
  }

  @override
  Future<Either<Failure, List<ProductStatus>>> getProductsStatus({
    required Map<String, dynamic> queryParameters,
  }) async {
    try {
      final Map<String, dynamic> result = await remoteSource.getProductsStatus(
        queryParameters: queryParameters,
      );
      return Right<Failure, List<ProductStatus>>(
        ProductsStatusesResponse.fromJson(result).products,
      );
    } on ServerError catch (error, stacktrace) {
      log("Exception occurred: $error stacktrace: $stacktrace");
      return Left<Failure, List<ProductStatus>>(error.failure);
    } on Exception catch (error, stacktrace) {
      log("Exception occurred: $error stacktrace: $stacktrace");
      return Left<Failure, List<ProductStatus>>(
        ServerError.withException(error: error).failure,
      );
    }
  }
}
