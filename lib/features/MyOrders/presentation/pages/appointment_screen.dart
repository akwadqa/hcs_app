import 'dart:async';

import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hcs/features/MyOrders/presentation/controllers/appointment_controller.dart';
import 'package:hcs/features/MyOrders/presentation/controllers/myorders_controller.dart';
import 'package:hcs/features/MyOrders/presentation/widgets/appointment_card.dart';
import 'package:hcs/features/MyOrders/presentation/widgets/share_to_whatsapp.dart';
import 'package:hcs/gen/assets.gen.dart';
import 'package:hcs/src/shared_widgets/app_error_widget.dart';
import 'package:hcs/src/shared_widgets/app_pagination_widget.dart';
import 'package:hcs/src/shared_widgets/custom_appbar.dart';
import 'package:hcs/src/shared_widgets/fade_circle_loading_indicator.dart';

@RoutePage()
class AppoinmentScreen extends ConsumerStatefulWidget {
  final String serviceOrderID;

  const AppoinmentScreen({
    super.key,
    required this.serviceOrderID,
  });

  @override
  ConsumerState<AppoinmentScreen> createState() => _MyOrdersContentState();
}

class _MyOrdersContentState extends ConsumerState<AppoinmentScreen> {

  @override
  void initState() {
    super.initState();
    Future(
      () => ref
          .read(appointmentControllerProvider.notifier)
          .fetchAppontments(
            serviceOrderID: widget.serviceOrderID,
          page: 1,
          ),
    );

  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: CustomAppbar(
        hasBackArrow: true,
        // title: AppStrings.appointmentDetails,
        title: 'Appointment details',
        actions: [
          // ShareToWhatsApp(
          //   serviceOrderId: widget.serviceOrderID,
          //   orderDetails: null,
          //   isOrderShare: true,
          // ),
        ],
      ),
      body: buildBody(context),
    );
  }

  Widget buildBody(BuildContext context) {
    final controller = ref.watch(appointmentControllerProvider);
    return controller.when(
      data: (data) {
        if (data.isEmpty) {
          return SingleChildScrollView(
            child: RefreshIndicator(
              onRefresh: () async {
                await ref
                    .read(appointmentControllerProvider.notifier)
                    .fetchAppontments(
                      serviceOrderID: widget.serviceOrderID,
                      page: 1,
                    );
              },
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                  SizedBox(height: 50.h),
                  Center(child: Assets.images.noDataMin.image()),
                ],
              ),
            ),
          );
        }

        return AppPaginationWidget(
          child: ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: data.length,
            itemBuilder: (context, index) {
              return AppointmentCard(appointmentData: data[index]);
            },
          ),
          onLoading: (page) {
            return ref
                .read(appointmentControllerProvider.notifier)
                .onLoadMoreApprovedOrders(widget.serviceOrderID);
          },
        );
      },
      error: (e, st) {
        return AppErrorWidget(
        onTap: () => Future(
          () => ref
              .read(appointmentControllerProvider.notifier)
              .fetchAppontments(
                serviceOrderID: widget.serviceOrderID,
                page: 1,
              ),
        ),
      );
      },
      loading: () {
        return Center(child: FadeCircleLoadingIndicator(),);
      },
    );

    // if (ordersState.appointmentsStates == RequestStates.init ||
    //     ordersState.appointmentsStates == RequestStates.loading) {
    //   return Center(child: FadeCircleLoadingIndicator());
    // } else if (ordersState.appointmentsStates == RequestStates.loaded) {
    //   if (ordersState.ordersAppointments.isEmpty) {
    //     return SingleChildScrollView(
    //       child: RefreshIndicator(
    //         onRefresh: () async {
    //           await ref
    //               .read(myOrdersControllerProvider.notifier)
    //               .fetchAppontments(
    //                 serviceOrderID: widget.serviceOrderID,
    //                 dateType: widget.dateType,
    //               );
    //         },
    //         child: ListView(
    //           physics: const AlwaysScrollableScrollPhysics(),
    //           children: [
    //             SizedBox(height: 50.h),
    //             Center(child: Assets.images.noDataMin.image()),
    //           ],
    //         ),
    //       ),
    //     );
    //   }

    //   return RefreshIndicator(
    //     onRefresh: () async {
    //       await ref
    //           .read(myOrdersControllerProvider.notifier)
    //           .fetchAppontments(
    //             serviceOrderID: widget.serviceOrderID,
    //             dateType: widget.dateType,
    //           );
    //     },
    //     child: ListView.builder(
    //       controller: _scrollController,
    //       physics: const AlwaysScrollableScrollPhysics(),
    //       shrinkWrap: true,
    //       itemCount: ordersState.ordersAppointments.length + 1,
    //       itemBuilder: (context, index) {
    //         if (index >= ordersState.ordersAppointments.length) {
    //           if (ordersState.currentAppointmentsPage == null) {
    //             return Center(
    //               child: Text(
    //                 'No More Appointments',
    //                 style: Theme.of(context).textTheme.bodyMedium,
    //               ),
    //             );
    //           } else {
    //             return const Padding(
    //               padding: EdgeInsets.all(8),
    //               child: Center(child: FadeCircleLoadingIndicator()),
    //             );
    //           }
    //         }
    //         return GestureDetector(
    //           onTap: () {
    //             // if(ordersState.ordersAppointments[index].logStatus!="Canceled") {
    //             Navigator.of(context).push(
    //               MaterialPageRoute(
    //                 builder: (m) => OrderDetailsScreen(
    //                   serviceOrderID: widget.serviceOrderID,
    //                   appointmentID:
    //                       ordersState.ordersAppointments[index].logId,
    //                 ),
    //               ),
    //             );
    //             //   context.pushRoute(
    //             //   OrderDetailsRoute(
    //             //     serviceOrderID: widget.serviceOrderID,
    //             //     appointmentID: ordersState.ordersAppointments[index].logId,
    //             //   ),
    //             // );
    //             // }
    //           },
    //           child: AppointmentCard(
    //             appointmentData: ordersState.ordersAppointments[index],
    //             // orderDetailstData: ordersState.ordersDetails,

    //             // logStatus: ordersState.ordersAppointments[index].logStatus,
    //             orderId: widget.serviceOrderID,
    //             // driverStatus:
    //             //     ordersState.ordersAppointments[index].driverStatus ?? "",
    //             // servicetype: ordersState.ordersAppointments[index].serviceType,
    //             // date: ordersState.ordersAppointments[index].date,
    //             // employeeName:
    //             //     ordersState.ordersAppointments[index].employeeName,
    //           ),
    //         );
    //       },
    //     ),
    //   );
    // } else if (ordersState.appointmentsStates == RequestStates.error) {
    //   return AppErrorWidget(
    //     onTap: () => Future(
    //       () => ref
    //           .read(myOrdersControllerProvider.notifier)
    //           .fetchAppontments(
    //             serviceOrderID: widget.serviceOrderID,
    //             dateType: widget.dateType,
    //           ),
    //     ),
    //   );
    // }
    // return SizedBox.shrink();
  }
}

//     return Scaffold(
//       appBar: CustomAppbar(
//         hasBackArrow: true,
//         title: context.tr(AppStrings.appointmentDetails),
//       ),
//       body: ListView.builder(
//         // controller: _scrollController,
//         shrinkWrap: true,
//         itemCount: 3,
//         itemBuilder: (context, index) {
//           return InkWell(
//             onTap: () {
//               context.pushRoute(
//                 OrderDetailsRoute(serviceOrderID: widget.serviceOrderID),
//               );
//             },
//             child: AppointmentCard(),
//           );
//         },
//       ),
//     );
//   }
// }
