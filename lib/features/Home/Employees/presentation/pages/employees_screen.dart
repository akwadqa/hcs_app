import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hcs/features/Home/Availability/presentation/controllers/availability_controller.dart';
import 'package:hcs/features/Home/Employees/presentation/controllers/employees_controller.dart';
import 'package:hcs/features/Home/Employees/presentation/widgets/employee_bar_chips.dart';
import 'package:hcs/features/Home/Employees/presentation/widgets/search_field.dart';
import 'package:hcs/features/Home/Employees/presentation/widgets/service_filter_sheet.dart';
import 'package:hcs/gen/assets.gen.dart';
import 'package:hcs/src/enums/request_state.dart';
import 'package:hcs/src/enums/service_type.dart';
import 'package:hcs/src/manager/app_strings.dart';
import 'package:hcs/src/shared_widgets/app_error_widget.dart';
import 'package:hcs/src/shared_widgets/app_pagination_widget.dart';
import 'package:hcs/src/shared_widgets/custom_appbar.dart';
import 'package:hcs/src/shared_widgets/custom_button.dart';
import 'package:hcs/src/shared_widgets/fade_circle_loading_indicator.dart';
import 'package:hcs/src/theme/app_colors.dart';

import '../../../../../src/routing/app_router.gr.dart';
import '../../../Driver_Payment/presentation/pages/order_summary_page.dart';

@RoutePage()
class EmployeesScreen extends ConsumerStatefulWidget {
  const EmployeesScreen({super.key});

  @override
  ConsumerState<EmployeesScreen> createState() => _EmployeesScreenState();
}

