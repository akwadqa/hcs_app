import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hcs/features/Auth/presentation/controller/auth_controller.dart';
import 'package:hcs/features/Home/Customer/presentation/controllers/home_controller.dart';
import 'package:hcs/features/Home/Customer/presentation/widgets/date_selection_widget.dart';
import 'package:hcs/features/Home/Customer/presentation/widgets/service_type_widget.dart';
import 'package:hcs/features/Home/Customer/presentation/widgets/shift_type_chips.dart';
import 'package:hcs/src/manager/app_strings.dart';
import 'package:hcs/src/routing/app_router.gr.dart';
import 'package:hcs/src/shared_widgets/custom_appbar.dart';
import 'package:hcs/src/shared_widgets/custom_button.dart';

@RoutePage()
class ServiceConfigurationScreen extends ConsumerStatefulWidget {
  const ServiceConfigurationScreen({super.key});

  @override
  ConsumerState<ServiceConfigurationScreen> createState() =>
      _ServiceConfigurationScreenState();
}

class _ServiceConfigurationScreenState
    extends ConsumerState<ServiceConfigurationScreen> {
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
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: 32.h),
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        ServiceTypeMenu(),
                        24.verticalSpace,
                        ShiftTypeChips(),
                        24.verticalSpace,
                        DateFormField(
                          // labelText: 'Date',
                          initialDate: DateTime.now(),
                          onDateSelected: (dt) {
                            // do something with the chosen date
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 25.h, horizontal: 22.w),
            child: Consumer(
              builder: (context, ref, child) {
                final asyncLogin = ref.watch(authControllerProvider);

                return CustomButton(
                  title: tr(context: context, AppStrings.checkAvailability),
                  onPressed: asyncLogin is AsyncLoading
                      ? null
                      : () {
                          context.pushRoute(EmployeesRoute());
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
    );
  }
}
