import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hcs/features/MyOrders/presentation/controllers/myorders_controller.dart';
import 'package:hcs/gen/assets.gen.dart';
import 'package:hcs/src/enums/request_state.dart';
import 'package:hcs/src/routing/app_router.gr.dart';
import 'package:hcs/src/shared_widgets/app_error_widget.dart';
import 'package:hcs/src/theme/app_colors.dart';
import 'package:hcs/src/shared_widgets/fade_circle_loading_indicator.dart';

class PendingOrdersScreen extends ConsumerStatefulWidget {
  const PendingOrdersScreen({super.key});
  @override
  ConsumerState<PendingOrdersScreen> createState() =>
      _PendingOrdersScreenState();
}

class _PendingOrdersScreenState extends ConsumerState<PendingOrdersScreen> {
  late ScrollController _scrollController;
  Timer? _loadMoreTimer;

  @override
  void initState() {
    super.initState();
    Future(
      () => ref
          .read(myOrdersControllerProvider.notifier)
          .fetchServicesOrders(ordersStatus: 'Pending'),
    );

    _scrollController = ScrollController()..addListener(_onScroll);
  }

  _onScroll() {
    final customerState = ref.read(myOrdersControllerProvider);
    final hasMore = customerState.currentServicesOrdersPage != null;

    if (_scrollController.position.pixels >
            _scrollController.position.maxScrollExtent - 100 &&
        hasMore) {
      _loadMoreTimer?.cancel();
      _loadMoreTimer = Timer(const Duration(milliseconds: 500), () {
        ref
            .read(myOrdersControllerProvider.notifier)
            .onLoadMoreServicesOrders(ordersStatus: 'Pending');
      });
    }
  }

  @override
  void dispose() {
    _loadMoreTimer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var ordersState = ref.watch(myOrdersControllerProvider);

    if (ordersState.ordersStates == RequestStates.init ||
        ordersState.ordersStates == RequestStates.loading) {
      return Center(child: FadeCircleLoadingIndicator());
    } else if (ordersState.ordersStates == RequestStates.loaded) {
      if (ordersState.orders.isEmpty) {
        return Assets.images.noDataMin.image();
      }
      return RefreshIndicator(
        onRefresh: () async {
          await ref
              .read(myOrdersControllerProvider.notifier)
              .fetchServicesOrders(ordersStatus: 'Pending');
        },
        child: ListView.builder(
          controller: _scrollController,
          shrinkWrap: true,
          itemCount: ordersState.orders.length + 1,
          itemBuilder: (context, index) {
            if (index >= ordersState.orders.length) {
              if (ordersState.currentServicesOrdersPage == null) {
                return Center(
                  child: Text(
                    'No More Orders',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                );
              } else {
                return const Padding(
                  padding: EdgeInsets.all(8),
                  child: Center(child: FadeCircleLoadingIndicator()),
                );
              }
            }
            return GestureDetector(
              onTap: () {
                context.pushRoute(
                  OrderDetailsRoute(
                    serviceOrderID: ordersState.orders[index].serviceOrderId,
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
                          ordersState.orders[index].serviceOrderId,
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
                              ordersState.orders[index].status.toString(),
                              style: Theme.of(context).textTheme.displayMedium!
                                  .copyWith(fontSize: 14.sp),
                            ),
                          ],
                        ),
                      ],
                    ),
                    8.verticalSpace,
                    Text(
                      ordersState.orders[index].serviceType,
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
                          ordersState.orders[index].postingDate,
                          style: Theme.of(context).textTheme.bodyMedium!
                              .copyWith(
                                fontSize: 12.sp,
                                color: AppColors.greyText,
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                        Text(
                          "QR ${ordersState.orders[index].totalNetAmount}",
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
    } else if (ordersState.ordersStates == RequestStates.error) {
      return AppErrorWidget(
        onTap: () => Future(
          () => ref
              .read(myOrdersControllerProvider.notifier)
              .fetchServicesOrders(ordersStatus: 'Pending'),
        ),
      );
    }
    return SizedBox.shrink();
  }
}
