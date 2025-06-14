import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hcs/features/Home/Employees/presentation/controllers/employees_controller.dart';
import 'package:hcs/features/Home/Employees/presentation/widgets/employee_bar_chips.dart';
import 'package:hcs/features/Home/Employees/presentation/widgets/search_field.dart';
import 'package:hcs/features/Home/Employees/presentation/widgets/service_category.dart';
import 'package:hcs/gen/assets.gen.dart';
import 'package:hcs/src/enums/request_state.dart';
import 'package:hcs/src/enums/service_type.dart';
import 'package:hcs/src/manager/app_strings.dart';
import 'package:hcs/src/routing/app_router.gr.dart';
import 'package:hcs/src/shared_widgets/custom_appbar.dart';
import 'package:hcs/src/shared_widgets/custom_button.dart';

@RoutePage()
class EmployeesScreen extends ConsumerStatefulWidget {
  final ServiceType serviceType;

  const EmployeesScreen({super.key, required this.serviceType});

  @override
  ConsumerState<EmployeesScreen> createState() => _EmployeesScreenState();
}

class _EmployeesScreenState extends ConsumerState<EmployeesScreen> {
  final ScrollController _scrollController = ScrollController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    // تحميل البيانات عند أول فتح للشاشة
    // Future.microtask(() {
    // ref.read(employeesControllerProvider.notifier).selectServiceCategory(serv);
    // ref.read(employeesControllerProvider.notifier).fetchEmployees();
    // });

    // pagination listener only once:
    _scrollController.addListener(() {
      final max = _scrollController.position.maxScrollExtent;
      final pos = _scrollController.position.pixels;
      final nextPage = ref
          .read(employeesControllerProvider)
          .currentEmployeesPage;

      if (pos == max && nextPage != null) {
        ref.read(employeesControllerProvider.notifier).onLoadMoreEmployees();
      }
    });
  }

  // void _onScroll() {
  //   final state = ref.read(employeesControllerProvider);
  //   final controller = ref.read(employeesControllerProvider.notifier);

  //   // تحميل المزيد إذا لم نصل للنهاية وإذا لم يكن يحمل حاليًا
  //   if (_scrollController.position.pixels >=
  //           _scrollController.position.maxScrollExtent - 100 &&
  //       state.currentEmployeesPage != null &&
  //       state.employeesStates != RequestStates.loading) {
  //     controller.onLoadMoreEmployees();
  //   }
  // }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildContent(),
      appBar: CustomAppbar(
        hasBackArrow: true,
        serviceTypeTitle: widget.serviceType,
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
                        SearchField(),
                        24.verticalSpace,
                        Text(
                          context.tr(AppStrings.serviceCategory),
                          style: Theme.of(context).textTheme.displayMedium!,
                        ),
                        16.verticalSpace,
                        ServiceCategoryChips(
                          selectedChip: serviceTypeToString(widget.serviceType),
                        ),
                        44.verticalSpace,
                        Text(
                          context.tr(AppStrings.employees),
                          style: Theme.of(context).textTheme.displayMedium!,
                        ),
                        16.verticalSpace,
                        SizedBox(
                          height: 304.h,
                          child: Consumer(
                            builder: (context, ref, child) {
                              final employeesState = ref.watch(
                                employeesControllerProvider,
                              );
                              if (employeesState.employeesStates ==
                                  RequestStates.loaded) {
                                if (employeesState.employees.isEmpty) {
                                  return Assets.images.noData.image();
                                }
                                return ListView.separated(
                                  controller: _scrollController,
                                  itemCount:
                                      employeesState.employees.length + 1,
                                  shrinkWrap: true,
                                  physics: BouncingScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    if (index ==
                                        employeesState.employees.length) {
                                      // عرض مؤشر تحميل أو لا شيء
                                      return Center(
                                        child:
                                            employeesState
                                                    .currentEmployeesPage ==
                                                null
                                            ? Text('No More Employees')
                                            : CircularProgressIndicator(),
                                      );
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
                                );
                              } else if (employeesState.employeesStates ==
                                  RequestStates.error) {
                                Text("Error Accoure");
                              }
                              return Center(child: CircularProgressIndicator());
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 25.h,
                      horizontal: 22.w,
                    ),
                    child: Consumer(
                      builder: (context, ref, child) {
                        final asyncEmployees = ref.watch(
                          employeesControllerProvider,
                        );

                        return CustomButton(
                          title: tr(context: context, AppStrings.next),
                          onPressed:
                              asyncEmployees.employeesStates ==
                                  RequestStates.loading
                              ? null
                              : () {
                                  context.pushRoute(
                                    DriverPaymentRoute(
                                      serviceType: widget.serviceType,
                                    ),
                                  );
                                  if (_formKey.currentState!.validate()) {}
                                },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
