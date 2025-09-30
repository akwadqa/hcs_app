// import 'package:hcs/features/MyOrders/domain/models/services_orders_model.dart';
// import 'package:hcs/src/constants/Api/api_response.dart';
// import 'package:hcs/src/constants/api_constance.dart';
// import 'package:hcs/src/network/network_service.dart';

// class MyOrdersDataSource {
//   final NetworkService _networkService;

//   MyOrdersDataSource(this._networkService);

//   Future<ApiResponse<List<Orders>>> getServicesOrders({
//     required int page,
//     required String status,
//     required String orderSearched,
//   }) async {
//     try {
//       final response = await _networkService.get(
//         ApiConstance.myServicesOrders(
//           page: page.toString(),

//           status: status,
//           orderSearched: orderSearched,
//         ),
//       );

//       return ApiResponse.fromJson(
//         response.data,
//         (json) =>( json as List).map((e)=> Orders.fromJson(e)).toList() ,
//       )
//     } catch (e) {}
//   }
// }
