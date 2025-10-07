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
import 'package:hcs/features/Home/Employees/presentation/widgets/service_category.dart';
import 'package:hcs/gen/assets.gen.dart';
import 'package:hcs/src/enums/request_state.dart';
import 'package:hcs/src/manager/app_strings.dart';
import 'package:hcs/src/routing/app_router.gr.dart';
import 'package:hcs/src/shared_widgets/app_error_widget.dart';
import 'package:hcs/src/shared_widgets/custom_appbar.dart';
import 'package:hcs/src/shared_widgets/custom_button.dart';
import 'package:hcs/src/shared_widgets/fade_circle_loading_indicator.dart';
import 'package:hcs/src/theme/app_colors.dart';

@RoutePage()
class EmployeesScreen extends ConsumerStatefulWidget {
  const EmployeesScreen({super.key});

  @override
  ConsumerState<EmployeesScreen> createState() => _EmployeesScreenState();
}

class _EmployeesScreenState extends ConsumerState<EmployeesScreen> {
  ScrollController _scrollController = ScrollController();
    Timer? _loadMoreTimer;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    // pagination listener only once:
    _scrollController.addListener(() {
       final appointmentsStates = ref.read(employeesControllerProvider);
    final hasMore = appointmentsStates.currentEmployeesPage != null;
  
    if (_scrollController.position.pixels >
            _scrollController.position.maxScrollExtent - 100 &&
        hasMore) {
      _loadMoreTimer?.cancel();
      _loadMoreTimer = Timer(const Duration(milliseconds: 500), () {
        ref
            .read(employeesControllerProvider.notifier)
            .onLoadMoreEmployees();
      });
    }
      // final max = _scrollController.position.maxScrollExtent;
      // final pos = _scrollController.position.pixels;
      // final nextPage = ref
      //     .read(employeesControllerProvider)
      //     .currentEmployeesPage;

      // if (pos == max && nextPage != null) {
      //   ref.read(employeesControllerProvider.notifier).onLoadMoreEmployees();
      // }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildContent(),
      appBar: CustomAppbar(hasBackArrow: true),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.fromLTRB(24.w, 8, 24.w, 16.h),
        child: Consumer(
          builder: (context, ref, _) {
            final selected = ref.watch(
              employeesControllerProvider.select((s) => s.selectedEmployees),
            );
            return CustomButton(
              title: tr(context: context, AppStrings.next),
              onPressed: selected.isEmpty
                  ? null
                  : () => context.pushRoute(DriverPaymentRoute()),
            );
          },
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: 16.h),
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Form(
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
                            final employeesState = ref.watch(
                              employeesControllerProvider,
                            );

                            return Align(
                              alignment: Alignment.centerLeft,
                              child: Wrap(
                                alignment: WrapAlignment.start,
                                spacing: 8.w,
                                runSpacing: 4.h,
                                children: employeesState.selectedEmployees
                                    .map(
                                      (e) => SelectedEmployeeCard(
                                        name: e.employeeName,
                                        onTap: () {
                                          ref
                                              .read(
                                                employeesControllerProvider
                                                    .notifier,
                                              )
                                              .unSelectEmployee(e);
                                        },
                                      ),
                                    )
                                    .toList(),
                              ),
                            );
                          },
                        ),
                        24.verticalSpace,
                        Text(
                          context.tr(AppStrings.serviceCategory),
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                        16.verticalSpace,
                        Consumer(
                          builder: (context, ref, child) {
                            var selectedServiceType = ref.watch(
                              availabilityControllerProvider.select(
                                (value) => value.selectedServiceType,
                              ),
                            );
                            return ServiceCategoryChips(
                              selectedChip: selectedServiceType!,
                            );
                          },
                        ),
                        44.verticalSpace,
                        Text(
                          context.tr(AppStrings.employees),
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                        16.verticalSpace,
                        Consumer(
                          builder: (context, ref, child) {
                            final employeesState = ref.watch(
                              employeesControllerProvider,
                            );

                            if (employeesState.employeesStates ==
                                RequestStates.loaded) {
                              if (employeesState.employees.isEmpty) {
                                return Assets.images.noDataMin.image();
                              }
                              return SizedBox(
                                height: 304.h,
                                child: ListView.separated(
                                  controller: _scrollController,
                                  itemCount:
                                      employeesState.employees.length + 1,
                                  shrinkWrap: true,
                                  physics: BouncingScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    if (index ==
                                        employeesState.employees.length) {
                                      // Check if currentEmployeesPage is null and state is loaded
                                      if (employeesState.currentEmployeesPage ==
                                          null) {
                                        return Center(
                                          child: Text(
                                            'No More Employees',
                                            style: Theme.of(
                                              context,
                                            ).textTheme.bodyMedium,
                                          ),
                                        );
                                      } else {
                                        return Center(
                                          child: FadeCircleLoadingIndicator(),
                                        );
                                      }
                                    } else {
                                      return EmployeeBarChip(
                                        employee:
                                            employeesState.employees[index],
                                        enabled: employeesState
                                            .selectedEmployees
                                            .contains(
                                              employeesState.employees[index],
                                            ),
                                      );
                                    }
                                  },
                                  separatorBuilder: (_, __) => 16.verticalSpace,
                                ),
                              );
                            } else if (employeesState.employeesStates ==
                                RequestStates.error) {
                              return AppErrorWidget(
                                onTap: () => ref
                                    .read(employeesControllerProvider.notifier)
                                    .fetchEmployees(),
                              );
                            } else if (employeesState.employeesStates ==
                                RequestStates.loading) {
                              return Center(
                                child: FadeCircleLoadingIndicator(),
                              );
                            }

                            return SizedBox.shrink();
                          },
                        ),
                      ],
                    ),
                  ),

                  // Padding(
                  //   padding: EdgeInsets.symmetric(
                  //     vertical: 25.h,
                  //     horizontal: 22.w,
                  //   ),
                  //   child: Consumer(
                  //     builder: (context, ref, child) {
                  //       final selectedEmployees = ref.watch(
                  //         employeesControllerProvider.select(
                  //           (value) => value.selectedEmployees,
                  //         ),
                  //       );

                  //       return CustomButton(
                  //         title: tr(context: context, AppStrings.next),
                  //         onPressed: selectedEmployees.isEmpty
                  //             ? null
                  //             : () {
                  //                 context.pushRoute(DriverPaymentRoute());
                  //                 // if (_formKey.currentState!.validate()) {}
                  //               },
                  //       );
                  //     },
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ],
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
