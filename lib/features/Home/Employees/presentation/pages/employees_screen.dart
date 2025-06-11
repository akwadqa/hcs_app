import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hcs/features/Auth/presentation/controller/auth_controller.dart';
import 'package:hcs/features/Home/Employees/presentation/controllers/employees_controller.dart';
import 'package:hcs/features/Home/Employees/presentation/widgets/employee_bar_chips.dart';
import 'package:hcs/features/Home/Employees/presentation/widgets/search_field.dart';
import 'package:hcs/features/Home/Employees/presentation/widgets/service_category.dart';
import 'package:hcs/src/enums/request_state.dart';
import 'package:hcs/src/enums/service_type.dart';
import 'package:hcs/src/manager/app_strings.dart';
import 'package:hcs/src/shared_widgets/custom_appbar.dart';
import 'package:hcs/src/shared_widgets/custom_button.dart';

@RoutePage()
class EmployeesScreen extends StatefulWidget {
  final ServiceType serviceType;

  const EmployeesScreen({super.key, required this.serviceType});

  @override
  State<EmployeesScreen> createState() => _EmployeesScreenState();
}

class _EmployeesScreenState extends State<EmployeesScreen> {
  late ScrollController _scrollController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    // Future(
    //   () => ref.read(employeesControllerProvider.notifier).fetchEmployees(),
    // );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: employeesState.homeStates == RequestStates.loaded
      //     ? _buildContent(homeState.homeBlock!)
      //     : employeesState.homeStates == RequestStates.loading
      //     ? const Center(child: CircularProgressIndicator())
      //     : employeesState.homeStates == RequestStates.error
      //     ? AppErrorWidget(
      //         onTap: () => Future(
      //           () =>
      //               ref.read(employeesControllerProvider.notifier).fetchEmployees(),
      //         ),
      //       )
      //     : SizedBox.shrink(),
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
                        ServiceCategoryChips(),
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
                              Future(
                                () => ref
                                    .read(employeesControllerProvider.notifier)
                                    .fetchEmployees(),
                              );
                              _scrollController = ScrollController()
                                ..addListener(() {
                                  if (_scrollController.position.pixels >=
                                      _scrollController
                                              .position
                                              .maxScrollExtent -
                                          100) {
                                    ref
                                        .read(
                                          employeesControllerProvider.notifier,
                                        )
                                        .onLoadMoreEmployees();
                                  }
                                });
                              return ListView.separated(
                                itemCount: employeesState.employees.length + 1,
                                controller: _scrollController,

                                shrinkWrap: true,
                                physics: BouncingScrollPhysics(),
                                itemBuilder: (BuildContext context, int index) {
                                  return EmployeeBarChip(
                                    name: employeesState
                                        .employees[index]
                                        .employeeName,
                                  );
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                      return 16.verticalSpace;
                                    },
                              );
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
                                  if (_formKey.currentState!.validate()) {
                                    // ref
                                    //     .read(authControllerProvider.notifier)
                                    //     .login(
                                    //       LoginParams(
                                    //         email: _emailController.text,
                                    //         pass: _passwordController.text,
                                    //       ),
                                    //     );
                                  }
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
