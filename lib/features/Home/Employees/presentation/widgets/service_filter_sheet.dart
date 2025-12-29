import 'dart:ffi';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hcs/features/Home/Availability/presentation/controllers/availability_controller.dart';
import 'package:hcs/features/Home/Availability/presentation/widgets/date_selection_widget.dart';
import 'package:hcs/features/Home/Availability/presentation/widgets/packages_dropdown.dart';
import 'package:hcs/features/Home/Availability/presentation/widgets/shift_type_chips.dart';
import 'package:hcs/features/Home/Employees/presentation/controllers/employees_controller.dart';
import 'package:hcs/features/Home/Employees/presentation/widgets/service_category.dart';
import 'package:hcs/src/enums/service_type.dart';
import 'package:hcs/src/extenssions/int_extenssion.dart';
import 'package:hcs/src/theme/app_colors.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../../../src/manager/app_strings.dart';
import '../../../../../src/shared_widgets/custom_button.dart';
import '../../../Availability/presentation/widgets/days_selctions_chips.dart';
import 'date_picker_widget.dart';

/// **Bottom Sheet for Truck Selection**
class ServiceFilterSheet extends ConsumerWidget {
  final bool firstTime;
  const ServiceFilterSheet({super.key, required this.firstTime});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var selectedPackageState = ref.watch(
      availabilityControllerProvider.select((value) => value.selectedPackage),
    );
    final selectedServiceType = ref.watch(
      availabilityControllerProvider.select((s) => s.selectedServiceType),
    );
    // final employeesSelected = ref.watch(
    //   employeesControllerProvider.select((s) => s.selectedEmployees.isNotEmpty),
    // );
    final employeesSelected = ref.watch(
      availabilityControllerProvider.select((s) => s.assignedEmployeesPerDate?.entries.isNotEmpty),
    );

    final bool dailyService = selectedPackageState?.id == 'Daily'||stringToServiceType(selectedServiceType ?? "On Call") !=
                  ServiceType.packages;
    bool _loading = false;

