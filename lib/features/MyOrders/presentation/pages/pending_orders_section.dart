import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hcs/features/MyOrders/domain/models/services_order/services_order_model.dart';
import 'package:hcs/features/MyOrders/presentation/controllers/myorders_controller.dart';
import 'package:hcs/features/MyOrders/presentation/controllers/pending_orders_controller.dart';
import 'package:hcs/gen/assets.gen.dart';
import 'package:hcs/src/enums/request_state.dart';
import 'package:hcs/src/routing/app_router.gr.dart';
import 'package:hcs/src/shared_widgets/app_error_widget.dart';
import 'package:hcs/src/shared_widgets/app_pagination_widget.dart';
import 'package:hcs/src/theme/app_colors.dart';
import 'package:hcs/src/shared_widgets/fade_circle_loading_indicator.dart';

class PendingOrdersScreen extends ConsumerStatefulWidget {
  const PendingOrdersScreen({super.key});
  @override
  ConsumerState<PendingOrdersScreen> createState() =>
      _PendingOrdersScreenState();
}

class _PendingOrdersScreenState extends ConsumerState<PendingOrdersScreen> {
  // const PendingOrdersScreen({super.key});

  @override
  void initState() {
    super.initState();
    Future(
      () => ref
          .read(pendingOrdersControllerProvider.notifier)
          .fetchPendingOrders(page: 1),
    );
  }

  // late ScrollController _scrollController;
  // Timer? _loadMoreTimer;

  // @override
  // void initState() {
  //   super.initState();
  //   Future(
  //     () => ref.read(myOrdersControllerProvider.notifier).fetchPendingOrders(),
  //   );

  //   _scrollController = ScrollController()..addListener(_onScroll);
  // }

  // _onScroll() {
  //   final customerState = ref.read(myOrdersControllerProvider);
  //   final hasMore = customerState.currentPendingOrdersPage != null;

  //   if (_scrollController.position.pixels >
  //           _scrollController.position.maxScrollExtent - 100 &&
  //       hasMore) {
  //     _loadMoreTimer?.cancel();
  //     _loadMoreTimer = Timer(const Duration(milliseconds: 500), () {
  //       ref.read(myOrdersControllerProvider.notifier).onLoadMorePendingOrders();
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
        return ref
            .read(pendingOrdersControllerProvider.notifier)
            .refreshPending();
      },
      onLoading: (page) {
        return ref
            .read(pendingOrdersControllerProvider.notifier)
            .onLoadMorePendingOrders();
      },
      child: ListView.builder(
        physics: AlwaysScrollableScrollPhysics(),
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
                            orders[index].status.toString(),
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
    final controller = ref.watch(pendingOrdersControllerProvider);
    return controller.when(
      error: (e, st) => AppErrorWidget(
        onTap: () {
          ref
              .read(pendingOrdersControllerProvider.notifier)
              .fetchPendingOrders(page: 1);
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
                  .read(pendingOrdersControllerProvider.notifier)
                  .fetchPendingOrders(page: 1);
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

    // var ordersState = ref.watch(myOrdersControllerProvider);

    // if (ordersState.pendingOrdersStates == RequestStates.init ||
    //     ordersState.pendingOrdersStates == RequestStates.loading) {
    //   return Center(child: FadeCircleLoadingIndicator());
    // } else if (ordersState.pendingOrdersStates == RequestStates.loaded) {
    //   if (ordersState.pendingOrders.isEmpty) {
    //     return RefreshIndicator(
    //       onRefresh: () async {
    //         await ref
    //             .read(myOrdersControllerProvider.notifier)
    //             .fetchPendingOrders();
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
    //           .fetchPendingOrders();
    //     },
    //     child: ListView.builder(
    //       controller: _scrollController,
    //       physics: AlwaysScrollableScrollPhysics(),
    //       shrinkWrap: true,
    //       itemCount: ordersState.pendingOrders.length + 1,
    //       itemBuilder: (context, index) {
    //         if (index >= ordersState.pendingOrders.length) {
    //           if (ordersState.currentPendingOrdersPage == null) {
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
    //                     ordersState.pendingOrders[index].serviceOrderId ?? 'bb',
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
    //                       ordersState.pendingOrders[index].serviceOrderId ??
    //                           'bb',
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
    //                           ordersState.pendingOrders[index].status
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
    //                   ordersState.pendingOrders[index].serviceType,
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
    //                       ordersState.pendingOrders[index].postingDate,
    //                       style: Theme.of(context).textTheme.bodyMedium!
    //                           .copyWith(
    //                             fontSize: 12.sp,
    //                             color: AppColors.greyText,
    //                             fontWeight: FontWeight.w500,
    //                           ),
    //                     ),
    //                     Text(
    //                       "QR ${ordersState.pendingOrders[index].totalNetAmount}",
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
    // } else if (ordersState.pendingOrdersStates == RequestStates.error) {
    //   return AppErrorWidget(
    //     onTap: () => Future(
    //       () => ref
    //           .read(myOrdersControllerProvider.notifier)
    //           .fetchPendingOrders(),
    //     ),
    //   );
    // }
    // return SizedBox.shrink();
  }
}
