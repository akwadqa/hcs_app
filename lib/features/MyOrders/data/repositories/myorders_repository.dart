// home_repository.dart
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hcs/features/MyOrders/data/datasources/my_orders_data_source.dart';
import 'package:hcs/features/MyOrders/domain/models/appointment/appoitnment_model.dart';
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
  return MyOrdersRepository(MyOrdersDataSource(networkService),networkService);
}

class MyOrdersRepository {
  final MyOrdersDataSource _remoteDatasource;
  final NetworkService networkService;

  MyOrdersRepository(this._remoteDatasource,this.networkService);

  Future<ApiResponse<ServicesOrder>> getServicesOrders({
    required int page,
    String? status,
    String? orderSearched,
    String? dateType,
    String? date,
  }) async {
    try {
      final result = await _remoteDatasource.getServicesOrders(
        page: page,
        status: status,
        orderSearched: orderSearched,
        date: date,
        dateType: dateType,
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

  Future<AppointmentModel> getAppontments({
    required int page,
    required String orderId,
    String? dateType,
  }) async {
    final response = await networkService.get(
      ApiConstance.appontmentsLogs(),
      queryParameters: {'page': page, 'date_type': dateType},
      data: FormData.fromMap({'order_id': orderId}),
    );

    if (response.statusCode == 200) {
      print('----------------');
      print(dateType);
      print('----------------');
      return AppointmentModel.fromJson(response.data);
    } else {
      throw Exception(response.message ?? 'Failed to get Appontments');
    }
  }
}
