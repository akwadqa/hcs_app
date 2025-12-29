import 'package:hcs/features/MyOrders/data/repositories/myorders_repository.dart';
import 'package:hcs/features/MyOrders/domain/models/services_order/services_order_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'custom_date_orders_controller.g.dart';

@riverpod
class CustomDateOrdersController extends _$CustomDateOrdersController {
  String? _selectedDate;

  List<Order> _orders = [];
  int _currentPage = 1;
  int _totalPages = 1;

  String _searchQuery = '';
  String _currentStatus = 'all';

  @override
  FutureOr<List<Order>?> build() async {
    return null; // Wait until user picks date
  }

  // ---------------------------------------------------------------------------
  // FETCH ORDERS (SERVER FILTERING)
  // ---------------------------------------------------------------------------

  Future<List<Order>?> fetchOrdersForDate({
    required String? date,
    int page = 1,
    bool showLoading = true,
  }) async {
    try {
      date ??= _selectedDate;
      if (date == null) return null;

      _selectedDate = date;

      if (showLoading) state = const AsyncLoading();

      final repo = ref.read(myOrdersRepositoryProvider);

      final response = await repo.getServicesOrders(
        page: page,
        date: date,                 // custom date
        dateType: "",               // empty as per your API
        status: _currentStatus == "all" ? null : _currentStatus,
        orderSearched: _searchQuery.isEmpty ? null : _searchQuery,
      );

      _currentPage = response.pagination?.currentPage ?? 1;
      _totalPages = response.pagination?.totalPages ?? 1;

      if (page == 1) {
        _orders = List.from(response.data?.orders ?? []);
      } else {
        _orders.addAll(response.data?.orders ?? []);
      }

      state = AsyncData(_orders);
      return _orders;
    } catch (e, st) {
      state = AsyncError(e, st);
      return null;
    }
  }

  // ---------------------------------------------------------------------------
  // PAGINATION
  // ---------------------------------------------------------------------------
  Future<bool> loadMore() async {
    if (_selectedDate == null) return false;
    if (_currentPage >= _totalPages) return false;

    final nextPage = _currentPage + 1;

    final result = await fetchOrdersForDate(
      date: _selectedDate,
      page: nextPage,
      showLoading: false,
    );

    return result?.isNotEmpty ?? false;
  }

  // ---------------------------------------------------------------------------
  // REFRESH
  // ---------------------------------------------------------------------------
  Future<bool> refresh() async {
    if (_selectedDate == null) return false;

    _orders.clear();
    _currentPage = 1;
    _totalPages = 1;

    await fetchOrdersForDate(
      date: _selectedDate!,
      page: 1,
      showLoading: true,
    );

    return true;
  }

  // ---------------------------------------------------------------------------
  // SEARCH
  // ---------------------------------------------------------------------------
  void applySearch(String query) {
    _searchQuery = query;
    refresh();
  }

  // ---------------------------------------------------------------------------
  // STATUS FILTER
  // ---------------------------------------------------------------------------
  void applyStatusFilter(String status) {
    _currentStatus = status;
    refresh();
  }
}


  //   Future<void> fetchOrdersForDate(String yyyymmdd) async {
  //   state = state.copyWith(
  //     customOrdersState: RequestStates.loading,
  //     lastCustomDate: yyyymmdd,
  //   );
  //   try {
  //     final repo = ref.read(myOrdersRepositoryProvider);
  //     final resp = await repo.getServicesOrders(
  //       page: 1,
  //       dateType: '',
  //       date: yyyymmdd, // <— pass the specific date
  //     );

  //     // final next = resp.pagination.totalPages > 1 ? 2 : null;
  //     state = state.copyWith(
  //       // currentCustomOrdersPage: next,
  //       customOrders: resp.data.orders,
  //       customOrdersState: RequestStates.loaded,
  //     );
  //   } catch (e) {
  //     state = state.copyWith(
  //       customOrdersState: RequestStates.error,
  //       ordersMessage: e.toString(),
  //     );
  //   }
  // }

  // Future<void> refetchCustomDate() async {
  //   final d = state.lastCustomDate;
  //   if (d != null) await fetchOrdersForDate(d);
  // }

  // // Optional if you need infinite scroll for custom date

  // Future<void> onLoadMoreCustomDate() async {
  //   final nextPage = state.currentCustomOrdersPage;
  //   if (nextPage == null) return;
  //   try {
  //     final repo = ref.read(myOrdersRepositoryProvider);
  //     final resp = await repo.getServicesOrders(
  //       page: nextPage,
  //       dateType: '',
  //       date: state.lastCustomDate,
  //     );
  //     final next = resp.pagination.totalPages > resp.pagination.page
  //         ? resp.pagination.page + 1
  //         : null;
  //     state = state.copyWith(
  //       currentCustomOrdersPage: next,
  //       customOrders: [...state.customOrders, ...resp.data.orders],
  //       customOrdersState: RequestStates.loaded,
  //     );
  //   } catch (e) {
  //     state = state.copyWith(
  //       customOrdersState: RequestStates.error,
  //       ordersMessage: e.toString(),
  //     );
  //   }
  // }


  // Future<List<Order>?> fetchApprovedOrders({
  //   bool showLoading = true,
  //   required int page,
  //   String? orderShared
  // }) async {
  //   try {
  //     if (showLoading) state = AsyncLoading();
  //     final repo = ref.watch(myOrdersRepositoryProvider);
  //     final response = await repo.getServicesOrders(
  //       page: page,
  //       // status: 'Approved',
  //       dateType:"today" ,
  //       orderSearched: orderShared,
  //     );
  //     _currentPage = response.pagination?.currentPage ?? _currentPage;
  //     _totalPages = response.pagination?.totalPages ?? _totalPages;

  //     if (response.data == null || response.data?.orders == null) {
  //       throw Exception('Failed to fetch orders');
  //     }

  //     if (page == 1) {
  //       _acceptList = List.from(response.data?.orders ?? []);
  //     } else {
  //       // _acceptList.addAll([..._acceptList , ...response.data!.orders!]);
  //       _acceptList.addAll(response.data?.orders ?? []);
  //     }
  //     state = AsyncData(_acceptList);
  //     return _acceptList;
  //   } catch (e, st) {
  //     state = AsyncError(e, st);
  //     return null;
  //   }
  // }

  // Future<bool> onLoadMoreApprovedOrders() async {
  //   if (_currentPage >= _totalPages) return false;
  //   final nextPage = _currentPage + 1;
  //   final result = await fetchApprovedOrders(
  //     showLoading: false,
  //     page: nextPage,
  //   );

  //   return result?.isNotEmpty ?? false;
  // }

  //   Future<bool> refreshApproved() async {
  //   _acceptList.clear();
  //   _currentPage = 1;
  //   _totalPages = 1;
  //   await fetchApprovedOrders(page: 1, showLoading: true);
  //   return true;
  // }

