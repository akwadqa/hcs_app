import 'package:hcs/features/MyOrders/data/repositories/myorders_repository.dart';
import 'package:hcs/features/MyOrders/domain/models/order_details/order_details_model.dart';
import 'package:hcs/features/MyOrders/domain/models/services_order/services_order_model.dart';
import 'package:hcs/features/MyOrders/presentation/controllers/accept_orders_controller.dart';
import 'package:hcs/features/MyOrders/presentation/controllers/cancelled_orders_controller.dart';
import 'package:hcs/features/MyOrders/presentation/controllers/myorders_state.dart';
import 'package:hcs/features/MyOrders/presentation/controllers/pending_orders_controller.dart';
import 'package:hcs/src/enums/request_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'myorders_controller.g.dart';

@riverpod
class MyOrdersController extends _$MyOrdersController {
  @override
  FutureOr<List<Order>?> build() {
    // return fetchApprovedOrders(page: 1);
  }

  List<Order> _acceptList = [];
  List<Order> _pendingList = [];
  List<Order> _cancelledList = [];
  String _orderShared = '';
  int _currentPage = 1;
  int _totalPages = 1;

  searchOrder({required String searchedOrder, required int tabIndex}) {
    // state = state.copyWith(orderSearchedFor: searchedOrder);
    final approved = ref.watch(acceptOrdersControllerProvider.notifier);
    final pending = ref.watch(pendingOrdersControllerProvider.notifier);
    final cancelled = ref.watch(cancelledOrdersControllerProvider.notifier);
    _orderShared = searchedOrder;
    switch (tabIndex) {
      case 0:
        approved.fetchApprovedOrders(page: 1, orderShared: searchedOrder);
        break;

      case 1:
        pending.fetchPendingOrders(page: 1, orderShare: searchedOrder);
        break;

      case 2:
        cancelled.fetchCancelledOrders(page: 1, orderShared: searchedOrder);
        break;
      default:
        approved.fetchApprovedOrders(page: 1, orderShared: searchedOrder);
    }
  }
}
