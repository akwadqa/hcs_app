import 'package:flutter/material.dart';
import 'package:hcs/features/Home/Driver_Payment/data/models/drivers_model.dart';
import 'package:hcs/features/Home/Driver_Payment/data/repositories/driver_payment_repo.dart';
import 'package:hcs/features/Home/Driver_Payment/presentation/controllers/driver_payment_state.dart';
import 'package:hcs/src/enums/request_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'drivers_payment_controllers.g.dart';

@riverpod
class DriversPaymentController extends _$DriversPaymentController {
  @override
  DriverPaymentState build() => const DriverPaymentState();
  
  Future<void> selectPaymentMethod(String? selectedPaymentMethod) async {
    state = state.copyWith(selectedPaymentMethod: selectedPaymentMethod);
    debugPrint(
      "${state.selectedPaymentMethod.toString()} selectedPaymentMethod llll",
    );
  }

  Future<void> selectDriver(Driver? selectedDriver) async {
    state = state.copyWith(selectedDriver: selectedDriver);
    debugPrint("${state.selectedDriver.toString()} selectedDriver llll");
  }

  Future<void> fetchDrivers() async {
    state = state.copyWith(driversStates: RequestStates.loading);

    try {
      final driverPaymentRepo = ref.read(driverPaymentRepositoryProvider);
      final driverPaymentData = await driverPaymentRepo.getDrivers(page: 1);
      // debugPrint("currentDriversPage #1 : ${state.currentDriversPage.toString()}");

      int? nextPage;
      //if there is a second page ?
      if (driverPaymentData.pagination.totalPages > 1) {
        nextPage = 2;
      } else {
        nextPage = null;
      }
      state = state.copyWith(
        currentDriversPage: nextPage,
        drivers: driverPaymentData.data,
        driversStates: RequestStates.loaded,
        driversMessage: '',
      );
      // debugPrint("currentDriversPage #2 : ${state.currentDriversPage.toString()}");
    } catch (e) {
      state = state.copyWith(
        driversStates: RequestStates.error,
        driversMessage: e.toString(),
      );
    }
  }

  Future<void> onLoadMoreDrivers() async {
    try {
      final driverPaymentRepo = ref.read(driverPaymentRepositoryProvider);
      final driverPaymentData = await driverPaymentRepo.getDrivers(
        page: state.currentDriversPage!,
      );
      // debugPrint("currentDriversPage #3 : ${state.currentDriversPage.toString()}");

      int? nextPage;
      //if we reach the limit or not ?
      if (driverPaymentData.pagination.totalPages >
          driverPaymentData.pagination.page) {
        nextPage = driverPaymentData.pagination.page + 1;
      } else {
        nextPage = null;
      }
      state = state.copyWith(
        currentDriversPage: nextPage,
        drivers: [...state.drivers, ...driverPaymentData.data],
        driversStates: RequestStates.loaded,
        driversMessage: '',
      );
      // debugPrint("currentDriversPage #4 : ${state.currentDriversPage.toString()}");
    } catch (e) {
      state = state.copyWith(
        driversStates: RequestStates.error,
        driversMessage: e.toString(),
      );
    }
  }
}
