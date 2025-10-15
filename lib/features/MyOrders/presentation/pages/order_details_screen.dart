import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hcs/features/MyOrders/domain/models/appointment/appoitnment_model.dart';
import 'package:hcs/features/MyOrders/domain/models/order_details/order_details_model.dart';
import 'package:hcs/features/MyOrders/domain/models/services_order/services_order_model.dart';
import 'package:hcs/features/MyOrders/presentation/controllers/cancelling_order_controller.dart';
import 'package:hcs/features/MyOrders/presentation/controllers/myorders_controller.dart';
import 'package:hcs/features/MyOrders/presentation/controllers/myorders_state.dart';
import 'package:hcs/features/MyOrders/presentation/controllers/order_details_controller.dart';
import 'package:hcs/features/MyOrders/presentation/widgets/info_row.dart';
import 'package:hcs/features/MyOrders/presentation/widgets/map_button.dart';
import 'package:hcs/features/MyOrders/presentation/widgets/share_to_whatsapp.dart';
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
class OrderDetailsScreen extends ConsumerStatefulWidget {
  final String serviceOrderID;
  const OrderDetailsScreen({super.key, required this.serviceOrderID});

  @override
  ConsumerState<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends ConsumerState<OrderDetailsScreen> {
  late String? orderStatus;
  @override
  void initState() {
    super.initState();
    Future(() {
      ref
          .read(orderDetailsControllerProvider.notifier)
          .fetchOrdersDetails(serviceOrderID: widget.serviceOrderID);
    });
  }

  @override
  Widget build(BuildContext context) {
    orderStatus = ref.watch(orderDetailsControllerProvider).value?.status;
    final controller = ref.watch(orderDetailsControllerProvider);

    ref.listen(cancellingOrderControllerProvider, (pre, next) {
      if (next is AsyncData) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ref
              .read(orderDetailsControllerProvider.notifier)
              .fetchOrdersDetails(serviceOrderID: widget.serviceOrderID);
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: Assets.images.redSuccessful.svg(width: 100, height: 100),
              content: Text(
                'Service has been\ncancelled successfully.',
                textAlign: TextAlign.center,
                style: Theme.of(
                  context,
                ).textTheme.displayMedium!.copyWith(fontSize: 20.sp),
              ),
            ),
          );
        });
      }

      if (next is AsyncError) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: Assets.images.errorX.svg(),
              content: Text(
                next.error.toString() ??
                    "An unexpected error occurred.\nPlease try again.",
                textAlign: TextAlign.center,
                style: Theme.of(
                  context,
                ).textTheme.displayMedium!.copyWith(fontSize: 20.sp),
              ),
            ),
          );
        });
      }
    });

    return Scaffold(
      body: controller.when(
        data: (data) {
          if (data != null) {
            return _buildContent(data);
          }
        },
        error: (e, st) {
          return AppErrorWidget(
            onTap: () {
              ref
                  .read(orderDetailsControllerProvider.notifier)
                  .fetchOrdersDetails(serviceOrderID: widget.serviceOrderID);
            },
          );
        },
        loading: () => Center(child: FadeCircleLoadingIndicator()),
      ),
      appBar: CustomAppbar(
        hasBackArrow: true,
        title: context.tr(AppStrings.orderDetails),
        withTabs: false,
        actions: controller.whenOrNull(
          data: (data) {
            return [
              ShareToWhatsApp(
                serviceOrderId: widget.serviceOrderID,
                orderDetails: data,
              ),
            ];
          },
        ),
      ),

      bottomNavigationBar: Consumer(
        builder: (context, ref, child) {
          final controllerCancel = ref.watch(cancellingOrderControllerProvider);
          final order = ref.watch(orderDetailsControllerProvider);
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 17.h, horizontal: 26.w),
            child: Row(
              children: [
                if (!order.isLoading)
                  Expanded(
                    child: CustomButton(
                      title: 'Apointment',
                      onPressed: () {
                        context.pushRoute(
                          AppoinmentRoute(
                            serviceOrderID: widget.serviceOrderID,
                          ),
                        );
                      },
                      buttonColor: AppColors.blueText,
                    ),
                  ),
                if (orderStatus == 'Approved') 5.horizontalSpace,
                if (orderStatus == 'Approved')
                  Expanded(
                    child: CustomButton(
                      title: AppStrings.cancelOrder.tr(context: context),
                      buttonColor: AppColors.red,
                      onPressed: controllerCancel.isLoading
                          ? null
                          : () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text(
                                    AppStrings.cancelOrder.tr(context: context),
                                  ),
                                  content: Text(
                                    "Are you sure you want to cancel this order?",
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: Text("No"),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        ref
                                            .read(
                                              cancellingOrderControllerProvider
                                                  .notifier,
                                            )
                                            .orderCancelltion(
                                              serviceOrderID:
                                                  widget.serviceOrderID,
                                            );
                                      },
                                      child: Text("Yes"),
                                    ),
                                  ],
                                ),
                              );
                            },

                      //  orderCancelltionStates != RequestStates.loading
                      //     ? () {
                      //         showDialog(
                      //           context: context,
                      //           builder: (context) => AlertDialog(
                      //             title: Text(
                      //               AppStrings.cancelOrder.tr(context: context),
                      //             ),
                      //             content: Text(
                      //               "Are you sure you want to cancel this order?",
                      //             ),
                      //             actions: [
                      //               TextButton(
                      //                 onPressed: () => Navigator.pop(context),
                      //                 child: Text("No"),
                      //               ),
                      //               TextButton(
                      //                 onPressed: () {
                      //                   Navigator.pop(context);
                      //                   ref
                      //                       .read(
                      //                         myOrdersControllerProvider.notifier,
                      //                       )
                      //                       .orderCancelltion(
                      //                         serviceOrderID:
                      //                             widget.serviceOrderID,
                      //                       );
                      //                 },
                      //                 child: Text("Yes"),
                      //               ),
                      //             ],
                      //           ),
                      //         );
                      //       }
                      //     : null,
                    ),
                  ),
              ],
            ),
          );

          return SizedBox.shrink();
        },

        // bottomNavigationBar: controller.whenOrNull(
        //   data: (data) {
        //     if (data?.status == 'Approved') {
        //       //? The controller for cancel order :
        //       final cancelController = ref.watch(
        //         cancellingOrderControllerProvider,
        //       );

        //       //? Listen :
        //       cancelController.whenOrNull(
        //         error: (e, st) {
        //           //? Show error dialog :
        //           showDialog(
        //             context: context,
        //             builder: (_) => AlertDialog(
        //               title: Assets.images.errorX.svg(),
        //               content: Text(
        //                 e.toString() ??
        //                     "An unexpected error occurred.\nPlease try again.",
        //                 textAlign: TextAlign.center,
        //                 style: Theme.of(
        //                   context,
        //                 ).textTheme.displayMedium!.copyWith(fontSize: 20.sp),
        //               ),
        //             ),
        //           );
        //           return OrderDetailsBottomNav(
        //             isLoading: false,
        //             onTap: () {
        //               Navigator.pop(context);
        //               ref
        //                   .read(myOrdersControllerProvider.notifier)
        //                   .orderCancelltion(
        //                     serviceOrderID: widget.serviceOrderID,
        //                   );
        //             },
        //           );
        //         },
        //         loading: (){
        //             return OrderDetailsBottomNav(
        //             isLoading: true,
        //             onTap: () {
        //               Navigator.pop(context);
        //               ref
        //                   .read(myOrdersControllerProvider.notifier)
        //                   .orderCancelltion(
        //                     serviceOrderID: widget.serviceOrderID,
        //                   );
        //             },
        //           );
        //         },

        //         data: (data) {
        //           //? Show succed dialog :
        //           showDialog(
        //             context: context,
        //             builder: (_) => AlertDialog(
        //               title: Assets.images.redSuccessful.svg(
        //                 width: 100,
        //                 height: 100,
        //               ),

        //               content: Text(
        //                 'Service has been\ncancelled successfully.',
        //                 textAlign: TextAlign.center,
        //                 style: Theme.of(
        //                   context,
        //                 ).textTheme.displayMedium!.copyWith(fontSize: 20.sp),
        //               ),
        //             ),
        //           );

        //           return OrderDetailsBottomNav(
        //             isLoading: false,
        //             onTap: () {
        //               Navigator.pop(context);
        //               ref
        //                   .read(myOrdersControllerProvider.notifier)
        //                   .orderCancelltion(
        //                     serviceOrderID: widget.serviceOrderID,
        //                   );
        //             },
        //           );
        //         },
        //       );
        //     }
        //   },
        // ),
        // bottomNavigationBar:
        //     orderStatus == RequestStates.loaded && details?.status == 'Approved'
        //     ? Consumer(
        //         builder: (context, ref, child) {
        //           var orderCancelltionStates = ref.watch(
        //             myOrdersControllerProvider.select(
        //               (value) => value.orderCancelltionStates,
        //             ),
        //           );
        //           ref.listen<MyOrdersState>(myOrdersControllerProvider, (
        //             previous,
        //             next,
        //           ) {
        //             if (next.orderCancelltionStates == RequestStates.loaded) {
        //               showDialog(
        //                 context: context,
        //                 builder: (_) => AlertDialog(
        //                   title: Assets.images.redSuccessful.svg(
        //                     width: 100,
        //                     height: 100,
        //                   ),

        //                   content: Text(
        //                     'Service has been\ncancelled successfully.',
        //                     textAlign: TextAlign.center,
        //                     style: Theme.of(
        //                       context,
        //                     ).textTheme.displayMedium!.copyWith(fontSize: 20.sp),
        //                   ),
        //                 ),
        //               );
        //             }

        //             if (next.orderCancelltionStates == RequestStates.error) {
        //               showDialog(
        //                 context: context,
        //                 builder: (_) => AlertDialog(
        //                   title: Assets.images.errorX.svg(),
        //                   content: Text(
        //                     next.orderCancelltionMessage ??
        //                         "An unexpected error occurred.\nPlease try again.",
        //                     textAlign: TextAlign.center,
        //                     style: Theme.of(
        //                       context,
        //                     ).textTheme.displayMedium!.copyWith(fontSize: 20.sp),
        //                   ),
        //                 ),
        //               );
        //             }
        //           });

        //           return Padding(
        //             padding: EdgeInsets.symmetric(
        //               vertical: 17.h,
        //               horizontal: 26.w,
        //             ),
        //             child: CustomButton(
        //               title: AppStrings.cancelOrder.tr(context: context),
        //               buttonColor: AppColors.blueText,
        //               onPressed: orderCancelltionStates != RequestStates.loading
        //                   ? () {
        //                       showDialog(
        //                         context: context,
        //                         builder: (context) => AlertDialog(
        //                           title: Text(
        //                             AppStrings.cancelOrder.tr(context: context),
        //                           ),
        //                           content: Text(
        //                             "Are you sure you want to cancel this order?",
        //                           ),
        //                           actions: [
        //                             TextButton(
        //                               onPressed: () => Navigator.pop(context),
        //                               child: Text("No"),
        //                             ),
        //                             TextButton(
        //                               onPressed: () {
        //                                 Navigator.pop(context);
        //                                 ref
        //                                     .read(
        //                                       myOrdersControllerProvider.notifier,
        //                                     )
        //                                     .orderCancelltion(
        //                                       serviceOrderID:
        //                                           widget.serviceOrderID,
        //                                     );
        //                               },
        //                               child: Text("Yes"),
        //                             ),
        //                           ],
        //                         ),
        //                       );
        //                     }
        //                   : null,
        //             ),
        //           );
        //         },
        //       )
        //     : null,
      ),
    );
  }

  Widget _buildContent(OrderDetails details) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 17.h, horizontal: 26.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              widget.serviceOrderID,
              style: Theme.of(context).textTheme.displayMedium!.copyWith(
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.blueTitle,
              ),
            ),
          ),
          16.verticalSpace,

          // --- Info Rows ---
          InfoRow("Customer", value: details?.customer?.customerName),
          InfoRow("Area", value: details?.customer?.location),
          InfoRow("Zone", value: details?.customer?.zone),
          InfoRow(
            "Location",
            widget: details?.customer?.locationUrl != null
                ? MapPreviewCard(
                    lcoationUrl: details!.customer!.locationUrl!,
                    locationName: details.customer!.location!,
                  )
                : null,
            value: details?.customer?.locationUrl,
          ),

          Padding(
            padding: EdgeInsets.symmetric(vertical: 24.h),
            child: Divider(height: 0.1, color: AppColors.dividerGrey),
          ),

          InfoRow("Service type", value: details?.serviceType),
          InfoRow("Shift type", value: details?.shiftType),
          //TODO :
          details?.days != null && details.days!.isNotEmpty
              ? InfoRow(
                  "Work Days",
                  value: (details.days as List?)?.join(',') ?? '',
                )
              : SizedBox.shrink(),
          InfoRow("Date", value: details?.date),

          // InfoRow("Service Category", value: "On Call"),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 24.h),
            child: Divider(height: 0.1, color: AppColors.dividerGrey),
          ),

          InfoRow(
            "Employees name",
            value: (details?.staffAppointment as List?)?.join(',\n') ?? '',
          ),

          InfoRow("Driver name", value: details?.driver?.driverName),

          Padding(
            padding: EdgeInsets.symmetric(vertical: 24.h),
            child: Divider(height: 0.1, color: AppColors.dividerGrey),
          ),

          InfoRow("Discount Type", value: details?.discountType),
          InfoRow(
            "Discount Percentage",
            value: details?.discountPercentage.toString(),
          ),
          InfoRow("Payment Method", value: details?.methodOfPayment),

          Padding(
            padding: EdgeInsets.symmetric(vertical: 24.h),
            child: Divider(height: 0.1, color: AppColors.dividerGrey),
          ),
          details?.note != null && details!.note!.isNotEmpty
              ? InfoRow("Note", value: details.note)
              : SizedBox.shrink(),
          InfoRow(
            "Cleaning supply",
            value: details?.withCleaningSupplies == 0 ? "No" : "Yes",
          ),
          InfoRow(
            "Outstanding amount",
            value: details?.outstandingAmount != null
                ? details?.outstandingAmount.toString()
                : null,
          ),

          24.verticalSpace,
          Center(
            child: Text(
              "QR ${details?.totalNetAmount}",
              style: TextStyle(
                fontSize: 20.sp,
                color: AppColors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// class OrderDetailsBottomNav extends StatelessWidget {
//   const OrderDetailsBottomNav({
//     super.key,
//     required this.isLoading,
//     required this.onTap,
//   });
//   final bool isLoading;
//   final void Function() onTap;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 17.h, horizontal: 26.w),
//       child: CustomButton(
//         title: AppStrings.cancelOrder.tr(context: context),
//         buttonColor: AppColors.blueText,
//         onPressed: !isLoading
//             ? () {
//                 showDialog(
//                   context: context,
//                   builder: (context) => AlertDialog(
//                     title: Text(AppStrings.cancelOrder.tr(context: context)),
//                     content: Text(
//                       "Are you sure you want to cancel this order?",
//                     ),
//                     actions: [
//                       TextButton(
//                         onPressed: () => Navigator.pop(context),
//                         child: Text("No"),
//                       ),
//                       TextButton(
//                         onPressed: onTap,
//                         // () {
//                         // Navigator.pop(context);
//                         // ref
//                         //     .read(myOrdersControllerProvider.notifier)
//                         //     .orderCancelltion(
//                         //       serviceOrderID: widget.serviceOrderID,
//                         //     );
//                         // },
//                         child: Text("Yes"),
//                       ),
//                     ],
//                   ),
//                 );
//               }
//             : null,
//       ),
//     );
//   }
// }
