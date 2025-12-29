import 'package:hcs/features/MyOrders/data/repositories/myorders_repository.dart';
import 'package:hcs/features/MyOrders/domain/models/services_order/services_order_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'today_orders_controller.g.dart';

@riverpod
class TodayOrdersController extends _$TodayOrdersController {
  @override
  FutureOr<List<Order>?> build() {
    return fetchTodayOrders(page: 1);
  }
  List<Order> _todayList = [];


  int _currentPage = 1;
  int _totalPages = 1;

    /// current selected filter: all | approved | pending | cancelled
  String _searchQuery = '';
  String _currentStatus = 'all'; 

  // ---------------------------------------------------------------------------
  // FETCH ORDERS
  // ---------------------------------------------------------------------------

  // ---------------------------------------------------------------------------
  // FETCH ORDERS (SERVER FILTERING)
  // ---------------------------------------------------------------------------

  Future<List<Order>?> fetchTodayOrders({
    bool showLoading = true,
    required int page,
  }) async {
    try {
      if (showLoading) state = AsyncLoading();

      final repo = ref.watch(myOrdersRepositoryProvider);

      final response = await repo.getServicesOrders(
        page: page,
        dateType: "today",
        orderSearched: _searchQuery.isEmpty ? null : _searchQuery,
        status: _currentStatus == "all" ? null : _currentStatus,
      );

      _currentPage = response.pagination?.currentPage ?? _currentPage;
      _totalPages = response.pagination?.totalPages ?? _totalPages;

      if (response.data?.orders == null) {
        throw Exception("Failed to fetch orders");
      }

      if (page == 1) {
        _todayList = List.from(response.data!.orders!);
      } else {
        _todayList.addAll(response.data!.orders!);
      }

      state = AsyncData(_todayList);
      return _todayList;
    } catch (e, st) {
      state = AsyncError(e, st);
      return null;
    }
  }

  // ---------------------------------------------------------------------------
  // PAGINATION — RESPECT FILTER + SEARCH
  // ---------------------------------------------------------------------------

  Future<bool> onLoadMoreTodayOrders() async {
    if (_currentPage >= _totalPages) return false;

    final nextPage = _currentPage + 1;

    final result = await fetchTodayOrders(
      showLoading: false,
      page: nextPage,
    );

    return result?.isNotEmpty ?? false;
  }

  // ---------------------------------------------------------------------------
  // REFRESH — RESPECT FILTER + SEARCH
  // ---------------------------------------------------------------------------

  Future<bool> refreshToday() async {
    _todayList.clear();
    _currentPage = 1;
    _totalPages = 1;

    await fetchTodayOrders(page: 1, showLoading: true);
    return true;
  }

  // ---------------------------------------------------------------------------
  // SEARCH
  // ---------------------------------------------------------------------------

  void applySearch(String query) {
    _searchQuery = query;
    refreshToday(); // REFRESH with new query
  }

  // ---------------------------------------------------------------------------
  // FILTER BY STATUS (SERVER SIDE)
  // ---------------------------------------------------------------------------

  void applyStatusFilter(String status) {
    _currentStatus = status; 
    refreshToday(); // Re-fetch from API with new status
  }
}
