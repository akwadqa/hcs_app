import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hcs/features/MyOrders/domain/models/services_order/services_order_model.dart';
import 'package:hcs/features/MyOrders/presentation/controllers/today_orders_controller.dart';
import 'package:hcs/features/MyOrders/presentation/controllers/myorders_controller.dart';
import 'package:hcs/gen/assets.gen.dart';
import 'package:hcs/src/enums/orders_status_enums.dart';
import 'package:hcs/src/enums/request_state.dart';
import 'package:hcs/src/routing/app_router.gr.dart';
import 'package:hcs/src/shared_widgets/app_error_widget.dart';
import 'package:hcs/src/shared_widgets/app_pagination_widget.dart';
import 'package:hcs/src/shared_widgets/fade_circle_loading_indicator.dart';
import 'package:hcs/src/theme/app_colors.dart';

class AcceptedOrdersScreen extends ConsumerStatefulWidget {
  const AcceptedOrdersScreen({super.key});
  @override
  ConsumerState<AcceptedOrdersScreen> createState() =>
      _AcceptedOrdersScreenState();
}

class _AcceptedOrdersScreenState extends ConsumerState<AcceptedOrdersScreen> {
  // const AcceptedOrdersScreen({super.key});
  @override
  void initState() {
    super.initState();
    Future(
      () => ref
          .read(todayOrdersControllerProvider.notifier)
          .fetchTodayOrders(page: 1),
    );
  }

  // late ScrollController _scrollController;
  // Timer? _loadMoreTimer;

  // @override
  // void initState() {
  //   super.initState();
  //   Future(
  //     () => ref.read(myOrdersControllerProvider.notifier).fetchApprovedOrders(),
  //   );

  //   _scrollController = ScrollController()..addListener(_onScroll);
  // }

  // _onScroll() {
  //   final customerState = ref.read(myOrdersControllerProvider);
  //   final hasMore = customerState.currentApprovedOrdersPage != null;

  //   if (_scrollController.position.pixels >
  //           _scrollController.position.maxScrollExtent - 100 &&
  //       hasMore) {
  //     _loadMoreTimer?.cancel();
  //     _loadMoreTimer = Timer(const Duration(milliseconds: 500), () {
  //       ref
  //           .read(myOrdersControllerProvider.notifier)
  //           .onLoadMoreApprovedOrders();
  //     });
  //   }
  // }

