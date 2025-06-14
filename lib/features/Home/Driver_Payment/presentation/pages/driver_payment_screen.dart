import 'package:auto_route/annotations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hcs/features/Home/Driver_Payment/data/models/drivers_model.dart';
import 'package:hcs/features/Home/Driver_Payment/presentation/controllers/drivers_payment_controllers.dart';
import 'package:hcs/features/Home/Driver_Payment/presentation/widgets/discount_dropdown.dart';
import 'package:hcs/features/Home/Driver_Payment/presentation/widgets/paginated_dropdown_drivers.dart';
import 'package:hcs/features/Home/Driver_Payment/presentation/widgets/payment_method_chips.dart';
import 'package:hcs/features/Home/Driver_Payment/presentation/widgets/yes_no_answer.dart';
import 'package:hcs/features/Home/Submit_Service/presentation/submit_service_controller.dart';
import 'package:hcs/src/enums/request_state.dart';
import 'package:hcs/src/enums/service_type.dart';
import 'package:hcs/src/manager/app_strings.dart';
import 'package:hcs/src/shared_widgets/app_error_widget.dart';
import 'package:hcs/src/shared_widgets/custom_appbar.dart';
import 'package:hcs/src/shared_widgets/custom_button.dart';
import 'package:hcs/src/theme/app_colors.dart';

@RoutePage()
class DriverPaymentScreen extends ConsumerStatefulWidget {
  final ServiceType serviceType;
  const DriverPaymentScreen({super.key, required this.serviceType});

  @override
  ConsumerState<DriverPaymentScreen> createState() =>
      _DriverPaymentScreenState();
}

class _DriverPaymentScreenState extends ConsumerState<DriverPaymentScreen> {
  Driver? _chosenDriver;
  final TextEditingController _discountPercentageController =
      TextEditingController(text: '10%');

  @override
  void initState() {
    super.initState();
    Future(
      () => ref.read(driversPaymentControllerProvider.notifier).fetchDrivers(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final driversPaymentState = ref.watch(driversPaymentControllerProvider);

    return Scaffold(
      appBar: CustomAppbar(
        hasBackArrow: true,
        serviceTypeTitle: widget.serviceType,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              24.verticalSpace,
              Text(
                context.tr(AppStrings.driverName),
                style: Theme.of(context).textTheme.displayMedium!,
              ),
              8.verticalSpace,
              Consumer(
                builder: (context, ref, child) {
                  if (driversPaymentState.driversStates ==
                      RequestStates.loaded) {
                    return PaginatedDriverDropdown(
                      // labelGetter: (c) => c.fullName,
                      drivers: driversPaymentState.drivers,
                      hasMore: driversPaymentState.currentDriversPage != null,
                      isLoading:
                          driversPaymentState.driversStates ==
                          RequestStates.loading,
                      onLoadMore: () => ref
                          .read(driversPaymentControllerProvider.notifier)
                          .onLoadMoreDrivers(),
                      initialValue: ref
                          .read(driversPaymentControllerProvider)
                          .selectedDriver,
                      onChanged: (cust) {
                        setState(() => _chosenDriver = cust);
                        ref
                            .read(driversPaymentControllerProvider.notifier)
                            .selectDriver(cust);
                        debugPrint('$_chosenDriver koko _chosenDriver');
                        debugPrint('$cust koko cust ');
                      },
                    );
                  } else if (driversPaymentState.driversStates ==
                      RequestStates.loading) {
                    return const CircularProgressIndicator();
                  } else if (driversPaymentState.driversStates ==
                      RequestStates.error) {
                    return AppErrorWidget(
                      onTap: () => ref
                          .read(driversPaymentControllerProvider.notifier)
                          .fetchDrivers(),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),

              32.verticalSpace,
              Divider(height: 0.1, color: AppColors.dividerGrey),
              32.verticalSpace,

              DiscountDropdown(
                items: ['1', 'MAZAYA Card'],
                selectedItem: 'MAZAYA Card',
                onSelected: (p0) {},
              ),
              16.verticalSpace,
              Text(
                context.tr(AppStrings.discountPercentage),
                style: Theme.of(context).textTheme.displayMedium!,
              ),
              8.verticalSpace,
              TextFormField(
                controller: _discountPercentageController,
                decoration: InputDecoration(
                  hintStyle: Theme.of(context).inputDecorationTheme.hintStyle,
                ),
              ),
              24.verticalSpace,

              PaymentMethodChips(),
              32.verticalSpace,
              Divider(height: 0.1, color: AppColors.dividerGrey),
              32.verticalSpace,
              YesNoAnswes(),
              50.verticalSpace,

              Padding(
                padding: EdgeInsets.only(bottom: 25.h, left: 47.w, right: 47.w),
                child: Consumer(
                  builder: (context, ref, child) {
                    final submitServiceState = ref.watch(
                      submitServiceControllerProvider,
                    );

                    return CustomButton(
                      title: tr(context: context, AppStrings.submit),
                      onPressed:
                          submitServiceState.submitServiceStates ==
                              RequestStates.loading
                          ? null
                          : () {
                              ref
                                  .watch(
                                    submitServiceControllerProvider.notifier,
                                  )
                                  .submitService();
                              // Validate the form before navigating
                              // if (_formKey.currentState!.validate()) {
                              //   context.pushRoute(
                              //     ServiceConfigurationRoute(
                              //       serviceType: widget.serviceType,
                              //     ),
                              //   );
                              // }
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
