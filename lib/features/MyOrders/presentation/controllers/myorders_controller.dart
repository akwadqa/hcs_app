import 'package:hcs/features/MyOrders/data/repositories/myorders_repository.dart';
import 'package:hcs/features/MyOrders/presentation/controllers/myorders_state.dart';
import 'package:hcs/src/enums/request_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'myorders_controller.g.dart';

@riverpod
class MyOrdersController extends _$MyOrdersController {
  @override
  MyOrdersState build() => const MyOrdersState();

  Future<void> fetchServicesOrders({required String ordersStatus}) async {
    state = state.copyWith(ordersStates: RequestStates.loading);

    try {
      final myOrdersRepo = ref.read(myOrdersRepositoryProvider);
      final ordersData = await myOrdersRepo.getServicesOrders(
        page: 1,
        status: ordersStatus,
      );

      int? nextPage;
      //if there is a second page ?
      if (ordersData.pagination.totalPages > 1) {
        nextPage = 2;
      } else {
        nextPage = null;
      }
      state = state.copyWith(
        currentServicesOrdersPage: nextPage,
        orders: ordersData.data,
        ordersStates: RequestStates.loaded,
        ordersMessage: '',
      );
    } catch (e) {
      state = state.copyWith(
        ordersStates: RequestStates.error,
        ordersMessage: e.toString(),
      );
    }
  }

  Future<void> onLoadMoreServicesOrders({required String ordersStatus}) async {
    try {
      final myOrdersRepo = ref.read(myOrdersRepositoryProvider);
      final ordersData = await myOrdersRepo.getServicesOrders(
        page: state.currentServicesOrdersPage!,
        status: ordersStatus,
      );

      int? nextPage;
      //if we reach the limit or not ?
      if (ordersData.pagination.totalPages > ordersData.pagination.page) {
        nextPage = ordersData.pagination.page + 1;
      } else {
        nextPage = null;
      }
      state = state.copyWith(
        currentServicesOrdersPage: nextPage,
        orders: [...state.orders, ...ordersData.data],
        ordersStates: RequestStates.loaded,
        ordersMessage: '',
      );
    } catch (e) {
      state = state.copyWith(
        ordersStates: RequestStates.error,
        ordersMessage: e.toString(),
      );
    }
  }

  Future<void> fetchOrdersDetails({required String serviceOrderID}) async {
    state = state.copyWith(ordersDetailsStates: RequestStates.loading);

    try {
      final myOrdersRepo = ref.read(myOrdersRepositoryProvider);
      final ordersDetails = await myOrdersRepo.getServicesOrderDetails(
        serviceOrderId: serviceOrderID,
      );

      state = state.copyWith(
        ordersDetails: ordersDetails.details,
        ordersDetailsStates: RequestStates.loaded,
        ordersDetailsMessage: '',
      );
    } catch (e) {
      state = state.copyWith(
        ordersDetailsStates: RequestStates.error,
        ordersDetailsMessage: e.toString(),
      );
    }
  }
}
