import 'package:flutter/material.dart';
import 'package:hcs/features/Home/Driver_Payment/data/models/discount_type.dart';
import 'package:hcs/features/Home/Driver_Payment/data/models/drivers_model.dart';
import 'package:hcs/features/Home/Driver_Payment/data/repositories/driver_payment_repo.dart';
import 'package:hcs/features/Home/Driver_Payment/presentation/controllers/driver_payment_state.dart';
import 'package:hcs/features/Home/Employees/data/models/employees_model.dart';
import 'package:hcs/features/Home/Employees/presentation/controllers/employees_controller.dart';
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

  // In this function we getDiscountType and Auto selectDiscount,discountPercentage and calculateTotalCost
  Future<void> getDiscountType() async {
    state = state.copyWith(driversStates: RequestStates.loading);

    try {
      final driverPaymentRepo = ref.read(driverPaymentRepositoryProvider);
      final driverPaymentData = await driverPaymentRepo.getDiscountType();
      // debugPrint("currentDriversPage #1 : ${state.currentDriversPage.toString()}");
      calculateTotalCost(
        driverPaymentData.data[0].discountPercentage.toDouble(),
      );
      state = state.copyWith(
        discountType: driverPaymentData.data,
        selectedDiscount: driverPaymentData.data[0],
        discountPercentage: driverPaymentData.data[0].discountPercentage
            .toDouble(),
        discountStates: RequestStates.loaded,
        driversMessage: '',
      );
      // debugPrint("currentDriversPage #2 : ${state.currentDriversPage.toString()}");
    } catch (e) {
      state = state.copyWith(
        discountStates: RequestStates.error,
        driversMessage: e.toString(),
      );
    }
  }

  // In this function we chose Discount and Auto calculateCosts
  Future<void> selectDiscount(Discount? selectedDiscount) async {
    calculateTotalCost(selectedDiscount?.discountPercentage.toDouble());
    state = state.copyWith(selectedDiscount: selectedDiscount);
    debugPrint("${state.selectedDiscount.toString()} selectedDiscount llll");
  }

  // In this function calculateEmployeesSum
  double calculateEmployeesSum() {
    final employeesController = ref.read(employeesControllerProvider);
    final List<Employee> employees = employeesController.employees;

    double total = employees.fold(
      0.0,
      (sum, employee) => sum + employee.serviceCost,
    );

    return total;
  }

  // In this function we controll 3 (originalCost , discountedCost, discountPercentage) in state
  Future<void> calculateTotalCost(double? discountPercentage) async {
    discountPercentage ??= 0;

    double employeesCost = calculateEmployeesSum();

    // Convert percentage to a decimal (e.g., 10% -> 0.10)
    double discountDecimal = discountPercentage / 100;

    // Calculate the discount amount
    double discountAmount = employeesCost * discountDecimal;

    // Apply the discount
    double discountedTotal = employeesCost - discountAmount;

    // Update the state with the new total cost
    state = state.copyWith(
      originalCost: employeesCost,
      discountedCost: discountedTotal,
      discountPercentage: discountPercentage,
    );

    debugPrint("${state.originalCost.toString()} cost before discount");
    debugPrint("${state.discountedCost.toString()} cost after discount");
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
        selectedDriver: driverPaymentData.data[0],
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
