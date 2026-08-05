import 'package:flutter/material.dart';
import 'package:hcs/features/Home/Availability/presentation/controllers/availability_controller.dart';
import 'package:hcs/features/Home/deep_clean/data/repo/deep_clean_repository.dart';
import 'package:hcs/features/Home/deep_clean/domain/models/service_item_model.dart';
import 'package:hcs/features/Home/deep_clean/presentation/controller/deep_clean_state.dart';
import 'package:hcs/src/enums/request_state.dart';
import 'package:hcs/src/enums/service_type.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'deep_clean_controller.g.dart';

@riverpod
class DeepCleanController extends _$DeepCleanController {
  @override
  DeepCleanState build() => const DeepCleanState();
  HomeServiceMode get mode {
    final selected =
        ref.read(availabilityControllerProvider).selectedServiceType;
    return HomeServiceMode.fromSelectedServiceType(selected);
  }


  // --- step 1 ---
  Future<void> fetchServices() async {
    state = state.copyWith(servicesState: RequestStates.loading);
    try {
      debugPrint("state.mode.apiServiceType");
      final services = await ref
          .read(deepCleanRepositoryProvider)
          .getServiceItems(serviceType: mode.apiServiceType);

      state = state.copyWith(
        services: services,
        servicesState: RequestStates.loaded,
        servicesError: '',
      );
    } catch (e) {
      state = state.copyWith(
        servicesState: RequestStates.error,
        servicesError: e.toString(),
      );
    }
  }

  void selectServiceType(DeepCleanServiceType t) =>
      state = state.copyWith(selectedServiceType: t);

  void selectShift(DeepCleanShift s) =>
      state = state.copyWith(selectedShift: s);

  void selectDate(DateTime d) => state = state.copyWith(selectedDate: d);

  // --- step 2 : cards ---
  void addServiceCard() => state = state.copyWith(
    selectedServices: [...state.selectedServices, null],
  );

  void removeServiceCard(int index) {
    if (state.selectedServices.length <= 1) return;
    final removed = state.selectedServices[index];
    final list = [...state.selectedServices]..removeAt(index);
    final qMap = Map<String, int>.from(state.quantities);
    if (removed != null) qMap.remove(removed.itemCode);
    state = state.copyWith(selectedServices: list, quantities: qMap);
  }


  void selectServiceAt(int index, ServiceItemModel? service) {
    final list = [...state.selectedServices];
    if (index < 0 || index >= list.length) return;
    list[index] = service;
    state = state.copyWith(selectedServices: list);
  }

  // Maintenance-only qty control
  void setQty(String itemCode, int qty) {
    final q = qty < 1 ? 1 : qty;
    final map = Map<String, int>.from(state.quantities)..[itemCode] = q;
    state = state.copyWith(quantities: map);
  }

  /// used from Order Summary — remove a chosen service by itemCode.

  void removeChosenService(String itemCode) {
    final list = state.selectedServices
        .where((s) => s?.itemCode != itemCode)
        .toList();
    final qMap = Map<String, int>.from(state.quantities)..remove(itemCode);
    state = state.copyWith(
      selectedServices: list.isEmpty ? [null] : list,
      quantities: qMap,
    );
  }

  void reset() => state = DeepCleanState(mode: state.mode);
}
