import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hcs/features/Home/Availability/presentation/controllers/availability_controller.dart';
import 'package:hcs/features/Home/Customer/presentation/controllers/customer_controller.dart';
import 'package:hcs/features/Home/Driver_Payment/presentation/controllers/drivers_payment_controllers.dart';
import 'package:hcs/features/Home/Employees/presentation/controllers/employees_controller.dart';
import 'package:hcs/features/Home/Submit_Service/data/models/submit_service_params.dart';
import 'package:hcs/features/Home/Submit_Service/data/submit_servcie_repo.dart';
import 'package:hcs/features/Home/Submit_Service/presentation/submit_service_state.dart';
import 'package:hcs/gen/assets.gen.dart';
import 'package:hcs/src/enums/request_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'submit_service_controller.g.dart';

@riverpod
class SubmitServiceController extends _$SubmitServiceController {
  @override
  SubmitServiceState build() => const SubmitServiceState();

  Future<void> submitService(
    // BuildContext context
  ) async {
    state = state.copyWith(submitServiceStates: RequestStates.loading);

    try {
      final submitServiceRepo = ref.read(submitServiceRepositoryProvider);
      final customerController = ref.read(customerControllerProvider);
      final availabilityController = ref.read(availabilityControllerProvider);
      final employeesController = ref.read(employeesControllerProvider);
      final driverPaymentController = ref.read(
        driversPaymentControllerProvider,
      );
      debugPrint(
        '${customerController.selectedCustomer!.customerId} 3y2 custoemrId',
      );
      debugPrint(
        '${driverPaymentController.selectedDriver!.driverId} 3y2 driverId',
      );
      debugPrint('${availabilityController.selectedDate} 3y2 selectedDate');

      debugPrint(
        '${availabilityController.selectedPackage!.id} 3y2 selectedPackage',
      );
      debugPrint(
        '${availabilityController.selectedShiftType} 3y2 selectedShiftType',
      );
      debugPrint(
        '${employeesController.selectedEmployees} 3y2 selectedEmployees',
      );
      debugPrint(
        '${driverPaymentController.selectedPaymentMethod!} 3y2 selectedPaymentMethod',
      );
      // // ✅ Show dialog on success
      // showDialog(
      //   context: context,
      //   builder: (_) => AlertDialog(
      //     title: Assets.images.successful.svg(),
      //     content: Text(
      //       'Service has been \n requested successfully.',
      //       textAlign: TextAlign.center,
      //       style: Theme.of(
      //         context,
      //       ).textTheme.displayMedium!.copyWith(fontSize: 20.sp),
      //     ),
      //   ),
      // );
      final submitServiceData = await submitServiceRepo.submitService(
        SubmitServiceParams(
          customer: customerController.selectedCustomer!.customerId,
          driver: driverPaymentController.selectedDriver!.driverId,
          date: availabilityController.selectedDate,
          serviceType: availabilityController.selectedPackage!.id,
          shiftType: availabilityController.selectedShiftType,
          days: null,
          employees: employeesController.selectedEmployees,
          paymentMethod: driverPaymentController.selectedPaymentMethod!,
        ),
      );

      // debugPrint("currentCustomersPage #1 : ${state.currentCustomersPage.toString()}");
      state = state.copyWith(
        submitServiceStates: RequestStates.loaded,
        submitServiceMessage: 'loadded successfully',
      );
    } catch (e) {
      state = state.copyWith(
        submitServiceStates: RequestStates.error,
        submitServiceMessage: e.toString(),
      );
    }
  }
}
