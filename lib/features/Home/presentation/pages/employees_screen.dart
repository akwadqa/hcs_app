import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hcs/features/Auth/presentation/controller/auth_controller.dart';
import 'package:hcs/features/Home/presentation/controllers/home_controller.dart';
import 'package:hcs/features/Home/presentation/widgets/employee_bar_chips.dart';
import 'package:hcs/features/Home/presentation/widgets/search_field.dart';
import 'package:hcs/features/Home/presentation/widgets/service_category.dart';
import 'package:hcs/src/manager/app_strings.dart';
import 'package:hcs/src/shared_widgets/custom_appbar.dart';
import 'package:hcs/src/shared_widgets/custom_button.dart';

@RoutePage()
class EmployeesScreen extends ConsumerStatefulWidget {
  const EmployeesScreen({super.key});

  @override
  ConsumerState<EmployeesScreen> createState() => _EmployeesScreenState();
}

class _EmployeesScreenState extends ConsumerState<EmployeesScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // Future(() => ref.read(homeControllerProvider.notifier).fetchHomeBlocks());
  }

  @override
  Widget build(BuildContext context) {
    final homeState = ref.watch(homeControllerProvider);

    return Scaffold(
      // body: homeState.homeStates == RequestStates.loaded
      //     ? _buildContent(homeState.homeBlock!)
      //     : homeState.homeStates == RequestStates.loading
      //     ? const Center(child: CircularProgressIndicator())
      //     : homeState.homeStates == RequestStates.error
      //     ? AppErrorWidget(
      //         onTap: () => Future(
      //           () =>
      //               ref.read(homeControllerProvider.notifier).fetchHomeBlocks(),
      //         ),
      //       )
      //     : SizedBox.shrink(),
      body: _buildContent(),
      appBar: CustomAppbar(hasBackArrow: true, title: 'On Call Service'),
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
                          child: ListView.separated(
                            itemCount: 5,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              return EmployeeBarChip(name: '$index');
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                                  return 16.verticalSpace;
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
                        final asyncLogin = ref.watch(authControllerProvider);

                        return CustomButton(
                          title: tr(context: context, AppStrings.next),
                          onPressed: asyncLogin is AsyncLoading
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
