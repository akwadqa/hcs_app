import 'package:hcs/features/MyOrders/domain/models/services_order/services_order_model.dart';
import 'package:hcs/features/MyOrders/presentation/controllers/custom_date_orders_controller.dart';
import 'package:hcs/features/MyOrders/presentation/controllers/today_orders_controller.dart';
import 'package:hcs/features/MyOrders/presentation/controllers/tomorrow_orders_controller.dart';
import 'package:hcs/features/MyOrders/presentation/controllers/pending_orders_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'myorders_controller.g.dart';

@riverpod
class MyOrdersController extends _$MyOrdersController {
  @override
  FutureOr<List<Order>?> build() {
    // return fetchApprovedOrders(page: 1);
  }

  // List<Order> _acceptList = [];
  // List<Order> _pendingList = [];
  // List<Order> _cancelledList = [];
  String _orderShared = '';
  // int _currentPage = 1;
  // int _totalPages = 1;

  searchOrder({required String searchedOrder, required int tabIndex}) {
    // state = state.copyWith(orderSearchedFor: searchedOrder);
    final today = ref.watch(todayOrdersControllerProvider.notifier);
    final custom = ref.watch(customDateOrdersControllerProvider.notifier);
    final tomorrow = ref.watch(tomorrowOrdersControllerProvider.notifier);
    _orderShared = searchedOrder;
    switch (tabIndex) {
      case 0:
        custom.applySearch( searchedOrder);
        break;

      case 1:
        today.applySearch( searchedOrder);
        break;

      case 2:
        tomorrow.applySearch( searchedOrder);
        break;
      default:
        today.applySearch( searchedOrder);
    }
  }

void applyStatusFilter(String status, {required int tabIndex}) {
  final today = ref.read(todayOrdersControllerProvider.notifier);
  final custom = ref.read(customDateOrdersControllerProvider.notifier);
  final tomorrow = ref.read(tomorrowOrdersControllerProvider.notifier);

  switch (tabIndex) {
    case 0:
      custom.applyStatusFilter(status);

      break;
    case 1:
      today.applyStatusFilter(status);

      break;
    case 2:
      tomorrow.applyStatusFilter(status);
      break;
  }
}


}