class _EmployeesScreenState extends ConsumerState<EmployeesScreen> {
  // ScrollController _scrollController = ScrollController();
  //   Timer? _loadMoreTimer;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future(
        () => ref.read(availabilityControllerProvider.notifier).fetchPackages(),
      );
      showServiceFilterSheet(context: context, firstTime: true);
    });
    // pagination listener only once:
    // _scrollController.addListener(() {
    //    final appointmentsStates = ref.read(employeesControllerProvider);
    // final hasMore = appointmentsStates.currentEmployeesPage != null;

    // if (_scrollController.position.pixels >
    //         _scrollController.position.maxScrollExtent - 100 &&
    //     hasMore) {
    //   _loadMoreTimer?.cancel();
    //   _loadMoreTimer = Timer(const Duration(milliseconds: 500), () {
    //     ref
    //         .read(employeesControllerProvider.notifier)
    //         .onLoadMoreEmployees();
    //   });
  }

  // final max = _scrollController.position.maxScrollExtent;
  // final pos = _scrollController.position.pixels;
  // final nextPage = ref
  //     .read(employeesControllerProvider)
  //     .currentEmployeesPage;

  // if (pos == max && nextPage != null) {
  //   ref.read(employeesControllerProvider.notifier).onLoadMoreEmployees();
  // }
  // });

  @override
  Widget build(BuildContext context) {
    var selectedPackageState = ref.watch(
      availabilityControllerProvider.select((value) => value.selectedPackage),
    );
    final selectedServiceType = ref.watch(
      availabilityControllerProvider.select((s) => s.selectedServiceType),
    );
    final bool dailyService =
        selectedPackageState?.id == 'Daily' ||
        stringToServiceType(selectedServiceType ?? "On Call") !=
            ServiceType.packages;
    final availabilityNotifier = ref.read(
      availabilityControllerProvider.notifier,
    );
    final stillMissing = availabilityNotifier.missingVisits;
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        ref.read(availabilityControllerProvider.notifier).resetAllSelections();
      },
      child: Scaffold(
        body: _buildContent(),
        appBar: CustomAppbar(
          hasBackArrow: true,
          actions: [
            GestureDetector(
              onTap: () {
                // availabilityNotifier.resetSelectedDays();

                availabilityNotifier.resetSelectionsOnFilterChange();
                showServiceFilterSheet(context: context, firstTime: false);
              },
              child: Row(
                children: [
                  Icon(Icons.filter_alt_sharp, color: AppColors.primary),
                  6.horizontalSpace,
                  Text(
                    "filter".tr(),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.fromLTRB(24.w, 8, 24.w, 16.h),
          child: Consumer(
            builder: (context, ref, _) {
              final selected = ref.watch(
                employeesControllerProvider.select((s) => s.selectedEmployees),
              );
              final availabilityState = ref.read(
                availabilityControllerProvider,
              );

              // ✅ Check actual assigned vs required
              final assignedCount =
                  availabilityState.assignedDates?.length ?? 0;
              final requiredCount = availabilityNotifier.requiredVisits;
              final allAssigned = assignedCount >= requiredCount;

              return Row(
                children: [
                  //? Show save button if we have select employee and service type is package
                  if (selected.isNotEmpty && !dailyService)
                    Flexible(
                      child: CustomButton(
                        title: tr(context: context, AppStrings.save),
                        onPressed: selected.isEmpty
                            ? null
                            : () {
                                final remaining =
                                    availabilityNotifier.remainingVisits;

                                if (remaining.isEmpty) {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: Text("No Dates Available"),
                                      content: Text(
                                        "Please reopen filter to select dates.",
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: Text("OK"),
                                        ),
                                      ],
                                    ),
                                  );
                                  return;
                                }

                                // Lock current dates with employees
                                final sc = ref
                                    .read(employeesControllerProvider)
                                    .serviceCategory;

                                availabilityNotifier.assignEmployees(
                                  selected,
                                  sc,
                                );
                                ref
                                    .read(
                                      availabilityControllerProvider.notifier,
                                    )
                                    .submitSelectedDays();
                                // Clear selection
                                ref
                                    .read(employeesControllerProvider.notifier)
                                    .clearSelectedEmployees();

                                // Check remaining
                                final newAssignedCount =
                                    availabilityNotifier.assignedDatesCount;

                                final stillMissing =
                                    availabilityNotifier.missingVisits;

                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text("Saved"),
                                    content: Text(
                                      stillMissing > 0
                                          ? "Employees assigned to ${remaining.length} visit(s)!\n\n"
                                                "You still have $stillMissing visit(s) remaining.\n"
                                                "Reopen filter to assign remaining visits."
                                          : "All visits assigned!",
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: Text("OK"),
                                      ),
                                    ],
                                  ),
                                );

                                //     final selectedEmployees = ref.read(employeesControllerProvider).selectedEmployees;
                                // ref.read(availabilityControllerProvider.notifier)
                                //    .assignEmployees(selectedEmployees);

                                // context.pushRoute(DriverPaymentRoute());
                              },
                      ),
                    ),

                  10.horizontalSpace,
                  Flexible(
                    child: CustomButton(
                      title: tr(context: context, AppStrings.next),
                      onPressed: selected.isEmpty && dailyService
                          // allAssigned||    stillMissing == 0
                          ? null
                          : () {
                              if (dailyService) {
                                context.pushRoute(DriverPaymentRoute());
                                return;
                              }

                              // final availabilityNotifier = ref.read(
                              //   availabilityControllerProvider.notifier,
                              // );
                              // final availabilityState = ref.read(
                              //   availabilityControllerProvider,
                              // );

                              // // debug print the current filter & date state
                              // debugPrint(
                              //   '[EmployeesScreen] before assign - selectedPackage=${availabilityState.selectedPackage?.id} selectedShift=${availabilityState.selectedShiftType} selectedDays=${availabilityState.selectedDays} generatedDates=${availabilityState.generatedDates?.map((d) => availabilityNotifier.format(d)).toList()} assignedDates=${availabilityState.assignedDates?.map((d) => availabilityNotifier.format(d)).toList()}',
                              // );

                              // if (availability.hasUnassignedVisits) {
                              //   showDialog(
                              //     context: context,
                              //     builder: (context) => AlertDialog(
                              //       title: Text("Notice"),
                              //       content: Text(
                              //         "You still have ${int.parse(availability.requiredVisits.toString()) - availability.selectedDatesCount} visits not assigned to any days.",
                              //       ),
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
                              // final employees = ref
                              //     .read(employeesControllerProvider)
                              //     .selectedEmployees;
                              // // 1) assign them to the CURRENT generated dates (this updates availability state)
                              // // availabilityNotifier.assignEmployees(employees);

                              // // 2) build order summary from availability state

                              // final order = availabilityNotifier.buildOrderSummary();

                              // debugPrint(
                              //   '[EmployeesScreen] final Order built, navigating to summary',
                              // );

                              // // OPTION 1 (Dialog)
                              // // showOrderSummaryDialog(context, order);
                              // // OPTION 2 (Page)
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (_) => OrderSummaryPage(order: order),
                              //   ),
                              // );

                              final stillMissing =
                                  availabilityNotifier.missingVisits;

                              if (availabilityNotifier.hasUnassignedVisits) {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text("Notice"),
                                    content: Text(
                                      "You still have $stillMissing visit(s) not assigned.\n\n"
                                      "Please press 'Save' first, then reopen filter to assign remaining visits.",
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: Text("OK"),
                                      ),
                                    ],
                                  ),
                                );
                                return;
                              }
                              final employees = ref
                                  .read(employeesControllerProvider)
                                  .selectedEmployees;
                              // 1) assign them to the CURRENT generated dates (this updates availability state)
                              // availabilityNotifier.assignEmployees(employees);

                              // 2) build order summary from availability state

                              final order = availabilityNotifier
                                  .buildOrderSummary();

                              debugPrint(
                                '[EmployeesScreen] final Order built, navigating to summary',
                              );

                              // OPTION 1 (Dialog)
                              // showOrderSummaryDialog(context, order);
                              // OPTION 2 (Page)
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      OrderSummaryPage(order: order),
                                ),
                              );
                            },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Padding(
      padding: EdgeInsets.only(left: 18.w, right: 18, top: 20),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            SearchField(
              onFieldSubmitted: (value) {
                var epmloyeeNotifier = ref.read(
                  employeesControllerProvider.notifier,
                );

                epmloyeeNotifier.searchEmployee(value);
              },
            ),
            12.verticalSpace,

            Consumer(
              builder: (context, ref, child) {
                final employeesState = ref.watch(employeesControllerProvider);

                return Align(
                  alignment: Alignment.centerLeft,
                  child: Wrap(
                    alignment: WrapAlignment.start,
                    spacing: 8.w,
                    runSpacing: 5.h,
                    children: employeesState.selectedEmployees
                        .map(
                          (e) => SelectedEmployeeCard(
                            name: e.employeeName,
                            onTap: () {
                              ref
                                  .read(employeesControllerProvider.notifier)
                                  .unSelectEmployee(e);
                            },
                          ),
                        )
                        .toList(),
                  ),
                );
              },
            ),
            // 24.verticalSpace,

            // Text(
            //   context.tr(AppStrings.serviceCategory),
            //   style: Theme.of(context).textTheme.displayMedium,
            // ),
            // 16.verticalSpace,
            // Consumer(
            //   builder: (context, ref, child) {
            //     var selectedServiceType = ref.watch(
            //       availabilityControllerProvider.select(
            //         (value) => value.selectedServiceType,
            //       ),
            //     );
            //     return ServiceCategoryChips(
            //       selectedChip: selectedServiceType!,
            //     );
            //   },
            // ),
            30.verticalSpace,
            Text(
              context.tr(AppStrings.employees),
              style: Theme.of(context).textTheme.displayMedium,
            ),
            24.verticalSpace,
            Consumer(
              builder: (context, ref, child) {
                final employeesState = ref.watch(employeesControllerProvider);

                if (employeesState.employeesStates == RequestStates.loaded) {
                  if (employeesState.employees.isEmpty) {
                    return Assets.images.noDataMin.image();
                  }
                  return Expanded(
                    child: AppPaginationWidget(
                      onLoading: (page) => ref
                          .read(employeesControllerProvider.notifier)
                          .onLoadMoreEmployees(),
                      child: ListView.separated(
                        // controller: _scrollController,
                        itemCount: employeesState.employees.length,
                        shrinkWrap: true,
                        // physics: BouncingScrollPhysics(),
                        // physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return EmployeeBarChip(
                            employee: employeesState.employees[index],
                            enabled: employeesState.selectedEmployees.contains(
                              employeesState.employees[index],
                            ),
                          );
                          // if (index ==
                          //     employeesState.employees.length) {
                          //   // Check if currentEmployeesPage is null and state is loaded
                          //   if ((employeesState.currentEmployeesPage ==
                          //       null)) {
                          //     return Center(
                          //       child: Text(
                          //         'No More Employees',
                          //         style: Theme.of(
                          //           context,
                          //         ).textTheme.bodyMedium,
                          //       ),
                          //     );
                          //   } else {
                          //     return Center(
                          //       child: FadeCircleLoadingIndicator(),
                          //     );
                          //   }
                          // } else {
                          //   return EmployeeBarChip(
                          //     employee:
                          //         employeesState.employees[index],
                          //     enabled: employeesState
                          //         .selectedEmployees
                          //         .contains(
                          //           employeesState.employees[index],
                          //         ),
                          //   );
                          // }
                        },
                        separatorBuilder: (_, __) => 16.verticalSpace,
                      ),
                    ),
                  );
                } else if (employeesState.employeesStates ==
                    RequestStates.error) {
                  return AppErrorWidget(
                    onTap: () => ref
                        .read(employeesControllerProvider.notifier)
                        .fetchEmployees(page: 1),
                  );
                } else if (employeesState.employeesStates ==
                    RequestStates.loading) {
                  return Center(child: FadeCircleLoadingIndicator());
                }

                return SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SelectedEmployeeCard extends StatelessWidget {
  final String name;
  final void Function() onTap;
  const SelectedEmployeeCard({
    super.key,
    required this.name,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        color: AppColors.unSelectedGrey,
        border: Border.all(style: BorderStyle.solid, color: AppColors.primary),
      ),

      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            name,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium!.copyWith(color: AppColors.blackText),
          ),
          8.horizontalSpace,
          GestureDetector(
            onTap: onTap,
            child: Icon(Icons.remove, color: AppColors.blackText),
          ),
        ],
      ),
    );
  }
}



