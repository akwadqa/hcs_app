import 'package:hcs/features/Home/data/repositories/home_repository.dart';
import 'package:hcs/features/Home/presentation/controllers/home_state.dart';
import 'package:hcs/src/enums/request_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_controller.g.dart';

@riverpod
class HomeController extends _$HomeController {
  @override
  HomeState build() => const HomeState(
    homeBlock: null,
    homeStates: RequestStates.init,
    homeMessage: '',

    //credits
    currentPage: null,
    credits: [],
    creditsStates: RequestStates.init,
    creditsMessage: '',
  );

  Future<void> fetchHomeBlocks() async {
    state = state.copyWith(homeStates: RequestStates.loading);

    try {
      final homeRepo = ref.read(homeRepositoryProvider);
      final homeData = await homeRepo.getHomeBlocks();

      state = state.copyWith(
        homeBlock: homeData,
        homeStates: RequestStates.loaded,
        homeMessage: '',
      );
    } catch (e) {
      state = state.copyWith(
        homeStates: RequestStates.error,
        homeMessage: e.toString(),
      );
    }
  }

  Future<void> fetchCreditsByID(String itemGroupId) async {
    state = state.copyWith(creditsStates: RequestStates.loading);

    try {
      final homeRepo = ref.read(homeRepositoryProvider);
      final creditsData = await homeRepo.fetchCreditsByID(
        page: 1,
        itemGroupId: itemGroupId,
      );
      // debugPrint("currentPage #1 : ${state.currentPage.toString()}");

      int? nextPage;
      //if there is a second page ?
      if (creditsData.pagination.totalPages > 1) {
        nextPage = 2;
      } else {
        nextPage = null;
      }
      state = state.copyWith(
        currentPage: nextPage,
        credits: creditsData.data,
        creditsStates: RequestStates.loaded,
        creditsMessage: '',
      );
      // debugPrint("currentPage #2 : ${state.currentPage.toString()}");
    } catch (e) {
      state = state.copyWith(
        creditsStates: RequestStates.error,
        creditsMessage: e.toString(),
      );
    }
  }

  Future<void> onLoadMoreCreditsByID(String itemGroupId) async {
    try {
      final homeRepo = ref.read(homeRepositoryProvider);
      final creditsData = await homeRepo.fetchCreditsByID(
        page: state.currentPage!,
        itemGroupId: itemGroupId,
      );
      // debugPrint("currentPage #3 : ${state.currentPage.toString()}");

      int? nextPage;
      //if we reach the limit or not ?
      if (creditsData.pagination.totalPages > creditsData.pagination.page) {
        nextPage = creditsData.pagination.page + 1;
      } else {
        nextPage = null;
      }
      state = state.copyWith(
        currentPage: nextPage,
        credits: [...state.credits, ...creditsData.data],
        creditsStates: RequestStates.loaded,
        creditsMessage: '',
      );
      // debugPrint("currentPage #4 : ${state.currentPage.toString()}");
    } catch (e) {
      state = state.copyWith(
        creditsStates: RequestStates.error,
        creditsMessage: e.toString(),
      );
    }
  }
}
