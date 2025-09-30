import 'package:hcs/features/report/data/repository/report_repository.dart';
import 'package:hcs/features/report/domain/model/report_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'report_controller.g.dart';

@riverpod
class ReportController extends _$ReportController {
  List<ReportModel> _reports = [];
  int _currentPage = 1;
  int _totalPages = 1;
  @override
  FutureOr<OrdersReport?> build() async {
    return await getReport(page: 1);
  }

  Future<OrdersReport?> getReport({
    bool showLoading = true,
    required int page,
  }) async {
    try {
      if (showLoading) state = const AsyncLoading();

      final repo = ref.watch(reportRepositoryProvider);
      final response = await repo.getReport(page);
      _currentPage = response.pagination?.page ?? _currentPage;
      _totalPages = response.pagination?.totalPages ?? _totalPages;

      if (page == 1) {
        _reports = List.from(response.data?.reports ?? []);
      } else {
        _reports.addAll(response.data?.reports ?? []);
      }
      // return response.data;
      final orderReport = OrdersReport(
        reports: _reports,
        total: response.data!.total,
      );
      state = AsyncData(orderReport);
      return orderReport;
    } catch (e, st) {
      state = AsyncError(e, st);
      return null;
    }

    // final result = await AsyncValue.guard(() async {
    //   final response = await repo.getReport();
    //    _currentPage = response.pagination?.page??_currentPage;
    //   _totalPages = response.pagination?.totalPages??_totalPages;

    //   if (page == 1) {
    //     _reports =  List.from(response.data?.reports ?? []);

    //   } else {
    //     _reports.addAll(response.data?.reports ?? []);
    //   }
    //   return response.data;
    // });

    // state = result;
    // return result.valueOrNull;
  }

  Future<bool> loadNextPage() async {
    if (_currentPage >= _totalPages) return false;
    final nextPage = _currentPage + 1;
    final result = await getReport(showLoading: false, page: nextPage);
    return result?.reports.isNotEmpty ?? false;
  }

  Future<bool> refreshOrders() async {
    _reports.clear();
    _currentPage = 1;
    _totalPages = 1;
    await getReport(page: 1,showLoading: true);
    return true;
  }
}