    return SizedBox(
      height: 800,
      width: double.infinity,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 30),
        decoration: BoxDecoration(
          // color: Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "${"Filter".tr()}:",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  if (!firstTime) ...[
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.close, color: AppColors.primary),
                    ),
                  ],
                ],
              ),
              24.verticalSpace,

              Text(
                context.tr(AppStrings.serviceCategory),
                style: Theme.of(context).textTheme.displayMedium,
              ),
              16.verticalSpace,
              Consumer(
                builder: (context, ref, child) {
                  var selectedServiceType = ref.read(
                    availabilityControllerProvider.select(
                      (value) => value.selectedServiceType,
                    ),
                  );
                  return ServiceCategoryChips(
                    selectedChip: selectedServiceType!,
                  );
                },
              ),
              24.verticalSpace,

              // Packages dropdown (disable while employees assigned)
              if (stringToServiceType(selectedServiceType ?? "On Call") ==
                  ServiceType.packages)
                Consumer(
                  builder: (ctx, r, _) {
                    final packages = r.watch(
                      availabilityControllerProvider.select((s) => s.packages),
                    );
                    final selPkg = r.watch(
                      availabilityControllerProvider.select(
                        (s) => s.selectedPackage,
                      ),
                    );
                    final hasAssigned = r.watch(
                      availabilityControllerProvider.select(
                        (s) => (s.assignedDates?.length ?? 0) > 0,
                      ),
                    );
                    return IgnorePointer(
                      ignoring: employeesSelected??false, // disable on refilter
                      child: Opacity(
                        opacity: employeesSelected??false ? 0.4 : 1.0,
                        child: PackagesDropdown(
                          items: packages,
                          selectedPackage: selPkg,
                          onSelected: (p) {
                            r
                                .read(availabilityControllerProvider.notifier)
                                .selectPackage(p);
                          },
                        ),
                      ),
                    );
                  },
                ),

              20.verticalSpace,

              // Consumer(
              //   builder: (context, ref, child) {
              //     var packagesState = ref.watch(
              //       availabilityControllerProvider.select(
              //         (value) => value.packages,
              //       ),
              //     );
              //     // final filteredPackages =
              //     //         packagesState.where((item) => item.id == "Company").toList();
              //     // 1) filter out "Company"
              //     final filtered = packagesState
              //         .where((p) => p.id != "Company")
              //         .toList();

              //     // 2) de-duplicate by id (in case backend sends duplicates)
              //     final filteredUnique = {
              //       for (final p in filtered) p.id: p,
              //     }.values.toList();

              //     // 3) ensure selected value exists exactly once in items
              //     final selectedPackage = ref.watch(
              //       availabilityControllerProvider.select(
              //         (v) => v.selectedPackage,
              //       ),
              //     );

              //     final selectedInList =
              //         selectedPackage != null &&
              //         filteredUnique.any((p) => p.id == selectedPackage.id);

              //     final effectiveSelected = selectedInList
              //         ? selectedPackage
              //         : filtered.first;

              //     final selectedServiceType = ref.watch(
              //       availabilityControllerProvider.select(
              //         (v) => v.selectedServiceType,
              //       ),
              //     );

              //     var selectedPackageState = ref.watch(
              //       availabilityControllerProvider.select(
              //         (value) => value.selectedPackage,
              //       ),
              //     );
              //     // var selectedServiceType = ref.watch(
              //     //   availabilityControllerProvider.select(
              //     //     (value) => value.selectedServiceType,
              //     //   ),
              //     // );

              //     return stringToServiceType(selectedServiceType!) ==
              //             ServiceType.packages
              //         ? Column(
              //             children: [
              //               PackagesDropdown(
              //                 items: filteredUnique,
              //                 selectedPackage: effectiveSelected,
              //                 onSelected: (p0) {
              //                   Future(
              //                     () => ref
              //                         .read(
              //                           availabilityControllerProvider.notifier,
              //                         )
              //                         .selecPackage(p0),
              //                   );
              //                 },
              //               ),
              //               24.verticalSpace,
              //             ],
              //           )
              //         : SizedBox.shrink();
              //   },
              // ),
            
              Consumer(
                builder: (context, ref, _) {
                  final hasSelected = ref.watch(
                    employeesControllerProvider.select(
                      (s) => s.selectedEmployees.isNotEmpty,
                    ),
                  );
                  // For dailyService we keep normal disabling (can't change if employees selected)

                  return IgnorePointer(
                    ignoring: !dailyService
                        ? false
                        : hasSelected, // ⛔ Disable when employees selected
                    child: Opacity(
                      opacity: hasSelected && dailyService ? 0.4 : 1.0,
                      child: const ShiftTypeChips(),
                    ),
                  );
                },
              ),
              24.verticalSpace,

              // Days selection (packages only)
              if (!dailyService) DaysSelectionChips(),

              20.verticalSpace,

              // List of generated dates (unassigned) and state info
              if (!dailyService) const DateSelectionWidget(),
              20.verticalSpace,

            

              //? Calendar (daily uses date form field; packages uses calendar with disabled already-assigned dates)
              Consumer(
                builder: (context, ref, child) {
                  final hasSelected = ref.watch(
                    employeesControllerProvider.select(
                      (s) => s.selectedEmployees.isNotEmpty,
                    ),
                  );
                  return IgnorePointer(
                    ignoring: !dailyService
                        ? false
                        : hasSelected, // disable when employee selected
                    child: Opacity(
                      opacity: hasSelected && dailyService ? 0.4 : 1,
                      child: const DateSelectionCalendarWidget(),
                    ),
                  );
                },
              ),

              24.verticalSpace,

              // Date format table (generated dates)
              Padding(
                padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 22.w),
                child: Consumer(
                  builder: (context, ref, child) {
                    var availabilityNotifier = ref.read(
                      availabilityControllerProvider.notifier,
                    );
                    var selectedPackageState = ref.watch(
                      availabilityControllerProvider.select(
                        (value) => value.selectedPackage,
                      ),
                    );
                    var selectedServiceType = ref.watch(
                      availabilityControllerProvider.select(
                        (value) => value.selectedServiceType,
                      ),
                    );
                    final remainingVisits =
                        availabilityNotifier.remainingVisits;

                    return CustomButton(
                      title:
                          stringToServiceType(selectedServiceType!) ==
                              ServiceType.packages
                          ? tr(context: context, AppStrings.next)
                          : tr(context: context, AppStrings.checkAvailability),
                      onPressed: 
                      // selectedPackageState == null
                      //     ? null
                      //     :
                           () {
                              if (stringToServiceType(selectedServiceType) ==
                                  ServiceType.packages) {
                                // if (remainingVisits.isEmpty && availabilityNotifier.assignedDatesCount == 0) {
                                //   showDialog(
                                //     context: context,
                                //     builder: (context) => AlertDialog(
                                //       title: Text("No Dates Selected"),
                                //       content: Text("Please select days and dates for your visits."),
                                //       actions: [
                                //         TextButton(
                                //           onPressed: () => Navigator.pop(context),
                                //           child: Text("OK"),
                                //         ),
                                //       ],
                                //     ),
                                //   );
                                //   return;
                                // }
                              }
                              ref
                                  .read(employeesControllerProvider.notifier)
                                  .fetchEmployees(page: 1);
                              Navigator.of(context).pop();

                              

                              // selectedPackageState.id == 'Daily'
                              //     ? context.pushRoute(EmployeesRoute())
                              //     : context.pushRoute(DaysSelectionRoute());
                              // if (_formKey.currentState!.validate()) {}
                            },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> showServiceFilterSheet({
  required BuildContext context,
  required bool firstTime,
}) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    isDismissible: !firstTime,
    backgroundColor: AppColors.scaffoldColor,
    enableDrag: !firstTime,
    useSafeArea: true,
    sheetAnimationStyle: AnimationStyle(
      curve: Curves.easeInOutBack,
      duration: Duration(milliseconds: 500),
    ),
    // showDragHandle: true,
    // constraints: BoxConstraints(maxHeight: double.infinity),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) => FractionallySizedBox(
      heightFactor: 0.8,
      child: ServiceFilterSheet(firstTime: firstTime),
    ),
  );
}

void showInfoDialog({required BuildContext context, required String message}) {
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: Text("Notice"),
      content: Text(message),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: Text("OK")),
      ],
    ),
  );
}
