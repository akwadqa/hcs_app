import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hcs/features/Home/Availability/presentation/controllers/availability_controller.dart';
import 'package:hcs/features/Home/Availability/presentation/controllers/service_config_state.dart';
import 'package:hcs/features/Home/Availability/presentation/widgets/date_selection_widget.dart';
import 'package:hcs/features/Home/Availability/presentation/widgets/packages_dropdown.dart';
import 'package:hcs/features/Home/Availability/presentation/widgets/service_type_widget.dart';
import 'package:hcs/features/Home/Availability/presentation/widgets/shift_type_chips.dart';
import 'package:hcs/src/enums/request_state.dart';
import 'package:hcs/src/enums/service_type.dart';
import 'package:hcs/src/manager/app_strings.dart';
import 'package:hcs/src/routing/app_router.gr.dart';
import 'package:hcs/src/shared_widgets/custom_appbar.dart';
import 'package:hcs/src/shared_widgets/custom_button.dart';

@RoutePage()
class ServiceConfigurationScreen extends ConsumerStatefulWidget {
  final ServiceType serviceType;
  const ServiceConfigurationScreen({super.key, required this.serviceType});

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
    Future(
      () => ref.read(availabilityControllerProvider.notifier).fetchPackages(),
    );

    Future(
      () => ref
          .read(availabilityControllerProvider.notifier)
          .resetController(
            serviceTypeToString(widget.serviceType),
            DateFormat.yMd().format(DateTime.now()),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final availabilityState = ref.watch(availabilityControllerProvider);

    return Scaffold(
      // body: availabilityState.packagesStates == RequestStates.loaded
      //     ? _buildContent(homeState.homeBlock!)
      //     : availabilityState.packagesStates == RequestStates.loading
      //     ? const Center(child: CircularProgressIndicator())
      //     : availabilityState.packagesStates == RequestStates.error
      //     ? AppErrorWidget(
      //         onTap: () => Future(
      //           () =>
      //               ref.read(availabilityControllerProvider.notifier).fetchPackages(),
      //         ),
      //       )
      //     : SizedBox.shrink(),
      body: _buildContent(availabilityState),
      appBar: CustomAppbar(
        hasBackArrow: true,
        serviceTypeTitle: widget.serviceType,
      ),
    );
  }

  Widget _buildContent(ServiceConfigState availabilityState) {
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
                        ServiceTypeMenu(serviceType: widget.serviceType),
                        24.verticalSpace,

                        widget.serviceType == ServiceType.packages
                            ? Consumer(
                                builder: (context, ref, child) {
                                  var state = ref.watch(
                                    availabilityControllerProvider,
                                  );
                                  return Column(
                                    children: [
                                      PackagesDropdown(
                                        items: availabilityState.packages,
                                        selectedPackage: state.selectedPackage,
                                        onSelected: (p0) {
                                          Future(
                                            () => ref
                                                .read(
                                                  availabilityControllerProvider
                                                      .notifier,
                                                )
                                                .selecPackage(p0),
                                          );
                                        },
                                      ),
                                      24.verticalSpace,
                                    ],
                                  );
                                },
                              )
                            : SizedBox.shrink(),

                        ShiftTypeChips(),
                        24.verticalSpace,

                        Consumer(
                          builder: (context, ref, child) {
                            return DateFormField(
                              // labelText: 'Date',
                              initialDate: DateTime.now(),
                              onDateSelected: (dt) {
                                // do something with the chosen date
                                ref
                                    .read(
                                      availabilityControllerProvider.notifier,
                                    )
                                    .selectDate(DateFormat.yMd().format(dt));
                              },
                            );
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
            child: CustomButton(
              title: widget.serviceType == ServiceType.packages
                  ? tr(context: context, AppStrings.next)
                  : tr(context: context, AppStrings.checkAvailability),
              onPressed:
                  availabilityState.packagesStates == RequestStates.loading
                  ? null
                  : () {
                      context.pushRoute(
                        EmployeesRoute(serviceType: widget.serviceType),
                      );
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
            ),
          ),
        ],
      ),
    );
  }
}
