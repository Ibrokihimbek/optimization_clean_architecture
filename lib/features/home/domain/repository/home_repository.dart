import "dart:developer";

import "package:pizza_hut_client_mobile/core/either/either.dart";
import "package:pizza_hut_client_mobile/core/error/failure.dart";
import "package:pizza_hut_client_mobile/core/error/server_error.dart";
import "package:pizza_hut_client_mobile/core/extension/extension.dart";
import "package:pizza_hut_client_mobile/features/home/data/datasource/local/home_local_data_source.dart";
import "package:pizza_hut_client_mobile/features/home/data/datasource/remote/home_remote_data_source.dart";
import "package:pizza_hut_client_mobile/features/home/data/models/auto_add_product_response.dart";
import "package:pizza_hut_client_mobile/features/home/data/models/banners_response.dart";
import "package:pizza_hut_client_mobile/features/home/data/models/category_with_product_response.dart";
import "package:pizza_hut_client_mobile/features/home/data/models/check_point_delivery_zones_response.dart";
import "package:pizza_hut_client_mobile/features/home/data/models/combo_response.dart";
import "package:pizza_hut_client_mobile/features/home/data/models/compute_price_request.dart";
import "package:pizza_hut_client_mobile/features/home/data/models/compute_price_response.dart";
import "package:pizza_hut_client_mobile/features/home/data/models/delivery_zones_response.dart";
import "package:pizza_hut_client_mobile/features/home/data/models/discount_order_response.dart";
import "package:pizza_hut_client_mobile/features/home/data/models/discount_product_response.dart";
import "package:pizza_hut_client_mobile/features/home/data/models/modifier_response.dart";
import "package:pizza_hut_client_mobile/features/home/data/models/notifications_response.dart";
import "package:pizza_hut_client_mobile/features/home/data/models/ondemand_order_request.dart";
import "package:pizza_hut_client_mobile/features/home/data/models/ondemand_order_response.dart";
import "package:pizza_hut_client_mobile/features/home/data/models/product_by_id_response.dart";
import "package:pizza_hut_client_mobile/features/home/data/models/product_favourite_response.dart";
import "package:pizza_hut_client_mobile/features/home/data/models/product_reviews_response.dart";
import "package:pizza_hut_client_mobile/features/home/data/models/product_statuses_response.dart";
import "package:pizza_hut_client_mobile/features/home/data/models/products_response.dart";
import "package:pizza_hut_client_mobile/features/home/data/models/shipper_response.dart";
import "package:pizza_hut_client_mobile/features/home/data/models/source_settings_response.dart";
import "package:pizza_hut_client_mobile/features/home/data/models/tags_response.dart";
import "package:pizza_hut_client_mobile/features/home/domain/entities/category_entity.dart";
import "package:pizza_hut_client_mobile/features/home/domain/entities/notification_entity.dart";
import "package:pizza_hut_client_mobile/features/home/domain/entities/product_reviews_entity.dart";
import "package:pizza_hut_client_mobile/features/profile/data/models/branch_response.dart";
import "package:pizza_hut_client_mobile/features/profile/domain/entities/branch_entity.dart";

part "../../data/repository/home_repository_impl.dart";

abstract class HomeRepository {
  const HomeRepository();

  Future<Either<Failure, List<CategoryEntity>>> getCategoriesWithProduct({
    bool isCache = false,
    required Map<String, dynamic> queryParameters,
  });

  Future<Either<Failure, CategoryEntity>> getCategoryById({
    bool isCache = false,
    required String categoryId,
    required Map<String, dynamic> queryParameters,
  });

  Future<Either<Failure, List<BannerEntity>>> getBanners({
    bool isCache = false,
  });

  Future<Either<Failure, List<ProductEntity>>> getProductNonVariantModifier({
    required Map<String, dynamic> queryParameters,
  });

  Future<Either<Failure, List<ComboGroups>>> getCombo({
    required String comboId,
  });

  Future<Either<Failure, ProductByIdResponse>> getProductDetail({
    required String productId,
    required Map<String, dynamic> queryParameters,
  });

  Future<Either<Failure, List<Favourites>>> getProductFavourite({
    required Map<String, dynamic> queryParameters,
  });

  Future<Either<Failure, ProductModifiers?>> getProductModifier({
    required Map<String, dynamic> queryParameters,
  });

  Future<Either<Failure, List<AutoProducts>>> getAutoAddProduct({
    required Map<String, dynamic> queryParameters,
  });

  Future<Either<Failure, List<Sources>>> sourceSettings({
    bool isCache = false,
    required String shipperId,
  });

  Future<Either<Failure, DiscountOrderResponse>> getOrderDiscount({
    required Map<String, dynamic> queryParameters,
  });

  Future<Either<Failure, List<ProductWithDiscount>>> getProductsDiscount({
    required Map<String, dynamic> queryParameters,
  });

  Future<Either<Failure, CheckDeliveryZonesResponse>> checkDeliveryZones({
    required Map<String, dynamic> queryParameters,
  });

  Future<Either<Failure, List<BranchEntity>>> getNearBranches({
    required Map<String, dynamic> queryParameters,
  });

  Future<Either<Failure, OndemandOrderResponse>> createOrder({
    required OnDemandOrderRequest request,
  });

  Future<Either<Failure, List<DeliveryZones>>> getDeliveryZones();

  Future<Either<Failure, ComputePriceResponse>> computePrice({
    required ComputePriceRequest request,
  });

  Future<Either<Failure, NotificationEntity>> fetchNotification({
    required int page,
  });

  Future<Either<Failure, NotificationInfoEntity>> fetchNotificationDetail({
    required String id,
  });

  Future<Either<Failure, ShipperResponse>> getShipper({
    required String shipperId,
  });

  Future<Either<Failure, ProductReviewsEntity>> getProductReviews({
    required String productId,
    required int page,
  });

  Future<Either<Failure, List<Tags>>> getTags({
    required Map<String, dynamic> queryParameters,
  });

  Future<Either<Failure, List<ProductEntity>>> getProducts({
    required Map<String, dynamic> queryParameters,
  });

  Future<Either<Failure, List<ProductStatus>>> getProductsStatus({
    required Map<String, dynamic> queryParameters,
  });
}
