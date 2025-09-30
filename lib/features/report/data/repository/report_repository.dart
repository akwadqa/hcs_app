import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hcs/features/report/data/datasources/report_datasource.dart';
import 'package:hcs/features/report/domain/model/report_model.dart';
import 'package:hcs/src/constants/Api/api_response.dart';
import 'package:hcs/src/network/network_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'report_repository.g.dart';

@Riverpod(keepAlive: true)
ReportRepository reportRepository(Ref ref) {
  final networkServices = ref.watch(networkServiceProvider());
  return ReportRepository(ReportRemoteDatasource(networkServices));
}

class ReportRepository {
  final ReportRemoteDatasource _remoteDatasource;

  ReportRepository(this._remoteDatasource);

  Future<ApiResponse<OrdersReport>> getReport(int page) async {
    try {
      final result = await _remoteDatasource.getReport(page);

      if (result.hasFailed) {
        throw Exception(result.message ?? 'Failed to fetch Reports');
      }

      return result;
    } catch (e) {
      throw Exception('Failed to Get Reports: $e');
    }
  }
}
