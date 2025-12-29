import 'package:flutter/material.dart';
import 'package:hcs/features/Home/Availability/presentation/controllers/availability_controller.dart';
import 'package:hcs/features/Home/Customer/presentation/controllers/customer_controller.dart';
import 'package:hcs/features/Home/Driver_Payment/presentation/controllers/drivers_payment_controllers.dart';
import 'package:hcs/features/Home/Employees/presentation/controllers/employees_controller.dart';
import 'package:hcs/features/Home/Submit_Service/data/models/submit_service_params.dart';
import 'package:hcs/features/Home/Submit_Service/data/repo/submit_servcie_repo.dart';
import 'package:hcs/features/Home/Submit_Service/presentation/submit_service_state.dart';
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
      final isDailyService = selectedPackageState?.id == 'Daily'||stringToServiceType(selectedServiceType ?? "On Call") !=
                  ServiceType.packages;
      final submitServiceRepo = ref.read(submitServiceRepositoryProvider);
      final customerController = ref.read(customerControllerProvider);
      final availabilityController = ref.read(availabilityControllerProvider);
      final availabilityControllerNotifier = ref.read(availabilityControllerProvider.notifier);
      final employeesController = ref.read(employeesControllerProvider);
      final driverPaymentController = ref.read(
        driversPaymentControllerProvider,
      );

      final result = await submitServiceRepo.submitService(
        SubmitServiceParams(
          shift: availabilityController.selectedShiftType,
          isPartTime: availabilityController.isPartTime,
          customerId: customerController.selectedCustomer!.customerId,
          customerName: customerController.selectedCustomer!.customerName,
          driver: driverPaymentController.selectedDriver!.driverId,
          date: availabilityController.selectedDate,
          serviceType:!isDailyService?"Flexible" : 'Daily',
          // serviceType: availabilityController.selectedPackage!.id,
          shiftType: availabilityController.selectedShiftType,
          days: availabilityController.selectedDays,
          employees: employeesController.selectedEmployees,
          assignedEmployeesPerDate: isDailyService
              ? null
              : availabilityController.assignedEmployeesPerDate,
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
          flexibleOption: isDailyService
              ? null
              :availabilityControllerNotifier.requiredVisits.toString(),
          overTimeHours:employeesController.overtimeHours,
          outstandingBalance: driverPaymentController.isAdvancedBalance
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
}
