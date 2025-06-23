import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
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
import 'package:hcs/features/Home/Submit_Service/presentation/submit_service_state.dart';
import 'package:hcs/gen/assets.gen.dart';
import 'package:hcs/src/enums/request_state.dart';
import 'package:hcs/src/manager/app_strings.dart';
import 'package:hcs/src/routing/app_router.gr.dart';
import 'package:hcs/src/shared_widgets/app_error_widget.dart';
import 'package:hcs/src/shared_widgets/custom_appbar.dart';
import 'package:hcs/src/shared_widgets/custom_button.dart';
import 'package:hcs/src/theme/app_colors.dart';

@RoutePage()
class DriverPaymentScreen extends ConsumerStatefulWidget {
  const DriverPaymentScreen({super.key});

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
    Future.microtask(() {
      ref.read(driversPaymentControllerProvider.notifier).fetchDrivers();
      ref.read(driversPaymentControllerProvider.notifier).getDiscountType();
    });
  }

  @override
  Widget build(BuildContext context) {
    final driversPaymentState = ref.watch(driversPaymentControllerProvider);

    return Scaffold(
      appBar: CustomAppbar(hasBackArrow: true),
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
                      // onChanged: (cust) {
                      //   setState(() => _chosenDriver = cust);
                      //   ref
                      //       .read(driversPaymentControllerProvider.notifier)
                      //       .selectDriver(cust);
                      //   debugPrint('$_chosenDriver koko _chosenDriver');
                      //   debugPrint('$cust koko cust ');
                      // },
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

              Consumer(
                builder: (context, ref, child) {
                  if (driversPaymentState.discountStates ==
                      RequestStates.loaded) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        DiscountDropdown(
                          items: driversPaymentState.discountType,
                          selectedItem: driversPaymentState.selectedDiscount,
                          onSelected: (p0) {
                            Future(
                              () => ref
                                  .read(
                                    driversPaymentControllerProvider.notifier,
                                  )
                                  .selectDiscount(p0),
                            );
                          },
                        ),
                        16.verticalSpace,
                        Text(
                          context.tr(AppStrings.discountPercentage),
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                        8.verticalSpace,
                        TextFormField(
                          controller: TextEditingController(
                            text: driversPaymentState.discountPercentage
                                .toString(),
                          ),
                          onFieldSubmitted: (value) {
                            double? doubleDiscount = double.tryParse(value);
                            ref
                                .read(driversPaymentControllerProvider.notifier)
                                .calculateTotalCost(doubleDiscount);
                          },
                          decoration: InputDecoration(
                            hintStyle: Theme.of(
                              context,
                            ).inputDecorationTheme.hintStyle,
                          ),
                        ),
                        10.verticalSpace,
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'Total Cost: ',
                                style: Theme.of(
                                  context,
                                ).textTheme.displayMedium,
                              ),
                              TextSpan(
                                text: '${driversPaymentState.discountedCost} ',
                                style: Theme.of(context).textTheme.displaySmall,
                              ),

                              TextSpan(
                                text: driversPaymentState.originalCost
                                    .toString(),
                                style: Theme.of(context).textTheme.bodyMedium!
                                    .copyWith(
                                      decoration: TextDecoration.lineThrough,
                                      fontSize: 13.sp,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        32.verticalSpace,
                      ],
                    );
                  } else if (driversPaymentState.discountStates ==
                      RequestStates.loading) {
                    return const CircularProgressIndicator();
                  } else if (driversPaymentState.discountStates ==
                      RequestStates.error) {
                    return AppErrorWidget(
                      onTap: () => ref
                          .read(driversPaymentControllerProvider.notifier)
                          .getDiscountType(),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),

              PaymentMethodChips(),
              32.verticalSpace,
              Divider(height: 0.1, color: AppColors.dividerGrey),
              32.verticalSpace,
              AreCleaningSuppliesAvailable(),
              50.verticalSpace,

              Center(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 25.h),
                  child: Consumer(
                    builder: (context, ref, child) {
                      final drvierDiscontState = ref.watch(
                        driversPaymentControllerProvider,
                      );

                      ref.listen<SubmitServiceState>(
                        submitServiceControllerProvider,
                        (previous, next) {
                          if (next.submitServiceStates ==
                              RequestStates.loaded) {
                            context.router.replaceAll([
                              MainRoute(
                                children: [
                                  HomeRoute(children: [HomeContentRoute()]),
                                ],
                              ),
                            ]);

                            showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                title: Assets.images.successful.svg(),
                                content: Text(
                                  'Service has been\n requested successfully.',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayMedium!
                                      .copyWith(fontSize: 20.sp),
                                ),
                              ),
                            );
                          }

                          if (next.submitServiceStates == RequestStates.error) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  next.submitServiceMessage ?? 'Error',
                                ),
                              ),
                            );
                          }
                        },
                      );
                      return CustomButton(
                        title: tr(context: context, AppStrings.submit),
                        onPressed:
                            drvierDiscontState.selectedDiscount == null ||
                                drvierDiscontState.selectedDriver == null
                            ? null
                            : () {
                                ref
                                    .watch(
                                      submitServiceControllerProvider.notifier,
                                    )
                                    .submitService();
                              },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
