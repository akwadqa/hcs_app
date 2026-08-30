import 'package:hcs/features/MyOrders/data/repositories/myorders_repository.dart';
import 'package:hcs/features/MyOrders/domain/models/services_order/services_order_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pending_orders_controller.g.dart';
@riverpod
class PendingOrdersController extends _$PendingOrdersController {
  @override
  FutureOr<List<Order>?> build() {
    return fetchPendingOrders(page: 1);
  }
  
  List<Order> _pendingList = [];
  int _currentPage = 1;
  int _totalPages = 1;

  
  Future<List<Order>?> fetchPendingOrders({
    bool showLoading = true,
    required int page,
    String? orderShare,
  }) async {
    try {
      if (showLoading) state = AsyncLoading();
      final repo = ref.watch(myOrdersRepositoryProvider);
      final response = await repo.getServicesOrders(
        page: page,
        status: 'Pending',
        orderSearched: orderShare ?? '',
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
  Future<bool> refreshPending() async {
    _pendingList.clear();
    _currentPage = 1;
    _totalPages = 1;
    await fetchPendingOrders(page: 1, showLoading: true);
    return true;
  }

}