// import 'dart:async';

// import 'package:auto_route/auto_route.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:hcs/features/Home/Availability/presentation/controllers/availability_controller.dart';
// import 'package:hcs/features/Home/Employees/presentation/controllers/employees_controller.dart';
// import 'package:hcs/features/Home/Employees/presentation/widgets/employee_bar_chips.dart';
// import 'package:hcs/features/Home/Employees/presentation/widgets/search_field.dart';
// import 'package:hcs/features/Home/Employees/presentation/widgets/service_category.dart';
// import 'package:hcs/gen/assets.gen.dart';
// import 'package:hcs/src/enums/request_state.dart';
// import 'package:hcs/src/manager/app_strings.dart';
// import 'package:hcs/src/routing/app_router.gr.dart';
// import 'package:hcs/src/shared_widgets/app_error_widget.dart';
// import 'package:hcs/src/shared_widgets/custom_appbar.dart';
// import 'package:hcs/src/shared_widgets/custom_button.dart';
// import 'package:hcs/src/shared_widgets/fade_circle_loading_indicator.dart';
// @RoutePage()
// class EmployeesScreen extends ConsumerStatefulWidget {
//   const EmployeesScreen({super.key});

//   @override
//   ConsumerState<EmployeesScreen> createState() => _EmployeesScreenState();
// }

