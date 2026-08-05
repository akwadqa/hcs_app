import 'package:flutter/material.dart';
import 'package:hcs/features/Home/deep_clean/domain/models/deep_clean_order_params.dart';
import 'package:hcs/features/Home/deep_clean/domain/models/deep_clean_service_model.dart';
import 'package:hcs/features/Home/deep_clean/domain/models/service_item_model.dart';
import 'package:hcs/src/constants/Api/api_response.dart';
import 'package:hcs/src/constants/api_constance.dart';
import 'package:hcs/src/network/network_service.dart';

import 'deep_clean_mock.dart';

class DeepCleanRemoteDataSource {
  final NetworkService _networkService;

  DeepCleanRemoteDataSource(this._networkService);

  /// GET Deep Clean services (each service has its own dynamic fields).
  Future<ApiResponse<List<ServiceItemModel>>> getServiceItems({
    required String serviceType,
  }) async {
    try {
      final response = await _networkService.get(
        ApiConstance.getServiceItems(serviceType: serviceType),
      );

      if (response.data == null || response.statusCode != 200) {
        throw Exception('Request getServiceItems failed');
      }

      return ApiResponse<List<ServiceItemModel>>.fromJson(
        response.data,
        (json) => (json as List)
            .map((e) => ServiceItemModel.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
    } catch (e) {
      debugPrint('Error in getServiceItems: $e');
      rethrow;

      // ---- MOCK FALLBACK (remove later) ----
      // return ApiResponse<List<DeepCleanServiceModel>>.fromJson(
      //   Map<String, dynamic>.from(deepCleanMockResponse),
      //   (json) => (json as List)
      //       .map((e) =>
      //           DeepCleanServiceModel.fromJson(e as Map<String, dynamic>))
      //       .toList(),
      // );
    }
  }

  /// POST create a Deep Clean order.
  Future<ApiResponse<void>> createOrder(DeepCleanOrderParams params) async {
    try {
      final response = await _networkService.post(
        ApiConstance.createDeepCleanOrder,
        params.toJson(),
      );

      if (response.data == null || response.statusCode != 200) {
        throw Exception('Request createDeepCleanOrder failed');
      }

      return ApiResponse<void>.fromJson(response.data, (_) {});
    } catch (e) {
      debugPrint('Error in createDeepCleanOrder: $e — MOCK success');

      // ---- MOCK FALLBACK (remove later) ----
      return ApiResponse<void>.success(message: 'mock order created');
    }
  }
}
