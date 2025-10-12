import 'package:hcs/features/MyOrders/data/repositories/myorders_repository.dart';
import 'package:hcs/features/MyOrders/domain/models/services_order/services_order_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'cancelled_orders_controller.g.dart';
@riverpod
class CancelledOrdersController extends _$CancelledOrdersController {
  @override
  FutureOr<List<Order>?> build() {
    return fetchCancelledOrders(page: 1);
  }
  List<Order> _cancelledList = [];
  int _currentPage = 1;
  int _totalPages = 1;

  
  Future<List<Order>?> fetchCancelledOrders({
    bool showLoading = true,
    required int page,
    String? orderShared,
  }) async {
    try {
      if (showLoading) state = AsyncLoading();
      final repo = ref.watch(myOrdersRepositoryProvider);
      final response = await repo.getServicesOrders(
        page: page,
        status: 'Cancelled',
        orderSearched: orderShared ?? '',
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


  Future<bool> refreshCancelled() async {
    _cancelledList.clear();
    _currentPage = 1;
    _totalPages = 1;
    await fetchCancelledOrders(page: 1, showLoading: true);
    return true;
  }
}