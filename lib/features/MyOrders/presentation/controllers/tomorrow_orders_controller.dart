import 'package:hcs/features/MyOrders/data/repositories/myorders_repository.dart';
import 'package:hcs/features/MyOrders/domain/models/services_order/services_order_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'tomorrow_orders_controller.g.dart';

@riverpod
class TomorrowOrdersController extends _$TomorrowOrdersController {
  @override
  FutureOr<List<Order>?> build() {
    return fetchTomorrowOrders(page: 1);
  }

  List<Order> _tomorrowList = [];
  int _currentPage = 1;
  int _totalPages = 1;

  String _searchQuery = '';
  String _currentStatus = 'all';

  // ---------------------------------------------------------------------------
  // FETCH ORDERS (SERVER FILTERING)
  // ---------------------------------------------------------------------------

  Future<List<Order>?> fetchTomorrowOrders({
    bool showLoading = true,
    required int page,
  }) async {
    try {
      if (showLoading) state = AsyncLoading();

      final repo = ref.watch(myOrdersRepositoryProvider);

      final response = await repo.getServicesOrders(
        page: page,
        dateType: "tomorrow",
        status: _currentStatus == "all" ? null : _currentStatus,
        orderSearched: _searchQuery.isEmpty ? null : _searchQuery,
      );

      _currentPage = response.pagination?.currentPage ?? _currentPage;
      _totalPages = response.pagination?.totalPages ?? _totalPages;

      if (response.data?.orders == null) {
        throw Exception("Failed to fetch orders");
      }

      if (page == 1) {
        _tomorrowList = List.from(response.data!.orders!);
      } else {
        _tomorrowList.addAll(response.data!.orders!);
      }

      state = AsyncData(_tomorrowList);
      return _tomorrowList;
    } catch (e, st) {
      state = AsyncError(e, st);
      return null;
    }
  }

  // ---------------------------------------------------------------------------
  // PAGINATION — RESPECT STATUS + SEARCH
  // ---------------------------------------------------------------------------

  Future<bool> onLoadMoreTomorrowOrders() async {
    if (_currentPage >= _totalPages) return false;

    final nextPage = _currentPage + 1;

    final result = await fetchTomorrowOrders(
      showLoading: false,
      page: nextPage,
    );

    return result?.isNotEmpty ?? false;
  }

  // ---------------------------------------------------------------------------
  // REFRESH — RESPECT STATUS + SEARCH
  // ---------------------------------------------------------------------------

  Future<bool> refreshTomorrow() async {
    _tomorrowList.clear();
    _currentPage = 1;
    _totalPages = 1;

    await fetchTomorrowOrders(page: 1, showLoading: true);
    return true;
  }

  // ---------------------------------------------------------------------------
  // SEARCH
  // ---------------------------------------------------------------------------

  void applySearch(String query) {
    _searchQuery = query;
    refreshTomorrow();
  }

  // ---------------------------------------------------------------------------
  // STATUS FILTER
  // ---------------------------------------------------------------------------

  void applyStatusFilter(String status) {
    _currentStatus = status;
    refreshTomorrow();
  }
}
