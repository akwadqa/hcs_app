import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:hcs/features/MyOrders/data/repositories/myorders_repository.dart';
import 'package:hcs/features/MyOrders/domain/models/appointment/appoitnment_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'appointment_controller.g.dart';

@riverpod
class AppointmentController extends _$AppointmentController {
  @override
  FutureOr<List<Appointment>> build() async => [];

  List<Appointment> _appointmentsList = [];
  int _currentPage = 1;
  int _totalPages = 1;
  // inside MyOrdersController

  Future<List<Appointment>?> fetchAppontments({
    bool showLoading = true,
    required int page,
    required String serviceOrderID,
    String? orderShared,
  }) async {
    try {
      if (showLoading) state = AsyncLoading();
      final repo = ref.watch(myOrdersRepositoryProvider);
      final response = await repo.getAppontments(
        page: page,
        orderId: serviceOrderID,
      );
      _currentPage = response.pagination?.page ?? _currentPage;
      _totalPages = response.pagination?.totalPages ?? _totalPages;

      if (response.data == null) {
        throw Exception('Failed to fetch orders');
      }

      if (page == 1) {
        _appointmentsList = List.from(response.data ?? []);
      } else {
        // _acceptList.addAll([..._acceptList , ...response.data!.orders!]);
        _appointmentsList.addAll(List.from(response.data) ?? []);
      }
      state = AsyncData(_appointmentsList);
      return _appointmentsList;
    } catch (e, st) {
      state = AsyncError(e, st);
      return null;
    }
  }

  Future<bool> onLoadMoreApprovedOrders(String serviceOrderID) async {
    if (_currentPage >= _totalPages) return false;
    final nextPage = _currentPage + 1;
    final result = await fetchAppontments(
      showLoading: false,
      page: nextPage,
      serviceOrderID: serviceOrderID,
    );

    return result?.isNotEmpty ?? false;
  }
}