// class _EmployeesScreenState extends ConsumerState<EmployeesScreen> {
//   late ScrollController _scrollController ;
//   final _formKey = GlobalKey<FormState>();
//   Timer? _loadMoreTimer;

//   /// local guard to avoid firing load-more repeatedly
//   bool _loadingMore = false;

//   @override
//   void initState() {
//     super.initState();

//     // 1) initial load
//     Future(() =>
//         ref.read(employeesControllerProvider.notifier).fetchEmployees());
//     _scrollController = ScrollController()..addListener(_onScroll);

//     // 2) pagination listener: fire when ~300px remain
//     //   _scrollController.addListener(() {
//     //   final max = _scrollController.position.maxScrollExtent;
//     //   final pos = _scrollController.position.pixels;
//     //   final nextPage = ref
//     //       .read(employeesControllerProvider)
//     //       .currentEmployeesPage;

//     //   if (pos == max && nextPage != null) {
//     //     ref.read(employeesControllerProvider.notifier).onLoadMoreEmployees();
//     //   }
//     // });
// //   _scrollController.addListener(() {
// //   final state = ref.read(employeesControllerProvider);
// //   final hasMore = state.currentEmployeesPage != null;
// //   if (!hasMore) return;

// //   if (_scrollController.position.extentAfter < 300) {
// //     ref.read(employeesControllerProvider.notifier).onLoadMoreEmployees();
// //   }
// // });

