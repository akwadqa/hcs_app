import 'package:hcs/features/MyOrders/data/repositories/myorders_repository.dart';
import 'package:hcs/features/MyOrders/domain/models/services_order/services_order_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'accept_orders_controller.g.dart';

@riverpod
class AcceptOrdersController extends _$AcceptOrdersController {
  @override
  FutureOr<List<Order>?> build() {
    return fetchApprovedOrders(page: 1);
  }
  List<Order> _acceptList = [];
  int _currentPage = 1;
  int _totalPages = 1;

  
  Future<List<Order>?> fetchApprovedOrders({
    bool showLoading = true,
    required int page,
    String? orderShared
  }) async {
    try {
      if (showLoading) state = AsyncLoading();
      final repo = ref.watch(myOrdersRepositoryProvider);
      final response = await repo.getServicesOrders(
        page: page,
        status: 'Approved',
        orderSearched: orderShared??'',
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

    Future<bool> refreshApproved() async {
    _acceptList.clear();
    _currentPage = 1;
    _totalPages = 1;
    await fetchApprovedOrders(page: 1, showLoading: true);
    return true;
  }
}
