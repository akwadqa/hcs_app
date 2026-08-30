import 'package:hcs/features/report/domain/model/report_model.dart';
import 'package:hcs/src/constants/api/api_response.dart';
import 'package:hcs/src/constants/api_constance.dart';
import 'package:hcs/src/network/services/dio_client.dart';
import 'package:hcs/src/network/services/network_service.dart';
class ReportRemoteDatasource {
  final NetworkService _networkService;

  ReportRemoteDatasource(this._networkService);

  Future<ApiResponse<OrdersReport>> getReport(int page) async {
    try {
      final response = await _networkService.get(
        ApiConstance.getReport,
        queryParameters: {'action': 'supervisor', 'page': page},
      );
      return ApiResponse.fromJson(
        response.data,
        (json) => OrdersReport.fromJson(json as Map<String, dynamic>),
      );
    } catch (e) {
      return ApiResponse.error(message: e.toString());
    }
  }
}
