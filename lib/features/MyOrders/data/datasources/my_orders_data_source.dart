import 'package:dio/dio.dart';
import 'package:hcs/features/MyOrders/domain/models/order_details/order_details_model.dart';
import 'package:hcs/features/MyOrders/domain/models/services_order/services_order_model.dart';
import 'package:hcs/src/constants/Api/api_response.dart';
import 'package:hcs/src/constants/api_constance.dart';
import 'package:hcs/src/network/network_service.dart';

class MyOrdersDataSource {
  final NetworkService _networkService;

  MyOrdersDataSource(this._networkService);

  Future<ApiResponse<ServicesOrder>> getServicesOrders({
    required int page,
    required String status,
    required String orderSearched,
  }) async {
    try {
      final response = await _networkService.get(
        ApiConstance.myServicesOrders(),
        queryParameters: {
          'page': page,
          'limit': 10,
          'status': status,
          'search': orderSearched,
          'action': 'supervisor',
        },
      );

      return ApiResponse.fromJson(
        response.data,
        (json) => ServicesOrder.fromJson(json as Map<String, dynamic>),
      );
    } catch (e) {
      return ApiResponse.error(error: e);
    }
  }

  Future<ApiResponse<OrderDetails>> getOderDetails({
    required String serviceOrderId,
  }) async {
    try {
      final response = await _networkService.get(
        ApiConstance.getServiceOrderDetails,
        queryParameters: {'service_order_id': serviceOrderId},
      );
      return ApiResponse.fromJson(
        response.data,
        (json) => OrderDetails.fromJson(json as Map<String, dynamic>),
      );
    } catch (e) {
      return ApiResponse.error(error: e);
    }
  }

  Future<ApiResponse<List>> orderCancelltion({
    required String serviceOrderId,
  }) async {
    try {
      final data = FormData.fromMap({'service_order_id': serviceOrderId});

      final response = await _networkService.post(
        ApiConstance.orderCancelltion,
        data,
      );

      return ApiResponse.fromJson(response.data, (_) => []);
    } catch (e) {
      return ApiResponse.error(error: e);
    }
  }
}
