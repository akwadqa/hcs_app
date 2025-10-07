import 'package:hcs/features/MyOrders/data/repositories/myorders_repository.dart';
import 'package:hcs/features/MyOrders/domain/models/order_details/order_details_model.dart';
import 'package:hcs/features/MyOrders/domain/models/services_order/services_order_model.dart';
import 'package:hcs/features/MyOrders/presentation/controllers/myorders_state.dart';
import 'package:hcs/src/enums/request_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'myorders_controller.g.dart';

@riverpod
class MyOrdersController extends _$MyOrdersController {
  @override
  FutureOr<List<Order>?> build() {
    return fetchApprovedOrders(page: 1);
  }

  List<Order> _pendingList = [];
  List<Order> _acceptList = [];
  List<Order> _cancelledList = [];
  String _orderShared = '';
  int _currentPage = 1;
  int _totalPages = 1;

  Future<List<Order>?> fetchApprovedOrders({
    bool showLoading = true,
    required int page,
  }) async {
    try {
      if (showLoading) state = AsyncLoading();
      final repo = ref.watch(myOrdersRepositoryProvider);
      final response = await repo.getServicesOrders(
        page: page,
        status: 'Approved',
        orderSearched: _orderShared,
      );
      _currentPage = response.pagination?.currentPage ?? _currentPage;
      _totalPages = response.pagination?.totalPages ?? _totalPages;

      if (response.data == null || response.data?.orders == null) {
        throw Exception('Failed to fetch orders');
      }

      if (page == 1) {
        _acceptList = List.from(response.data?.orders ?? []);
      } else {
        // _acceptList.addAll([..._acceptList , ...response.data!.orders!]);
        _acceptList.addAll(response.data?.orders ?? []);
      }
      state = AsyncData(_acceptList);
      return _acceptList;
    } catch (e, st) {
      state = AsyncError(e, st);
      return null;
    }
  }

  Future<bool> onLoadMoreApprovedOrders() async {
    if (_currentPage >= _totalPages) return false;
    final nextPage = _currentPage + 1;
    final result = await fetchApprovedOrders(
      showLoading: false,
      page: nextPage,
    );

    return result?.isNotEmpty ?? false;
  }

  Future<List<Order>?> fetchPendingOrders({
    bool showLoading = true,
    required int page,
  }) async {
    try {
      if (showLoading) state = AsyncLoading();
      final repo = ref.watch(myOrdersRepositoryProvider);
      final response = await repo.getServicesOrders(
        page: page,
        status: 'Pending',
        orderSearched: _orderShared,
      );
      _currentPage = response.pagination?.currentPage ?? _currentPage;
      _totalPages = response.pagination?.totalPages ?? _totalPages;
      if (response.data == null || response.data?.orders == null) {
        throw Exception('Failed to fetch orders');
      }
      if (page == 1) {
        _pendingList = List.from(response.data?.orders ?? []);
      } else {
        _pendingList.addAll(response.data?.orders ?? []);
      }
      state = AsyncData(_pendingList);
      return _pendingList;
    } catch (e, st) {
      state = AsyncError(e, st);
      return null;
    }
  }

  Future<bool> onLoadMorePendingOrders() async {
    if (_currentPage >= _totalPages) return false;
    final nextPage = _currentPage + 1;
    final result = await fetchPendingOrders(showLoading: false, page: nextPage);

    return result?.isNotEmpty ?? false;
  }

  searchOrder({required String searchedOrder, required int tabIndex}) {
    // state = state.copyWith(orderSearchedFor: searchedOrder);
    _orderShared = searchedOrder;
    switch (tabIndex) {
      case 0:
        fetchApprovedOrders(page: 1);
        break;

      case 1:
        fetchPendingOrders(page: 1);
        break;

      case 2:
        fetchCancelledOrders(page: 1);
        break;
      default:
        fetchApprovedOrders(page: 1);
    }
  }

  Future<List<Order>?> fetchCancelledOrders({
    bool showLoading = true,
    required int page,
  }) async {
    try {
      if (showLoading) state = AsyncLoading();
      final repo = ref.watch(myOrdersRepositoryProvider);
      final response = await repo.getServicesOrders(
        page: page,
        status: 'Cancelled',
        orderSearched: _orderShared,
      );
      _currentPage = response.pagination?.currentPage ?? _currentPage;
      _totalPages = response.pagination?.totalPages ?? _totalPages;

      if (response.data == null || response.data?.orders == null) {
        throw Exception('Failed to fetch orders');
      }
      if (page == 1) {
        _cancelledList = List.from(response.data?.orders ?? []);
      } else {
        _cancelledList.addAll(response.data?.orders ?? []);
      }
      state = AsyncData(_cancelledList);
      return _cancelledList;
    } catch (e, st) {
      state = AsyncError(e, st);
      return null;
    }
   
  }

  Future<bool> onLoadMoreCancelledOrders() async {
    if (_currentPage >= _totalPages) return false;
    final nextPage = _currentPage + 1;
    final result = await fetchCancelledOrders(
      showLoading: false,
      page: nextPage,
    );

    return result?.isNotEmpty ?? false;

  }

  Future<void> orderCancelltion({required String serviceOrderID}) async {
    // state = state.copyWith(orderCancelltionStates: RequestStates.loading);

    // try {
    //   final myOrdersRepo = ref.read(myOrdersRepositoryProvider);
    //   await myOrdersRepo.orderCancelltion(serviceOrderId: serviceOrderID);

    //   state = state.copyWith(
    //     orderCancelltionStates: RequestStates.loaded,
    //     orderCancelltionMessage: '',
    //   );

    //   fetchOrdersDetails(serviceOrderID: serviceOrderID);
    // } catch (e) {
    //   state = state.copyWith(
    //     orderCancelltionStates: RequestStates.error,
    //     orderCancelltionMessage: e.toString(),
    //   );
    // }
  }

  Future<bool> refreshApproved() async {
    _acceptList.clear();
    _currentPage = 1;
    _totalPages = 1;
    await fetchApprovedOrders(page: 1, showLoading: true);
    return true;
  }

  Future<bool> refreshPending() async {
    _pendingList.clear();
    _currentPage = 1;
    _totalPages = 1;
    await fetchPendingOrders(page: 1, showLoading: true);
    return true;
  }

  Future<bool> refreshCancelled() async {
    _cancelledList.clear();
    _currentPage = 1;
    _totalPages = 1;
    await fetchCancelledOrders(page: 1, showLoading: true);
    return true;
  }
}
