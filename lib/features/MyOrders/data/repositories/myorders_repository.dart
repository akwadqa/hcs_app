// home_repository.dart
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hcs/features/MyOrders/data/datasources/my_orders_data_source.dart';
import 'package:hcs/features/MyOrders/domain/models/order_details/order_details_model.dart';
import 'package:hcs/features/MyOrders/domain/models/services_order/services_order_model.dart';
import 'package:hcs/src/constants/Api/api_response.dart';
import 'package:hcs/src/constants/api_constance.dart';
import 'package:hcs/src/network/network_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'myorders_repository.g.dart';

@Riverpod(keepAlive: true)
MyOrdersRepository myOrdersRepository(Ref ref) {
  final networkService = ref.watch(networkServiceProvider());
  return MyOrdersRepository(MyOrdersDataSource(networkService));
}

class MyOrdersRepository {
  final MyOrdersDataSource _remoteDatasource;

  MyOrdersRepository(this._remoteDatasource);

  Future<ApiResponse<ServicesOrder>> getServicesOrders({
    required int page,
    required String status,
    required String orderSearched,
  }) async {
    try {
      final result = await _remoteDatasource.getServicesOrders(
        page: page,
        status: status,
        orderSearched: orderSearched,
      );
      if (result.hasFailed) {
        throw Exception(result.message ?? 'Failed to fetch Orders');
      }
      return result;
    } catch (e) {
      throw Exception('Failed to fetch Orders : $e');
    }

  }

  Future<ApiResponse<OrderDetails>> getServicesOrderDetails({
    required String serviceOrderId,
  }) async {
    try {
      final result = await _remoteDatasource.getOderDetails(
        serviceOrderId: serviceOrderId,
      );
      if (result.hasFailed) {
        throw Exception(result.message ?? 'Failed to fetch Order Details');
      }
      return result;
    } catch (e) {
      throw Exception('Failed to fetch Order Details : $e');
    }

  }

  Future<ApiResponse<List>> orderCancelltion({
    required String serviceOrderId,
  }) async {
    try {
      final response = await _remoteDatasource.orderCancelltion(
        serviceOrderId: serviceOrderId,
      );

      if (response.hasFailed) {
        throw Exception(response.message ?? 'Failed to cancel order');
      }
      return response;
    } catch (e) {
      throw Exception('Failed to cancel order : $e');
    }
  }
}
