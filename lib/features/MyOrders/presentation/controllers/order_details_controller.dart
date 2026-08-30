import 'package:hcs/features/MyOrders/data/repositories/myorders_repository.dart';
import 'package:hcs/features/MyOrders/domain/models/order_details/order_details_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'order_details_controller.g.dart';

@riverpod
class OrderDetailsController extends _$OrderDetailsController {
  @override
  FutureOr<OrderDetails?> build() {
    return null;
  }

  OrderDetails? _orderDetails;

  Future<OrderDetails?> fetchOrdersDetails({
    required String serviceOrderID,
  }) async {
    try {
      state = AsyncLoading();
      final repo = ref.watch(myOrdersRepositoryProvider);
      final response = await repo.getServicesOrderDetails(
        serviceOrderId: serviceOrderID,
      );
      // _currentPage = response.pagination?.currentPage ?? _currentPage;
      // _totalPages = response.pagination?.totalPages ?? _totalPages;

      // if (page == 1) {
      //   _cancelledList = List.from(response.data?.orders ?? []);
      // } else {
      //   _cancelledList.addAll(response.data?.orders ?? []);
      // }
      if (response.data == null) {
        throw Exception(response.message ?? 'Failed to get order details');
      }
      _orderDetails = response.data;
      state = AsyncData(_orderDetails);
      return _orderDetails;
    } catch (e, st) {
      state = AsyncError(e, st);
      return null;
    }

    // state = state.copyWith(
    //   ordersDetailsStates: RequestStates.loading,
    //   orderCancelltionStates: RequestStates.init,
    // );

    // try {
    //   final myOrdersRepo = ref.read(myOrdersRepositoryProvider);
    //   final ordersDetails = await myOrdersRepo.getServicesOrderDetails(
    //     serviceOrderId: serviceOrderID,
    //   );

    //   state = state.copyWith(
    //     ordersDetails: ordersDetails.details,
    //     ordersDetailsStates: RequestStates.loaded,
    //     ordersDetailsMessage: '',
    //     orderCancelltionStates: RequestStates.init,
    //   );
    // } catch (e) {
    //   state = state.copyWith(
    //     ordersDetailsStates: RequestStates.error,
    //     ordersDetailsMessage: e.toString(),
    //   );
    // }
  }
}
