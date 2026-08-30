import 'package:flutter/material.dart';
import 'package:hcs/features/Home/Availability/presentation/controllers/availability_controller.dart';
import 'package:hcs/features/Home/Customer/presentation/controllers/customer_controller.dart';
import 'package:hcs/features/Home/Driver_Payment/presentation/controllers/drivers_payment_controllers.dart';
import 'package:hcs/features/Home/Employees/presentation/controllers/employees_controller.dart';
import 'package:hcs/features/Home/Submit_Service/data/models/submit_service_params.dart';
import 'package:hcs/features/Home/Submit_Service/data/repo/submit_servcie_repo.dart';
import 'package:hcs/features/Home/Submit_Service/presentation/submit_service_state.dart';
import 'package:hcs/features/Home/deep_clean/presentation/controller/deep_clean_controller.dart';
import 'package:hcs/src/enums/request_state.dart';
import 'package:hcs/src/enums/service_type.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'submit_service_controller.g.dart';

@riverpod
class SubmitServiceController extends _$SubmitServiceController {
  @override
  SubmitServiceState build() => const SubmitServiceState();

  Future<bool> submitService(
    // BuildContext context
  ) async {
    state = state.copyWith(submitServiceStates: RequestStates.loading);

    try {
      var selectedPackageState = ref.watch(
        availabilityControllerProvider.select((value) => value.selectedPackage),
      );
      final selectedServiceType = ref.watch(
        availabilityControllerProvider.select((s) => s.selectedServiceType),
      );
      final isDailyService =
          selectedPackageState?.id == 'Daily' ||
          stringToServiceType(selectedServiceType ?? "On Call") !=
              ServiceType.packages;

      final submitServiceRepo = ref.read(submitServiceRepositoryProvider);
      final customerController = ref.read(customerControllerProvider);
      final availabilityController = ref.read(availabilityControllerProvider);
      final availabilityControllerNotifier = ref.read(
        availabilityControllerProvider.notifier,
      );

      final employeesController = ref.read(employeesControllerProvider);
      final driverPaymentController = ref.read(
        driversPaymentControllerProvider,
      );

      final deepCleanState = ref.read(deepCleanControllerProvider);
      final mode = HomeServiceMode.fromSelectedServiceType(selectedServiceType);

      // final isDeepClean =
      //     stringToServiceType(selectedServiceType ?? "") ==
      //     ServiceType.deepClean;
      final isServiceItemsFlow = deepCleanState.chosenServices.isNotEmpty;
// final isServiceItemsFlow =
//     selectedServiceType == 'Deep Clean' || selectedServiceType == 'Maintenance';
      // Build serviceItems only when Deep Clean (or any future service-items flow)
      final List<ServiceItemParam>? serviceItems = isServiceItemsFlow
          ? deepCleanState.chosenServices
                .map(
                  (s) => ServiceItemParam(
                    itemCode: s.itemCode,
                    rate: s.rate ?? 0,
                    priceListRate: s.rate,
                    qty: deepCleanState.qtyFor(s.itemCode),
                  ),
                )
                .toList()
          : null;

      final result = await submitServiceRepo.submitService(
        SubmitServiceParams(
          shift: availabilityController.selectedShiftType,
          isPartTime: availabilityController.isPartTime,
          customerId: customerController.selectedCustomer!.customerId,
          customerName: customerController.selectedCustomer!.customerName,
          driver: driverPaymentController.selectedDriver!.driverId,
          date: isServiceItemsFlow
              ? _formatDate(deepCleanState.selectedDate ?? DateTime.now())
              : availabilityController.selectedDate,
          // serviceType: availabilityController.selectedPackage!.id,
          shiftType: isServiceItemsFlow
              ? _shiftForBackend(deepCleanState.selectedShift?.label)
              : availabilityController.selectedShiftType,
          days: availabilityController.selectedDays,
          employees: isServiceItemsFlow
              ? const []
              : employeesController.selectedEmployees,
          assignedEmployeesPerDate: isServiceItemsFlow || isDailyService
              ? null
              : availabilityController.assignedEmployeesPerDate,
          // ---- serviceType ----
          serviceType: isServiceItemsFlow
              ? mode.orderServiceType
              : (!isDailyService ? 'Flexible' : 'Daily'),
          paymentMethod: driverPaymentController.selectedPaymentMethod,
          totalAmount: driverPaymentController.originalCost.toString(),
          totalNetAmount: driverPaymentController.newCost,
          discountCost: driverPaymentController.discountedCost,
          discountType: driverPaymentController.selectedDiscount?.id,
          cleaningSuppliesFees:
              driverPaymentController.fees ??
              driverPaymentController.costAfterCleaningSuplies,
          discountPercentage: driverPaymentController.discountPercentage
              .toString(),
          withCleaningSupplies: driverPaymentController.withCleaningSupplies,
          // cleaningFee: driverPaymentController.fees,
          note: driverPaymentController.note,
          useAdvancedPayment: driverPaymentController.isAdvancedBalance,
          flexibleOption: (isDailyService || isServiceItemsFlow)
              ? null
              : availabilityControllerNotifier.requiredVisits.toString(),
          overTimeHours: isServiceItemsFlow ? null : employeesController.overtimeHours,
          outstandingBalance: driverPaymentController.isAdvancedBalance,
          serviceItems: serviceItems,
        ),
      );
      debugPrint(
        "BBBBBBBBBBBBBB${driverPaymentController.withCleaningSupplies}",
      );
      state = state.copyWith(
        submitServiceStates: result
            ? RequestStates.loaded
            : RequestStates.error,
        submitServiceMessage: result ? 'loadded successfully' : "server error",
      );
      if (result) {
        ref.invalidate(employeesControllerProvider);
        ref.invalidate(customerControllerProvider);
        ref.invalidate(availabilityControllerProvider);
        ref.invalidate(driversPaymentControllerProvider);
        ref.invalidate(deepCleanControllerProvider);
      }
      return result;
    } catch (e) {
      state = state.copyWith(
        submitServiceStates: RequestStates.error,
        submitServiceMessage: e.toString(),
      );
      throw "";
    }
  }

  String _formatDate(DateTime d) =>
      '${d.year.toString().padLeft(4, '0')}-'
      '${d.month.toString().padLeft(2, '0')}-'
      '${d.day.toString().padLeft(2, '0')}';

  String _shiftForBackend(String? uiLabel) {
    switch (uiLabel) {
      case 'Full day':
      case 'Full Day':
        return 'Full Day';
      case 'Morning':
        return 'Morning Shift';
      case 'Evening':
        return 'Evening Shift';
      default:
        return uiLabel ?? 'Full Day';
    }
  }
}
