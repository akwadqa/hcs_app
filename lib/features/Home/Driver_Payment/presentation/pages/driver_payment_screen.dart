import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart' as tr;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hcs/features/Home/Availability/presentation/controllers/availability_controller.dart';
import 'package:hcs/features/Home/Driver_Payment/data/models/discount_type.dart';
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
import 'package:hcs/src/shared_widgets/custom_appbar.dart';
import 'package:hcs/src/shared_widgets/custom_button.dart';
import 'package:hcs/src/shared_widgets/row_error_widget.dart';
import 'package:hcs/src/theme/app_colors.dart';
import 'package:hcs/src/shared_widgets/fade_circle_loading_indicator.dart';

@RoutePage()
class DriverPaymentScreen extends ConsumerStatefulWidget {
  const DriverPaymentScreen({super.key});

  @override
  ConsumerState<DriverPaymentScreen> createState() =>
      _DriverPaymentScreenState();
}

class _DriverPaymentScreenState extends ConsumerState<DriverPaymentScreen> {
  final _dropdownKey = GlobalKey<PaginatedDriverDropdownState>();
  late TextEditingController noteController;
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(driversPaymentControllerProvider.notifier).fetchDrivers();
      ref.read(driversPaymentControllerProvider.notifier).getDiscountType();
      ref.read(driversPaymentControllerProvider.notifier).getCustomerBalance();
    });
    noteController = TextEditingController(
      text: ref.read(driversPaymentControllerProvider).note,
    );
  }

  @override
  Widget build(BuildContext context) {
    final driversPaymentNotifier = ref.read(
      driversPaymentControllerProvider.notifier,
    );

    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        _dropdownKey.currentState?.closeOverlay();
      },
      child: Scaffold(
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
                    final driversPaymentState = ref.watch(
                      driversPaymentControllerProvider,
                    );

                    if (driversPaymentState.driversStates ==
                        RequestStates.loaded) {
                      return PaginatedDriverDropdown(
                        key: _dropdownKey,
                        // onChanged: (cust) {
                        //   setState(() => _chosenDriver = cust);
                        //   ref
                        //       .read(driversPaymentControllerProvider.notifier)
                        //       .selectDriver(cust);

                        // },
                      );
                    } else if (driversPaymentState.driversStates ==
                        RequestStates.loading) {
                      return const FadeCircleLoadingIndicator();
                    } else if (driversPaymentState.driversStates ==
                        RequestStates.error) {
                      return SimpleErrorWidget(
                        onTap: () {
                          ref
                              .read(driversPaymentControllerProvider.notifier)
                              .fetchDrivers();
                          ref
                              .read(driversPaymentControllerProvider.notifier)
                              .getCustomerBalance();
                        },
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
                    final driversPaymentState = ref.watch(
                      driversPaymentControllerProvider,
                    );

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
                          driversPaymentState.selectedDiscount != null
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    16.verticalSpace,
                                    Text(
                                      context.tr(AppStrings.discountPercentage),
                                      style: Theme.of(
                                        context,
                                      ).textTheme.displayMedium,
                                    ),
                                    8.verticalSpace,
                                    TextFormField(
                                      controller: TextEditingController(
                                        text: driversPaymentState
                                            .discountPercentage
                                            .toString(),
                                      ),
                                      enabled:
                                          driversPaymentState
                                              .selectedDiscount
                                              ?.discountPercentage !=
                                          0,
                                      keyboardType:
                                          TextInputType.numberWithOptions(
                                            signed: true,
                                            decimal: true,
                                          ),
                                      textInputAction: TextInputAction.done,
                                      onFieldSubmitted: (value) {
                                        double? doubleDiscount =
                                            double.tryParse(value);
                                        ref
                                            .read(
                                              driversPaymentControllerProvider
                                                  .notifier,
                                            )
                                            .calculateTotalCost(
                                              doubleDiscount ?? 0,
                                            );
                                      },
                                      decoration: InputDecoration(
                                        hintStyle: Theme.of(
                                          context,
                                        ).inputDecorationTheme.hintStyle,
                                      ),
                                    ),
                                  ],
                                )
                              : SizedBox.shrink(),

                          16.verticalSpace,
                          Text(
                            context.tr("total_cost"),
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                          8.verticalSpace,

                          TextFormField(
                            controller: TextEditingController(
                              text:
                                  driversPaymentState.discountedCost == null ||
                                      driversPaymentState.discountedCost! <= 0
                                  ? driversPaymentState.originalCost.toString()
                                  : driversPaymentState.discountedCost
                                        .toString(),
                            ),
                            //  enabled:
                            //     driversPaymentState
                            //         .selectedDiscount
                            //         ?.discountPercentage !=
                            //     0,
                            keyboardType: TextInputType.numberWithOptions(
                              signed: true,
                              decimal: true,
                            ),
                            textInputAction: TextInputAction.done,
                            enabled: false,
                            onFieldSubmitted: (value) {
                              // double? doubleDiscount = double.tryParse(value);
                              // ref
                              //     .read(
                              //       driversPaymentControllerProvider.notifier,
                              //     )
                              //     .overrideTotalCost(doubleDiscount, true);
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
                                  text:
                                      '${driversPaymentState.discountedCost == null || driversPaymentState.discountedCost! <= 0 ? driversPaymentState.originalCost.toString() : driversPaymentState.discountedCost.toString()} ',
                                  style: Theme.of(
                                    context,
                                  ).textTheme.displaySmall,
                                ),
                                if (driversPaymentState.discountedCost !=
                                        null &&
                                    driversPaymentState.discountedCost !=
                                        driversPaymentState.originalCost)
                                  TextSpan(
                                    text: driversPaymentState.originalCost
                                        .toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          decoration:
                                              TextDecoration.lineThrough,
                                          fontSize: 13.sp,
                                        ),
                                  ),
                              ],
                            ),
                          ),
                          10.verticalSpace,

                          Consumer(
                            builder: (context, ref, child) {
                              var selectedServiceType = ref.watch(
                                availabilityControllerProvider.select(
                                  (value) => value.selectedServiceType,
                                ),
                              );
                              // 🔑 hide for Packages / Deep Clean / Maintenance
                              // final hideSupplies = selectedServiceType == "Packages" ||
                              //     selectedServiceType == "Deep Clean" ||
                              //     selectedServiceType == "Maintenance";

                              // if (hideSupplies) return const SizedBox.shrink();
                              return selectedServiceType != "Packages"
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        32.verticalSpace,
                                        AreCleaningSuppliesAvailable(),
                                      ],
                                    )
                                  : SizedBox.shrink();
                            },
                          ),

                          10.verticalSpace,
                          if (driversPaymentState.withCleaningSupplies &&
                              driversPaymentState.costAfterCleaningSuplies !=
                                  null)
                            TextFormField(
                              controller: TextEditingController(
                                text:
                                    '${driversPaymentState.fees ?? driversPaymentState.costAfterCleaningSuplies}',
                              ),
                              //  enabled:
                              //     driversPaymentState
                              //         .selectedDiscount
                              //         ?.discountPercentage !=
                              //     0,
                              keyboardType: TextInputType.numberWithOptions(
                                signed: true,
                                decimal: true,
                              ),
                              textInputAction: TextInputAction.done,
                              onFieldSubmitted: (value) {
                                driversPaymentNotifier.editFeesAmount(
                                  double.tryParse(value),
                                );
                              },
                              // onChanged: (value) {
                              //  driversPaymentNotifier.editFeesAmount(value);

                              // },
                              decoration: InputDecoration(
                                labelText: "Fees",
                                hintStyle: Theme.of(
                                  context,
                                ).inputDecorationTheme.hintStyle,
                              ),
                            ),

                          // Text.rich(
                          //   TextSpan(
                          //     children: [
                          //       TextSpan(
                          //         text: 'Fees: ',
                          //         style: Theme.of(
                          //           context,
                          //         ).textTheme.displayMedium,
                          //       ),
                          //       TextSpan(
                          //         text:
                          //             '${driversPaymentState.costAfterCleaningSuplies} ',
                          //         style: Theme.of(
                          //           context,
                          //         ).textTheme.displaySmall,
                          //       ),
                          //     ],
                          //   ),
                          // ),
                        ],
                      );
                    } else if (driversPaymentState.discountStates ==
                        RequestStates.loading) {
                      return const FadeCircleLoadingIndicator();
                    } else if (driversPaymentState.discountStates ==
                        RequestStates.error) {
                      return SimpleErrorWidget(
                        onTap: () => ref
                            .read(driversPaymentControllerProvider.notifier)
                            .getDiscountType(),
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),
                20.verticalSpace,

                Consumer(
                  builder: (context, ref, child) {
                    final driversPaymentState = ref.watch(
                      driversPaymentControllerProvider,
                    );

                    if (driversPaymentState.customerBalanceState ==
                        RequestStates.loaded) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          Divider(height: 0.1, color: AppColors.dividerGrey),
                          16.verticalSpace,
                          Text(
                            context.tr("Outstanding Balance"),
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                          8.verticalSpace,

                          TextFormField(
                            controller: TextEditingController(
                              text: driversPaymentState
                                  .customerBalanceData
                                  ?.outstandingBalance
                                  .toString(),
                            ),
                            //  enabled:
                            //     driversPaymentState
                            //         .selectedDiscount
                            //         ?.discountPercentage !=
                            //     0,
                            readOnly: true,

                            textInputAction: TextInputAction.done,

                            decoration: InputDecoration(
                              hintStyle: Theme.of(
                                context,
                              ).inputDecorationTheme.hintStyle,
                            ),
                          ),
                          20.verticalSpace,
                          Text(
                            context.tr("Advance Balance Amount"),
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                          12.verticalSpace,

                          Row(
                            children: [
                              Flexible(
                                child: TextFormField(
                                  controller: TextEditingController(
                                    text: driversPaymentState.isAdvancedBalance
                                        ? "0"
                                        : driversPaymentState
                                              .customerBalanceData
                                              ?.advanceBalance
                                              .toString(),
                                  ),
                                  //  enabled:
                                  //     driversPaymentState
                                  //         .selectedDiscount
                                  //         ?.discountPercentage !=
                                  //     0,
                                  readOnly: true,

                                  textInputAction: TextInputAction.done,

                                  decoration: InputDecoration(
                                    hintStyle: Theme.of(
                                      context,
                                    ).inputDecorationTheme.hintStyle,
                                  ),
                                ),
                              ),
                              Checkbox(
                                value: driversPaymentState.isAdvancedBalance,
                                onChanged: (d) {
                                  ref
                                      .read(
                                        driversPaymentControllerProvider
                                            .notifier,
                                      )
                                      .idAdvancedToggle();
                                },
                              ),
                            ],
                          ),
                          20.verticalSpace,
                          if (driversPaymentState.isAdvancedBalance) ...[
                            Text(
                              context.tr("Used Advance Amount"),
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                            8.verticalSpace,

                            TextFormField(
                              controller: TextEditingController(
                                text: driversPaymentState
                                    .customerBalanceData
                                    ?.advanceBalance
                                    .toString(),
                              ),
                              //  enabled:
                              //     driversPaymentState
                              //         .selectedDiscount
                              //         ?.discountPercentage !=
                              //     0,
                              readOnly: true,

                              textInputAction: TextInputAction.done,

                              decoration: InputDecoration(
                                hintStyle: Theme.of(
                                  context,
                                ).inputDecorationTheme.hintStyle,
                              ),
                            ),
                          ],
                          32.verticalSpace,
                        ],
                      );
                    } else if (driversPaymentState.customerBalanceState ==
                        RequestStates.loading) {
                      return const LinearProgressIndicator(
                        backgroundColor: AppColors.disabledButtonBackground,
                        color: AppColors.primary,
                      );
                    } else if (driversPaymentState.customerBalanceState ==
                        RequestStates.error) {
                      return SimpleErrorWidget(
                        onTap: () => ref
                            .read(driversPaymentControllerProvider.notifier)
                            .getCustomerBalance(),
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),

                // (driversPaymentState.customerBalanceState ==
                //         RequestStates.loading)
                //     ? LinearProgressIndicator(
                //         backgroundColor: AppColors.disabledButtonBackground,
                //         color: AppColors.primary,
                //       )
                //     : Column(
                //         children: [
                //           Divider(height: 0.1, color: AppColors.dividerGrey),
                //           16.verticalSpace,
                //           Text(
                //             context.tr("Customer balance"),
                //             style: Theme.of(context).textTheme.displayMedium,
                //           ),
                //           8.verticalSpace,

                //           TextFormField(
                //             controller: TextEditingController(
                //               text: driversPaymentState
                //                   .customerBalanceData
                //                   ?.outstandingBalance
                //                   .toString(),
                //             ),
                //             //  enabled:
                //             //     driversPaymentState
                //             //         .selectedDiscount
                //             //         ?.discountPercentage !=
                //             //     0,
                //             readOnly: true,

                //             textInputAction: TextInputAction.done,

                //             decoration: InputDecoration(
                //               hintStyle: Theme.of(
                //                 context,
                //               ).inputDecorationTheme.hintStyle,
                //             ),
                //           ),
                //           20.verticalSpace,
                //           Text(
                //             context.tr("advanced Balnce"),
                //             style: Theme.of(context).textTheme.displayMedium,
                //           ),
                //           12.verticalSpace,

                //           Row(
                //             children: [
                //               Flexible(
                //                 child: TextFormField(
                //                   controller: TextEditingController(
                //                     text: driversPaymentState.isAdvancedBalance
                //                         ? "0"
                //                         : driversPaymentState
                //                               .customerBalanceData
                //                               ?.advanceBalance
                //                               .toString(),
                //                   ),
                //                   //  enabled:
                //                   //     driversPaymentState
                //                   //         .selectedDiscount
                //                   //         ?.discountPercentage !=
                //                   //     0,
                //                   readOnly: true,

                //                   textInputAction: TextInputAction.done,

                //                   decoration: InputDecoration(
                //                     hintStyle: Theme.of(
                //                       context,
                //                     ).inputDecorationTheme.hintStyle,
                //                   ),
                //                 ),
                //               ),
                //               Checkbox(
                //                 value: driversPaymentState.isAdvancedBalance,
                //                 onChanged: (d) {
                //                   ref
                //                       .read(
                //                         driversPaymentControllerProvider
                //                             .notifier,
                //                       )
                //                       .idAdvancedToggle();
                //                 },
                //               ),
                //             ],
                //           ),
                //           20.verticalSpace,
                //           if (driversPaymentState.isAdvancedBalance) ...[
                //             Text(
                //               context.tr("Used advanced balance"),
                //               style: Theme.of(context).textTheme.displayMedium,
                //             ),
                //             8.verticalSpace,

                //             TextFormField(
                //               controller: TextEditingController(
                //                 text: driversPaymentState
                //                     .customerBalanceData
                //                     ?.advanceBalance
                //                     .toString(),
                //               ),
                //               //  enabled:
                //               //     driversPaymentState
                //               //         .selectedDiscount
                //               //         ?.discountPercentage !=
                //               //     0,
                //               readOnly: true,

                //               textInputAction: TextInputAction.done,

                //               decoration: InputDecoration(
                //                 hintStyle: Theme.of(
                //                   context,
                //                 ).inputDecorationTheme.hintStyle,
                //               ),
                //             ),
                //           ],
                //         ],
                //       ),
                32.verticalSpace,
                PaymentMethodChips(),
                32.verticalSpace,
                Divider(height: 0.1, color: AppColors.dividerGrey),

                16.verticalSpace,
                Text(
                  context.tr(AppStrings.note),
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                8.verticalSpace,
                Consumer(
                  builder: (context, ref, child) {
                    return TextFormField(
                      controller: noteController,
                      minLines: 3,
                      maxLines: 3,
                      textDirection: TextDirection.ltr,
                      textAlign: TextAlign.start,
                      onChanged: (value) {
                        ref
                            .read(driversPaymentControllerProvider.notifier)
                            .setNote(value);
                      },
                      decoration: InputDecoration(
                        hintText: 'Add notes if needed (optional)...',
                        hintStyle: Theme.of(
                          context,
                        ).inputDecorationTheme.hintStyle,
                      ),
                    );
                  },
                ),
                50.verticalSpace,

                Center(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 25.h),
                    child: Consumer(
                      builder: (context, ref, child) {
                        final drvierDiscountState = ref.watch(
                          driversPaymentControllerProvider,
                        );
                        final selectedServiceType = ref.watch(
                          availabilityControllerProvider.select(
                            (value) => value.selectedServiceType,
                          ),
                        );

                        final submitServiceStates = ref.watch(
                          submitServiceControllerProvider.select(
                            (value) => value.submitServiceStates,
                          ),
                        );
                        ref.listen<
                          SubmitServiceState
                        >(submitServiceControllerProvider, (previous, next) {
                          if (next.submitServiceStates == RequestStates.error) {
                            _dropdownKey.currentState?.closeOverlay();

                            showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                title: Assets.images.errorX.svg(),
                                content: Text(
                                  next.submitServiceMessage ??
                                      "An unexpected error occurred. Please try again.",
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayMedium!
                                      .copyWith(fontSize: 20.sp),
                                ),
                              ),
                            );
                          }
                          if (next.submitServiceStates ==
                              RequestStates.loaded) {
                            debugPrint("LOADEDEDEDEDEDEDEDEDEDEDED");
                            context.router.replaceAll([
                              MainRoute(children: [HomeRoute()]),
                            ]);

                            showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                title: selectedServiceType == "On Call"
                                    ? Assets.images.greenSuccessful.svg(
                                        width: 100,
                                        height: 100,
                                      )
                                    : Assets.images.successful.svg(),
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
                        });
                        return CustomButton(
                          title: tr.tr(context: context, AppStrings.submit),
                          onPressed:
                              drvierDiscountState.selectedDriver == null ||
                                  submitServiceStates == RequestStates.loading
                              ? null
                              : () async {
                                  _dropdownKey.currentState?.closeOverlay();

                                  final fs = await ref
                                      .watch(
                                        submitServiceControllerProvider
                                            .notifier,
                                      )
                                      .submitService();
                                  if (fs) {
                                    context.router.replaceAll([
                                      MainRoute(children: [HomeRoute()]),
                                    ]);
                                  }
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
      ),
    );
  }
}