  // @override
  // void dispose() {
  //   _loadMoreTimer?.cancel();
  //   _scrollController.dispose();
  //   super.dispose();
  // }
  _buildBody(BuildContext context, List<Order> orders) {
    return AppPaginationWidget(
      enablePullDown: true,
      onRefresh: () {
        return ref.read(todayOrdersControllerProvider.notifier).refreshToday();
      },
      onLoading: (page) {
        return ref
            .read(todayOrdersControllerProvider.notifier)
            .onLoadMoreTodayOrders();
      },
      child: ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              context.pushRoute(
                OrderDetailsRoute(
                  serviceOrderID: orders[index].serviceOrderId ?? 'bb',
                ),
              );
            },
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 16.h, horizontal: 24.w),
              padding: EdgeInsets.symmetric(vertical: 13.h, horizontal: 22.w),
              // height: 100.h,
              width: 345.w,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        orders[index].serviceOrderId ?? 'bb',
                        style: Theme.of(context).textTheme.displaySmall!
                            .copyWith(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      Row(
                        children: [
                          Assets.images.pending.svg(),
                          9.horizontalSpace,
                          Text(
                            orders[index].status.toString().status,
                            style: Theme.of(context).textTheme.displayMedium!
                                .copyWith(fontSize: 14.sp),
                          ),
                        ],
                      ),
                    ],
                  ),
                  8.verticalSpace,
                  Text(
                    orders[index].serviceType ?? '',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 12.sp,
                      color: AppColors.greyText,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  8.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        orders[index].postingDate ?? '',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 12.sp,
                          color: AppColors.greyText,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        "QR ${orders[index].totalNetAmount}",
                        style: Theme.of(context).textTheme.displaySmall!
                            .copyWith(
                              fontSize: 12.sp,
                              color: AppColors.greenText,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(todayOrdersControllerProvider);
    return controller.when(
      error: (e, st) => AppErrorWidget(
        onTap: () {
          ref
              .read(todayOrdersControllerProvider.notifier)
              .fetchTodayOrders(page: 1);
        },
      ),
      loading: () {
        return Center(child: FadeCircleLoadingIndicator());
      },
      data: (data) {
        if ((data?.length ?? 0) == 0) {
          return RefreshIndicator(
            onRefresh: () async {
              await ref
                  .read(todayOrdersControllerProvider.notifier)
                  .fetchTodayOrders(page: 1);
            },
            child: ListView(
              physics: AlwaysScrollableScrollPhysics(),
              children: [Assets.images.noDataMin.image()],
            ),
          );
        }
        return _buildBody(context, data ?? []);
      },
    );

    // return AppPaginationWidget(child: controller.when( error: (e,st){}, loading: (){} , data: (data){}) , onLoading: ref.read(myOrdersControllerProvider.notifier).onLoadMoreApprovedOrders(); )

    // var ordersState = ref.watch(myOrdersControllerProvider);

    // if (ordersState.approvedOrdersStates == RequestStates.init ||
    //     ordersState.approvedOrdersStates == RequestStates.loading) {
    //   // return Center(child: FadeCircleLoadingIndicator());
    //   return FadeCircleLoadingIndicator();
    // } else if (ordersState.approvedOrdersStates == RequestStates.loaded) {
    //   if (ordersState.approvedOrders.isEmpty) {
    //     return RefreshIndicator(
    //       onRefresh: () async {
    //         await ref
    //             .read(myOrdersControllerProvider.notifier)
    //             .fetchApprovedOrders();
    //       },
    //       child: ListView(
    //         physics: AlwaysScrollableScrollPhysics(),
    //         children: [Assets.images.noDataMin.image()],
    //       ),
    //     );
    //   }
    //   return RefreshIndicator(
    //     onRefresh: () async {
    //       await ref
    //           .read(myOrdersControllerProvider.notifier)
    //           .fetchApprovedOrders();
    //     },
    //     child: ListView.builder(
    //       physics: AlwaysScrollableScrollPhysics(),
    //       controller: _scrollController,
    //       shrinkWrap: true,
    //       itemCount: ordersState.approvedOrders.length + 1,
    //       itemBuilder: (context, index) {
    //         if (index >= ordersState.approvedOrders.length) {
    //           if (ordersState.currentApprovedOrdersPage == null) {
    //             return Center(
    //               child: Text(
    //                 'No More Orders',
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
    //             context.pushRoute(
    //               OrderDetailsRoute(
    //                 serviceOrderID:
    //                     ordersState.approvedOrders[index].serviceOrderId ?? 'bb',
    //               ),
    //             );
    //           },
    //           child: Container(
    //             margin: EdgeInsets.symmetric(vertical: 16.h, horizontal: 24.w),
    //             padding: EdgeInsets.symmetric(vertical: 13.h, horizontal: 22.w),
    //             // height: 100.h,
    //             width: 345.w,
    //             decoration: BoxDecoration(
    //               color: Colors.white,
    //               borderRadius: BorderRadius.circular(8),
    //             ),
    //             child: Column(
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: [
    //                 Row(
    //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                   children: [
    //                     Text(
    //                       ordersState.[index].serviceOrderId ?? 'bb',
    //                       style: Theme.of(context).textTheme.displaySmall!
    //                           .copyWith(
    //                             fontSize: 14.sp,
    //                             fontWeight: FontWeight.w600,
    //                           ),
    //                     ),
    //                     Row(
    //                       children: [
    //                         Assets.images.pending.svg(),
    //                         9.horizontalSpace,
    //                         Text(
    //                           ordersState.approvedOrders[index].status
    //                               .toString(),
    //                           style: Theme.of(context).textTheme.displayMedium!
    //                               .copyWith(fontSize: 14.sp),
    //                         ),
    //                       ],
    //                     ),
    //                   ],
    //                 ),
    //                 8.verticalSpace,
    //                 Text(
    //                   ordersState.approvedOrders[index].serviceType,
    //                   style: Theme.of(context).textTheme.bodyMedium!.copyWith(
    //                     fontSize: 12.sp,
    //                     color: AppColors.greyText,
    //                     fontWeight: FontWeight.w500,
    //                   ),
    //                 ),
    //                 8.verticalSpace,
    //                 Row(
    //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                   children: [
    //                     Text(
    //                       ordersState.approvedOrders[index].postingDate,
    //                       style: Theme.of(context).textTheme.bodyMedium!
    //                           .copyWith(
    //                             fontSize: 12.sp,
    //                             color: AppColors.greyText,
    //                             fontWeight: FontWeight.w500,
    //                           ),
    //                     ),
    //                     Text(
    //                       "QR ${ordersState.approvedOrders[index].totalNetAmount}",
    //                       style: Theme.of(context).textTheme.displaySmall!
    //                           .copyWith(
    //                             fontSize: 12.sp,
    //                             color: AppColors.greenText,
    //                             fontWeight: FontWeight.w600,
    //                           ),
    //                     ),
    //                   ],
    //                 ),
    //               ],
    //             ),
    //           ),
    //         );
    //       },
    //     ),
    //   );
    // } else if (ordersState.approvedOrdersStates == RequestStates.error) {
    //   return AppErrorWidget(
    //     onTap: () => Future(
    //       () => ref
    //           .read(myOrdersControllerProvider.notifier)
    //           .fetchApprovedOrders(),
    //     ),
    //   );
    // }
    // return SizedBox.shrink();
  }
}
