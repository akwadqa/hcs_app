import 'package:flutter/material.dart';
import 'package:hcs/features/Home/Availability/data/models/packages_model.dart';
import 'package:hcs/features/Home/Availability/data/repositories/availability_repo.dart';
import 'package:hcs/features/Home/Availability/presentation/controllers/service_config_state.dart';
import 'package:hcs/src/enums/request_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'availability_controller.g.dart';

@riverpod
class AvailabilityController extends _$AvailabilityController {
  @override
  ServiceConfigState build() => const ServiceConfigState();

  Future<void> resetController(
    String selectedServiceType,
    String selectedDate,
    // PackagesData? selectedPackage,
  ) async {
    state = state.copyWith(
      selectedServiceType: selectedServiceType,
      selectedShiftType: 'Morning',
      selectedPackage: PackagesData(
        id: "Daily",
        serviceItem: 'STO-ITEM-2025-00005',
        serviceCost: 200,
        numberOfVisits: null,
      ),
      selectedDate: selectedDate,
      packages: [],
      packagesStates: RequestStates.init,
      packagesMessage: '',
    );
    debugPrint('selectedServiceType : $selectedServiceType');
    debugPrint('selectedDate : $selectedDate');
    debugPrint('selectedPackage : ${state.selectedPackage}');
  }

  // selectService(String selectedServiceType) {
  //   debugPrint('selectedServiceType : $selectedServiceType');
  //   state = state.copyWith(selectedServiceType: selectedServiceType);
  // }

  selectShift(String selectedShiftType) {
    debugPrint('selectedShiftType : $selectedShiftType');
    state = state.copyWith(selectedShiftType: selectedShiftType);
  }

  selectDate(String selectedDate) {
    debugPrint('selectedDate : $selectedDate');
    state = state.copyWith(selectedDate: selectedDate);
  }

  selecPackage(PackagesData selectedPackage) {
    debugPrint('selectedPackage : ${selectedPackage.toString()}');
    state = state.copyWith(selectedPackage: selectedPackage);
  }

  Future<void> fetchPackages() async {
    state = state.copyWith(packagesStates: RequestStates.loading);

    try {
      final availabilityRepo = ref.read(availabilityRepositoryProvider);
      final packagesData = await availabilityRepo.getPackages();

      state = state.copyWith(
        packages: packagesData.data,
        packagesStates: RequestStates.loaded,
        packagesMessage: 'loadded successfully',
      );
    } catch (e) {
      state = state.copyWith(
        packagesStates: RequestStates.error,
        packagesMessage: e.toString(),
      );
    }
  }
}
