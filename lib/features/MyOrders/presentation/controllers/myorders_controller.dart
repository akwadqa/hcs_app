import 'package:hcs/features/Home/Customer/data/repositories/home_repository.dart';
import 'package:hcs/features/MyOrders/presentation/controllers/myorders_state.dart';
import 'package:hcs/src/enums/request_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'myorders_controller.g.dart';

@riverpod
class MyOrdersController extends _$MyOrdersController {
  @override
  MyOrdersState build() => const MyOrdersState(
    //credits
    currentCustomersPage: null,
    customers: [],
    customersStates: RequestStates.init,
    customersMessage: '',
  );

  // Future<void> fetchHomeBlocks() async {
  //   state = state.copyWith(myOrdersStates: RequestStates.loading);

  //   try {
  //     final homeRepo = ref.read(homeRepositoryProvider);
  //     final homeData = await homeRepo.getHomeBlocks();

  //     state = state.copyWith(
  //       homeBlock: homeData,
  //       myOrdersStates: RequestStates.loaded,
  //       homeMessage: '',
  //     );
  //   } catch (e) {
  //     state = state.copyWith(
  //       myOrdersStates: RequestStates.error,
  //       homeMessage: e.toString(),
  //     );
  //   }
  // }

  Future<void> fetchCreditsByID() async {
    state = state.copyWith(customersStates: RequestStates.loading);

    try {
      final homeRepo = ref.read(homeRepositoryProvider);
      final creditsData = await homeRepo.getCustomers(page: 1);
      // debugPrint("currentPage #1 : ${state.currentPage.toString()}");

      int? nextPage;
      //if there is a second page ?
      if (creditsData.pagination.totalPages > 1) {
        nextPage = 2;
      } else {
        nextPage = null;
      }
      state = state.copyWith(
        currentCustomersPage: nextPage,
        customers: creditsData.data,
        customersStates: RequestStates.loaded,
        customersMessage: '',
      );
      // debugPrint("currentPage #2 : ${state.currentPage.toString()}");
    } catch (e) {
      state = state.copyWith(
        customersStates: RequestStates.error,
        customersMessage: e.toString(),
      );
    }
  }

  Future<void> onLoadMoreCreditsByID(String itemGroupId) async {
    try {
      final homeRepo = ref.read(homeRepositoryProvider);
      final creditsData = await homeRepo.getCustomers(page: state.currentCustomersPage!);
      // debugPrint("currentPage #3 : ${state.currentPage.toString()}");

      int? nextPage;
      //if we reach the limit or not ?
      if (creditsData.pagination.totalPages > creditsData.pagination.page) {
        nextPage = creditsData.pagination.page + 1;
      } else {
        nextPage = null;
      }
      state = state.copyWith(
        currentCustomersPage: nextPage,
        customers: [...state.customers, ...creditsData.data],
        customersStates: RequestStates.loaded,
        customersMessage: '',
      );
      // debugPrint("currentPage #4 : ${state.currentPage.toString()}");
    } catch (e) {
      state = state.copyWith(
        customersStates: RequestStates.error,
        customersMessage: e.toString(),
      );
    }
  }
}
