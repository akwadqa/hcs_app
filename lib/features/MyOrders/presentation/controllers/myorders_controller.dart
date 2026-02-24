import 'package:hcs/features/MyOrders/domain/models/services_order/services_order_model.dart';
import 'package:hcs/features/MyOrders/presentation/controllers/custom_date_orders_controller.dart';
import 'package:hcs/features/MyOrders/presentation/controllers/today_orders_controller.dart';
import 'package:hcs/features/MyOrders/presentation/controllers/tomorrow_orders_controller.dart';
import 'package:hcs/features/MyOrders/presentation/controllers/pending_orders_controller.dart';
import 'package:hcs/src/enums/orders_status_enums.dart';
import 'package:hcs/src/enums/shift_type_enum.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'myorders_state.dart';

part 'myorders_controller.g.dart';

@Riverpod(keepAlive: true)
class MyOrdersController extends _$MyOrdersController {
    OrdersFilterState _filter = OrdersFilterState.empty;

  OrdersFilterState get filter => _filter;
  @override
  FutureOr<List<Order>?> build() {
    // return fetchApprovedOrders(page: 1);
         return [];

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

  void updateStatus(OrderStatus? status) {
    _filter = _filter.copyWith(status: status);
    state = AsyncValue.data(state.value);
    // state = state;
    // state = AsyncData(state.value); // notify listeners
  }

  void updateShiftType(ShiftTypeEnum? shiftType) {
    _filter = _filter.copyWith(shiftType: shiftType);
    state = AsyncValue.data(state.value);
    // state = state;
    // state = AsyncData(state.value);
  }

  void clearFilters() {
    _filter = OrdersFilterState.empty;
    state = AsyncValue.data(state.value);
    // state = state;
    // state = AsyncData(state.value);
  }

void applyFilters({required int tabIndex}) {
  final today = ref.read(todayOrdersControllerProvider.notifier);
  final custom = ref.read(customDateOrdersControllerProvider.notifier);
  final tomorrow = ref.read(tomorrowOrdersControllerProvider.notifier);

  final statusValue = _filter.status?.apiValue ?? '';
  final shiftValue = _filter.shiftType?.apiValue;

  switch (tabIndex) {
    case 0:
      custom.applyFilters(status: statusValue,shiftType: shiftValue);
      break;
    case 1:
      today.applyFilters(status: statusValue,shiftType: shiftValue);
      break;
    case 2:
      tomorrow.applyFilters(status: statusValue,shiftType: shiftValue);
      break;
  }
} 

// void applyStatusFilter({String? status,String? shiftType, required int tabIndex}) {
//   final today = ref.read(todayOrdersControllerProvider.notifier);
//   final custom = ref.read(customDateOrdersControllerProvider.notifier);
//   final tomorrow = ref.read(tomorrowOrdersControllerProvider.notifier);

//   switch (tabIndex) {
//     case 0:
//       custom.applyStatusFilter(status);

//       break;
//     case 1:
//       today.applyStatusFilter(status);

//       break;
//     case 2:
//       tomorrow.applyStatusFilter(status);
//       break;
//   }
// }


}
