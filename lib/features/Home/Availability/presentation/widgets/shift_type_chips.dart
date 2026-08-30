import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hcs/features/Home/Availability/presentation/controllers/availability_controller.dart';
import 'package:hcs/src/enums/service_type.dart';
import 'package:hcs/src/extenssions/widget_extensions.dart';
import 'package:hcs/src/manager/app_strings.dart';
import 'package:hcs/src/theme/app_colors.dart';

import '../../../Employees/presentation/controllers/employees_controller.dart';

/// ShiftTypeChips now reads initial selectedState from Riverpod
/// and updates purely via provider state, no internal index needed.
class ShiftTypeChips extends ConsumerWidget {
  const ShiftTypeChips({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pkg = ref.watch(
      availabilityControllerProvider.select((s) => s.selectedPackage),
    );
    final selectedServiceType = ref.watch(
      availabilityControllerProvider.select((s) => s.selectedServiceType),
    );
    final isDaily =
        pkg?.id == 'Daily' ||
        stringToServiceType(selectedServiceType ?? "On Call") !=
            ServiceType.packages;

    final List<String> dailyShiftOptions = [
      ShiftType.morning,
      ShiftType.evening,
      ShiftType.fullDay,
      ShiftType.overTime,
    ].map(shiftTypeToString).toList();

    final List<String> packageShiftOptions = [
      ShiftType.fullDay,
      ShiftType.partTime,
    ].map(shiftTypeToString).toList();

    final List<String> shiftOptions = [
      ShiftType.morning,
      ShiftType.evening,
    ].map(shiftTypeToString).toList();

    // ✔ only these for packages
    // Options labels
    final options = isDaily ? dailyShiftOptions : packageShiftOptions;

    // [
    //   ShiftType.morning,
    //   ShiftType.evening,
    //   ShiftType.fullDay,
    //   ShiftType.overTime,
    // ].map(shiftTypeToString).toList();

    // Current selected from state
    final selectedShift = ref.watch(
      availabilityControllerProvider.select((s) => s.selectedShiftType),
    );
    final availabilState = ref.read(availabilityControllerProvider);
    final notifier = ref.read(availabilityControllerProvider.notifier);
    final employeeNotifier = ref.read(employeesControllerProvider.notifier);
    final employeeState = ref.watch(employeesControllerProvider);
  final assignedPackageDates =
        ref.watch(
          availabilityControllerProvider.select((s) => s.assignedDates),
        ) ??
        [];
    final generated =
        ref.watch(
          availabilityControllerProvider.select((s) => s.generatedDates),
        ) ??
        [];
    final selectedDateState = ref.watch(
      availabilityControllerProvider.select((value) => value.selectedDate),
    );
    final selectedPartTimeShift = ref.watch(
      availabilityControllerProvider.select(
        (value) => value.selectedPartTimeShift,
      ),
    );
    final assignedShiftMap =
        ref.watch(
          availabilityControllerProvider.select((s) => s.assignedShiftPerDate),
        ) ??
        {};
final String today =
    DateFormat('yyyy-MM-dd').format(DateTime.now());
    // helper: is a shift already used in assignedShiftPerDate?
    bool isShiftUsed(String shift) {
      if (assignedShiftMap.isEmpty) return false;
      if (shift == 'Part Time') {
        // any assigned value starting with 'Part Time' means Part Time was used
        return assignedShiftMap.values.any((v) => v.startsWith('Part Time'));
      }
      return assignedShiftMap.values.any((v) => v == shift);
    }
final bool isEveningPackageDate =
    generated.any(
      (d) => DateFormat('yyyy-MM-dd').format(DateTime.parse(d.toString())) == today,
    ) &&
    DateTime.now().hour > 12;

final bool isEveningDailyDate =
    DateFormat('yyyy-MM-dd')
            .format(DateTime.parse(selectedDateState)) ==
        today &&
    DateTime.now().hour > 12;
final bool nowIsEvening = isDaily
    ? isEveningDailyDate
    : isEveningPackageDate;
  //  final bool nowIsEvening =
  //       (DateFormat('yyyy-MM-dd').format(DateTime.now()) ==
  //           selectedDateState) &&
  //       (DateTime.now().hour > 12);
    // auto-switch if morning not available for today's date (kept your previous logic)
    if (nowIsEvening && selectedShift == 'Morning Shift') {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        notifier.selectShift('Evening Shift');
      });
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      // mainAxisSize: MainAxisSize.max,
      children: [
        // Container(),
        Text(
          context.tr(AppStrings.shiftType),
          style: Theme.of(context).textTheme.displayMedium,
        ),
        8.verticalSpace,
        Wrap(
          // spacing: 10.w,
          runSpacing: 12.h,
          
          crossAxisAlignment: WrapCrossAlignment.center,
          children: options.map((label) {
            if (nowIsEvening && (label == 'Morning Shift'||label == 'Full Day')) {
              return SizedBox();
            }
            final used = isShiftUsed(label);
            final isSelected = label == selectedShift||label.startsWith(selectedShift);
            final lockPartTime=selectedShift.contains(shiftTypeToString(ShiftType.partTime)) && availabilState.assignedEmployeesPerDate!=null;
            // if (i == 0) {
            //   if (_isEvening&&isDaily) return SizedBox.shrink();
            // }
            debugPrint("selectedShift $selectedShift");
            debugPrint("DateTime.now().hour ${DateTime.now().hour}");
            debugPrint("selectedDateState $selectedDateState");
            debugPrint("isEveningPackageDate $isEveningPackageDate");
            debugPrint("label $label");
            debugPrint("isSelected $isSelected");
            debugPrint("${label.startsWith(selectedShift)}");
            return GestureDetector(
              onTap:
                  !isDaily &&lockPartTime
                  ? null
                  : () {
                      notifier.selectShift(label);
                      // If OverTime chosen, auto-select company category (your previous behavior)

                      if (label == shiftTypeToString(ShiftType.overTime)) {
                        // Auto-select company
                        debugPrint("Povertime ");
                        ref
                            .read(employeesControllerProvider.notifier)
                            .selectServiceCategory(
                              serviceCategoryToString(ServiceCategory.company),
                            );
                        // ref.read(employeesControllerProvider.notifier).clearSelectedEmployees();

                        // Also update service category in availabilityController if necessary:
                        // ref.read(availabilityControllerProvider.notifier)
                        //     .selectServiceType(ServiceType.company);
                      }
                    },
              child: Opacity(
                opacity:
                    !isDaily &&lockPartTime
                    ? 0.45
                    : 1.0,
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  width: 160.w,
                  height: 48.h,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.white
                        : AppColors.unSelectedGrey,
                    border: isSelected
                        ? Border.all(color: AppColors.blueText, width: 0.5)
                        : null,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    label,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: isSelected
                          ? AppColors.blueText
                          : AppColors.unSelectedText,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        if (!isDaily &&selectedShift.contains(shiftTypeToString(ShiftType.partTime)) )
          Wrap(
            spacing: 10.w,
            runSpacing: 16.h,

            crossAxisAlignment: WrapCrossAlignment.center,
            children: shiftOptions.map((label) {
              final used = (assignedShiftMap.values.any(
                (v) => v == 'Part Time: $label' || v == label,
              ));
              final isSelected = label == selectedPartTimeShift;
              // if (i == 0) {
                if (isEveningPackageDate&&label=="Morning Shift") return SizedBox.shrink();
              // }
              return GestureDetector(
                onTap:
                //  used
                //     ? null
                //     : 
                    () {
                        notifier.selectPartTimeShift(label);
                        // if (label == shiftTypeToString(ShiftType.overTime)) {
                        //   // Auto-select company
                        //   debugPrint("Povertime ");
                        //   ref
                        //       .read(employeesControllerProvider.notifier)
                        //       .selectServiceCategory(serviceCategoryToString( ServiceCategory.company));

                        //   // Also update service category in availabilityController if necessary:
                        //   // ref.read(availabilityControllerProvider.notifier)
                        //   //     .selectServiceType(ServiceType.company);
                        // }
                      },
                child: Opacity(
                  opacity:
                  //  used ? 0.45 :
                   1.0,
                  child: Container(
                    alignment: Alignment.center,
                    width: 160.w,
                    height: 48.h,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.white
                          : AppColors.unSelectedGrey,
                      border: isSelected
                          ? Border.all(color: AppColors.blueText, width: 0.5)
                          : null,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Text(
                      label,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: isSelected
                            ? AppColors.blueText
                            : AppColors.unSelectedText,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ).symmetricPadding(vertical: 20),
        if (selectedShift == shiftTypeToString(ShiftType.overTime))
          TextFormField(
            controller: TextEditingController(
              text: employeeState.overtimeHours,
            ),
            //  enabled:
            //     driversPaymentState
            //         .selectedDiscount
            //         ?.discountPercentage !=
            //     0,
            keyboardType: TextInputType.numberWithOptions(
              signed: true,
              decimal: true,
            ),
            textInputAction: TextInputAction.done,
            validator: (value) {
              if(value==null){
                return "this field is required";
              }
              else if(value.isEmpty){
                return "this field is required";

              }
              return "";
            },
            onChanged: (value) {
              employeeNotifier.setOvertimeHours(value);
              
            },
            onFieldSubmitted: (value) {
              employeeNotifier.setOvertimeHours(value);
            },
         
            decoration: InputDecoration(
              labelText: "Overtime Hours",
              hintStyle: Theme.of(context).inputDecorationTheme.hintStyle,
            ),
          ).onlyPadding(top: 20),
      ],
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:hcs/features/Home/Availability/presentation/controllers/availability_controller.dart';
// import 'package:hcs/features/Home/Employees/presentation/controllers/employees_controller.dart';
// import 'package:hcs/src/enums/service_type.dart';
// import 'package:hcs/src/theme/app_colors.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:intl/intl.dart';

// class ShiftTypeChips extends ConsumerWidget {
//   const ShiftTypeChips({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final options = ['Morning Shift', 'Evening Shift', 'Full Day', 'OverTime'];
//     final selectedShift = ref.watch(
//       availabilityControllerProvider.select((s) => s.selectedShiftType),
//     );

//     final employeesSelected = ref.watch(
//       employeesControllerProvider.select((s) => s.selectedEmployees.isNotEmpty),
//     );

//     // if it's evening and morning selected, auto switch (kept from your previous logic)
//     final selectedDateState = ref.watch(
//       availabilityControllerProvider.select((s) => s.selectedDate),
//     );

//     final bool _isEvening =
//         (DateFormat('yyyy-MM-dd').parse(selectedDateState) ==
//             DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day) &&
//             (DateTime.now().hour > 10));

//     if (_isEvening && selectedShift == 'Morning Shift') {
//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         ref.read(availabilityControllerProvider.notifier).selectShift('Evening Shift');
//       });
//     }

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text("Shift Type"),
//         const SizedBox(height: 8),
//         Wrap(
//           spacing: 10,
//           runSpacing: 12,
//           children: options.map((label) {
//             final isSelected = label == selectedShift;
//             return GestureDetector(
//               onTap: employeesSelected
//                   ? null
//                   : () {

//                       ref.read(availabilityControllerProvider.notifier).selectShift(label);
//                       if (label == 'OverTime') {
//                         // auto select company in employees controller
//                         ref.read(employeesControllerProvider.notifier)  .selectServiceCategory(serviceCategoryToString( ServiceCategory.company));
//                         // you said also disable service category later - but here we keep it selected
//                       }
//                     },
//               child: Container(
//                 alignment: Alignment.center,
//                 width: 160,
//                 height: 48,
//                 decoration: BoxDecoration(
//                   color: isSelected ? AppColors.white : AppColors.unSelectedGrey,
//                   border: isSelected ? Border.all(color: AppColors.blueText, width: 0.5) : null,
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: Text(label, style: Theme.of(context).textTheme.bodyMedium!.copyWith(
//                   color: isSelected ? AppColors.blueText : AppColors.unSelectedText,
//                 )),
//               ),
//             );
//           }).toList(),
//         ),
//       ],
//     );
//   }
// }
