import "dart:convert";
import "dart:developer";

import "package:dio/dio.dart";
import "package:pizza_hut_client_mobile/constants/constants.dart";
import "package:pizza_hut_client_mobile/core/error/server_error.dart";
import "package:pizza_hut_client_mobile/features/home/data/models/compute_price_request.dart";
import "package:pizza_hut_client_mobile/features/home/data/models/ondemand_order_request.dart";
import "package:pizza_hut_client_mobile/injector_container.dart";

part "home_remote_data_source_impl.dart";

abstract class HomeRemoteDataSource {
  const HomeRemoteDataSource();

  Future<Map<String, dynamic>> getCategoriesWithProduct({
    required Map<String, dynamic> queryParameters,
  });

  Future<Map<String, dynamic>> getCategoryById({
    required String categoryId,
    required Map<String, dynamic> queryParameters,
  });

  Future<Map<String, dynamic>> getBanners();

  Future<Map<String, dynamic>> getProductNonVariantModifier({
    required Map<String, dynamic> queryParameters,
  });

  /// get combo
  Future<Map<String, dynamic>> getCombo({
    required String comboId,
  });

  /// get product detail
  Future<Map<String, dynamic>> getProductDetail({
    required String productId,
    required Map<String, dynamic> queryParameters,
  });

  /// get product favourites
  Future<Map<String, dynamic>> getProductFavourites({
    required Map<String, dynamic> queryParameters,
  });

  /// get product modifier
  Future<Map<String, dynamic>> getProductModifier({
    required Map<String, dynamic> queryParameters,
  });

  /// auto to product to order
  Future<Map<String, dynamic>> getAutoAddProduct({
    required Map<String, dynamic> queryParameters,
  });

  /// payment type and operator call settings
  Future<Map<String, dynamic>> sourceSettings({
    required String shipperId,
  });

  /// Get order discount and order promo-code
  Future<Map<String, dynamic>> getOrderDiscount({
    required Map<String, dynamic> queryParameters,
  });

  /// Get order discount and order promo-code
  Future<Map<String, dynamic>> getProductsDiscount({
    required Map<String, dynamic> queryParameters,
  });

  /// check point delivery zones
  Future<Map<String, dynamic>?> checkPointDeliveryZones({
    required Map<String, dynamic> queryParameters,
  });

  /// get nearest branches
  Future<Map<String, dynamic>> getNearBranches({
    required Map<String, dynamic> queryParameters,
  });

  /// v2/ondemand-order
  Future<Map<String, dynamic>> createOrder({
    required OnDemandOrderRequest request,
  });

  /// delivery zones
  Future<Map<String, dynamic>> deliveryZones();

  /// v1/fares/compute-price
  Future<Map<String, dynamic>> computePrice({
    required ComputePriceRequest request,
  });

  /// get notifications
  Future<Map<String, dynamic>> getNotifications({
    required int page,
  });

  Future<Map<String, dynamic>> getNotificationDetail({
    required String id,
  });

  /// v1/shippers/{shipper_id}
  Future<Map<String, dynamic>> getShipper({required String shipperId});

  /// v1/tags
  Future<Map<String, dynamic>> getTags({
    required Map<String, dynamic> query,
  });

  /// product review
  Future<Map<String, dynamic>> getProductReviews({
    required String productId,
    required int page,
  });

  /// all product
  Future<Map<String, dynamic>> getProducts({
    required Map<String, dynamic> queryParameters,
  });

  /// get product status
  Future<Map<String, dynamic>> getProductsStatus({
    required Map<String, dynamic> queryParameters,
  });
}