//   }

//   _onScroll() {
//     final customerState = ref.read(employeesControllerProvider);
//     final hasMore = customerState.currentEmployeesPage != null;

//     if (_scrollController.position.pixels >
//             _scrollController.position.maxScrollExtent - 100 ) {
//       _loadMoreTimer?.cancel();
//       _loadMoreTimer = Timer(const Duration(milliseconds: 500), () async{
//       await  ref
//             .read(employeesControllerProvider.notifier)
//             .onLoadMoreEmployees();
//       });
//     }
//   }
//   @override
//   void dispose() {
//     _loadMoreTimer?.cancel();
//     _scrollController.dispose();
//         super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final employeesState = ref.watch(employeesControllerProvider);

//     return Scaffold(
//       appBar: const CustomAppbar(hasBackArrow: true),
//       body: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 24.w),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // ------- Search / Filters & Header -------
//             Form(
//               key: _formKey,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   16.verticalSpace,
//                   SearchField(
//                     onFieldSubmitted: (value) {
//                       ref
//                           .read(employeesControllerProvider.notifier)
//                           .searchEmployee(value);
//                     },
//                   ),
//                   24.verticalSpace,
//                   Text(
//                     context.tr(AppStrings.serviceCategory),
//                     style: Theme.of(context).textTheme.displayMedium,
//                   ),
//                   16.verticalSpace,
//                   Consumer(builder: (context, ref, _) {
//                     final selected = ref.watch(
//                       availabilityControllerProvider
//                           .select((s) => s.selectedServiceType),
//                     );
//                     return ServiceCategoryChips(selectedChip: selected!);
//                   }),
//                   24.verticalSpace,
//                   Text(
//                     context.tr(AppStrings.employees),
//                     style: Theme.of(context).textTheme.displayMedium,
//                   ),
//                   12.verticalSpace,
//                 ],
//               ),
//             ),

//             // ------- List (owns the scroll) -------
//             Expanded(
//               child: Builder(builder: (_) {
//                 if (employeesState.employeesStates == RequestStates.loading) {
//                   return const Center(child: FadeCircleLoadingIndicator());
//                 }
//                 if (employeesState.employeesStates == RequestStates.error) {
//                   return AppErrorWidget(
//                     onTap: () => ref
//                         .read(employeesControllerProvider.notifier)
//                         .fetchEmployees(),
//                   );
//                 }
//                 if (employeesState.employees.isEmpty) {
//                   return Center(child: Assets.images.noDataMin.image());
//                 }

//                 // footer: show 1 extra item slot only if there is a next page
//                 final hasMore = employeesState.currentEmployeesPage != null;
//                 final itemCount =
//                     employeesState.employees.length + (hasMore ? 1 : 0);

//                 return ListView.separated(
//                   controller: _scrollController,
//                   physics: const BouncingScrollPhysics(),
//                   itemCount: itemCount,
//                   separatorBuilder: (_, __) => 16.verticalSpace,
//                   itemBuilder: (context, index) {
//                     final isFooter = index >= employeesState.employees.length;
//                     if (isFooter) {
//                       // load-more spinner row
//                       return const Padding(
//                         padding: EdgeInsets.symmetric(vertical: 16),
//                         child: Center(child: FadeCircleLoadingIndicator()),
//                       );
//                     }

//                     final emp = employeesState.employees[index];
//                     final enabled =
//                         employeesState.selectedEmployees.contains(emp);

//                     return EmployeeBarChip(employee: emp, enabled: enabled);
//                   },
//                 );
//               }),
//             ),
//           ],
//         ),
//       ),

//       // ------- Persistent bottom button -------
    //   bottomNavigationBar: Padding(
    //     padding: EdgeInsets.fromLTRB(24.w, 8, 24.w, 16.h),
    //     child: Consumer(builder: (context, ref, _) {
    //       final selected = ref.watch(
    //         employeesControllerProvider.select((s) => s.selectedEmployees),
    //       );
    //       return CustomButton(
    //         title: tr(context: context, AppStrings.next),
    //         onPressed:
    //             selected.isEmpty ? null : () => context.pushRoute(DriverPaymentRoute()),
    //       );
    //     }),
    //   ),
    // );
//   }
// }
