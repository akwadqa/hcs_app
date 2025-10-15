import 'package:flutter/material.dart';
import 'package:hcs/features/Home/Availability/presentation/controllers/availability_controller.dart';
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

  Future<void> withCleaningSupplies(String choice) async {
    state = state.copyWith(withCleaningSupplies: choice);
    final cleaningSupplies = calculatewithCleaningSupplies();
    state = state.copyWith(costAfterCleaningSuplies: cleaningSupplies);
    // calculateTotalCost(state.discountPercentage);
  }

  Future<void> selectPaymentMethod(String? selectedPaymentMethod) async {
    state = state.copyWith(selectedPaymentMethod: selectedPaymentMethod);
  }

  // In this function we getDiscountType and Auto selectDiscount,discountPercentage and calculateTotalCost
  Future<void> getDiscountType() async {
    state = state.copyWith(driversStates: RequestStates.loading);
    try {
      final driverPaymentRepo = ref.read(driverPaymentRepositoryProvider);
      final driverPaymentData = await driverPaymentRepo.getDiscountType();

      // لن يغيّر discountPercentage إن كانت null (حسب تعديل calculateTotalCost)
      calculateTotalCost(state.discountPercentage?.toDouble());

      state = state.copyWith(
        discountType: driverPaymentData.data,
        // ❌ لا نكتب discountPercentage: 0.0 هنا حتى لا نفرض خصم من غير تدخل المستخدم
        // selectedDiscount: driverPaymentData.data[0],
        // discountPercentage: driverPaymentData.data[0].discountPercentage.toDouble(),
        discountStates: RequestStates.loaded,
        driversMessage: '',
      );
    } catch (e) {
      state = state.copyWith(
        discountStates: RequestStates.error,
        driversMessage: e.toString(),
      );
    }
  }

  // In this function we chose Discount and Auto calculateCosts
  Future<void> selectDiscount(Discount? selectedDiscount) async {
    // هذه الاستدعاء يمرر قيمة صريحة من الواجهة، لذلك مسموح بتحديث النسبة
    calculateTotalCost(selectedDiscount?.discountPercentage.toDouble() ?? 0);
    state = state.copyWith(selectedDiscount: selectedDiscount);
  }

  // In this function we set note
  Future<void> setNote(String note) async {
    state = state.copyWith(note: note);
  }

  // In this function calculate withCleaningSupplies
  double calculatewithCleaningSupplies() {
    final availabilityController = ref.read(availabilityControllerProvider);
    final String selectedServiceType =
        availabilityController.selectedServiceType!;
    final String selectedShiftType = availabilityController.selectedShiftType;

    if (state.withCleaningSupplies == "no") {
      return 0.0;
    }
    if (selectedServiceType == "Packages") {
      return 0.0;
    }
    if (selectedShiftType == "Full Day") {
      return 100.0;
    }
    //? remove this
    return 50.0;
    // return 0.0;
  }

  // In this function calculateEmployeesSum
  double calculateEmployeesSum({double? newTotal}) {
    final employeesController = ref.read(employeesControllerProvider);
    final List<Employee> selectedEmployees =
        employeesController.selectedEmployees;

    // ملاحظة: أبقينا المنطق كما هو دون تغيير جوهري كما طلبت
    double total = selectedEmployees.fold(
      0.0,
      (sum, employee) => (sum + (state.newCost ?? employee.serviceCost)),
    );
    return total;
  }

  // Controllers/drivers_payment_controllers.dart
  Future<void> overrideTotalCost(double? newTotal, bool isHanded) async {
    // 1) Normalize the user-entered discounted total

    // 1) Normalize the user-entered discounted total
    final discounted = (newTotal ?? 0);

    // ✅ اكتشف إن كان الطلب Package

    // 2) احسب الـ base
    // ❗ عند الـ Package لا نستخدم calculateEmployeesSum(newTotal) لأنها تتأثر بـ state.newCost
    final employeesCost = calculateEmployeesSum(newTotal: newTotal);

    final base = employeesCost; // <-- original cost

    debugPrint("employeesCost=> $employeesCost");
    // debugPrint("cleaningSupplies=> $cleaningSupplies");
    debugPrint("base=> $base");
    debugPrint("new=> $newTotal");
    debugPrint("discount old=> $newTotal");
    debugPrint("discount=> $discounted");

    // 3) Compute % = (base - discounted) / base * 100
    double pct;
    if (base <= 0 || isHanded) {
      pct = 0.0; // avoid division by zero; no discount if no base
    } else {
      pct = ((base - discounted) / base) * 100.0;
      // clamp to [0, 100]
      if (pct < 0) pct = 0.0;
      if (pct > 100) pct = 100.0;
    }
    calculateTotalCost(double.parse(pct.toStringAsFixed(2)));

    // 4) Update state: لا تغيّر النسبة إلا عند إدخال من الواجهة (newTotal != null)
    state = state.copyWith(
      originalCost: newTotal,
      newCost: newTotal,
      selectedDiscount: state.discountType[6],
      // selectedDiscount : Discount(id: '', title: 'No Discount', discountPercentage: 0),
      // لا تغيّر discountedCost إلا لو المستخدم أدخل قيمة
      discountedCost: newTotal != null ? discounted : state.discountedCost,
      // لا تكتب النسبة إلا لو فيه إدخال صريح من الواجهة
      discountPercentage: newTotal != null
          ? double.parse(pct.toStringAsFixed(2))
          : state.discountPercentage,
    );
    // selectDiscount(state.discountType[6]);
  }

  // In this function we control 3 (originalCost , discountedCost, discountPercentage) in state
  Future<void> calculateTotalCost(double? discountPercentage) async {
    if (discountPercentage == null || discountPercentage < 0) {
      discountPercentage = 0.0;
    } else if (discountPercentage > 100) {
      discountPercentage = 100.0;
    }

    double employeesCost = calculateEmployeesSum();
    double withCleaningSupplies = calculatewithCleaningSupplies();
    double totalCost = employeesCost;

    // Convert percentage to a decimal (e.g., 10% -> 0.10)
    double discountDecimal = discountPercentage / 100;

    // Calculate the discount amount
    double discountAmount = totalCost * discountDecimal;

    // Apply the discount
    double discountedTotal = totalCost - discountAmount + withCleaningSupplies;

    // Update the state with the new total cost
    state = state.copyWith(
      originalCost: totalCost + withCleaningSupplies,
      discountedCost: discountedTotal,
      discountPercentage: discountPercentage,
    );
  }

  Future<void> selectDriver(Driver? selectedDriver) async {
    state = state.copyWith(selectedDriver: selectedDriver);
  }

  Future<void> fetchDrivers() async {
    state = state.copyWith(driversStates: RequestStates.loading);
    try {
      final driverPaymentRepo = ref.read(driverPaymentRepositoryProvider);
      final driverPaymentData = await driverPaymentRepo.getDrivers(page: 1);
      int? nextPage;

      // if there is a second page ?
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
      int? nextPage;

      // if we reach the limit or not ?
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
    } catch (e) {
      state = state.copyWith(
        driversStates: RequestStates.error,
        driversMessage: e.toString(),
      );
    }
  }
}
