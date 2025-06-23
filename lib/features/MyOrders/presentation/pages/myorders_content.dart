import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hcs/gen/assets.gen.dart';
import 'package:hcs/src/manager/app_strings.dart';
import 'package:hcs/src/routing/app_router.gr.dart';
import 'package:hcs/src/shared_widgets/custom_appbar.dart';
import 'package:hcs/src/theme/app_colors.dart';

@RoutePage()
class MyOrdersContentScreen extends ConsumerStatefulWidget {
  const MyOrdersContentScreen({super.key});

  @override
  ConsumerState<MyOrdersContentScreen> createState() => _MyOrdersContentState();
}

class _MyOrdersContentState extends ConsumerState<MyOrdersContentScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        hasBackArrow: false,
        title: context.tr(AppStrings.myOrders),
        withTabs: true,
        tabController: _tabController,
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          ListView.builder(
            shrinkWrap: true,
            itemCount: 4,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  context.pushRoute(OrderDetailsRoute());
                },
                child: Container(
                  margin: EdgeInsets.symmetric(
                    vertical: 16.h,
                    horizontal: 24.w,
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: 13.h,
                    horizontal: 22.w,
                  ),
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
                            'No. 4522',
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
                                'Pending',
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium!
                                    .copyWith(fontSize: 14.sp),
                              ),
                            ],
                          ),
                        ],
                      ),
                      8.verticalSpace,
                      Text(
                        'On Call',
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
                            '20-05-2025',
                            style: Theme.of(context).textTheme.bodyMedium!
                                .copyWith(
                                  fontSize: 12.sp,
                                  color: AppColors.greyText,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                          Text(
                            'QR 250',
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
          Center(child: Text('Pending')),
          Center(child: Text('Canceled')),
        ],
      ),
    );
  }
}
