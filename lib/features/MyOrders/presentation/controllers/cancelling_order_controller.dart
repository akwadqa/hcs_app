import 'package:hcs/features/MyOrders/data/repositories/myorders_repository.dart';
import 'package:hcs/features/MyOrders/presentation/controllers/myorders_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cancelling_order_controller.g.dart';

@riverpod
class CancellingOrderController extends _$CancellingOrderController {
  @override
  FutureOr<void> build() {}

  Future<void> orderCancelltion({required String serviceOrderID}) async {
    try {
      state = AsyncLoading();
      final repo = ref.watch(myOrdersRepositoryProvider);
      final response = await repo.orderCancelltion(
        serviceOrderId: serviceOrderID,
      );
      if (response.data == null) {
        throw Exception('Failed to cancel order');
      }
      state = AsyncData<void>(null);
    } catch (e, st) {
      state = AsyncError(e, st);
    }

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
}
