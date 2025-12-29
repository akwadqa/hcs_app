import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hcs/features/Auth/application/auth_service.dart';
import 'package:hcs/features/Home/Availability/presentation/controllers/availability_controller.dart';
import 'package:hcs/src/enums/service_type.dart';
import 'package:hcs/src/shared_widgets/custom_back_arrow_widget.dart';
import 'package:hcs/gen/assets.gen.dart'; // for your SVG assets
import 'package:hcs/src/theme/app_colors.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final bool hasBackArrow;
  final bool isHome;
  final bool withouTitle;
  final bool withTabs;
  final String? title;
  final List<Widget>? actions;
  final TabController? tabController;
  final ValueChanged<int>? onTabTap;

  const CustomAppbar({
    super.key,
    this.hasBackArrow = false,
    this.isHome = false,
    this.withTabs = false,
    this.withouTitle = false,
    this.actions,
    this.title,
    this.tabController,
    this.onTabTap,

  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      key: UniqueKey(),
      leading: isHome
          ? null
          : hasBackArrow
          ? const CustomBackArrowWidget()
          : null,
      centerTitle: true,
      backgroundColor: AppColors.white,
      elevation: 0,
      bottom: withTabs && tabController != null
          ? PreferredSize(
              preferredSize: Size.fromHeight(48.h),
              child: Container(
                color: AppColors.tabBarColor,
                child: TabBar(
                  controller: tabController,
                  labelColor: AppColors.blueTitle,
                  unselectedLabelColor: AppColors.greyText,
                  indicatorColor: AppColors.blueTitle,
                  onTap: onTabTap,
                  labelStyle: Theme.of(context).textTheme.displayMedium,
                  unselectedLabelStyle: Theme.of(
                    context,
                  ).textTheme.displayMedium,
                  tabs: const [
                    Tab(
                      icon: SizedBox(
                        child: Icon(
                          Icons.date_range_outlined,
                          color: AppColors.primary,
                        ),
                      ),
                    ),

                    //? Dont forget it :
                    // Tab(text: 'Yesterday'),
                    Tab(text: 'Today'),
                    Tab(text: 'Tomorrow'),
                  ],
                  // tabs: const [
                  //   Tab(text: 'Accept'),
                  //   Tab(text: 'Pending'),
                  //   Tab(text: 'Cancelled'),
                  // ],
                ),
              ),
            )
          : null,

      title: Consumer(
        builder: (context, ref, child) {
          final user = ref.watch(userDataProvider);

          var selectedServiceTypeState = ref.watch(
            availabilityControllerProvider.select(
              (value) => value.selectedServiceType,
            ),
          );
          return withouTitle
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.person, color: AppColors.blueTitle),

                        10.horizontalSpace,
                        Text(
                          user?.$2 ?? "supervisor",
                          style: Theme.of(context).textTheme.displaySmall!
                              .copyWith(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ],
                    ),
                    if (isHome) ...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        // mainAxisSize: MainAxisSize.min,
                        children: [
                          Assets.images.logo.image(
                            height: 50.h,
                            width: 70.w,
                            fit: BoxFit.fitWidth,
                          ),
                          // SizedBox(width: 8.w),
                          // Text(
                          //   "${serviceTypeToString(ServiceType.home)} Service",
                          //   style: Theme.of(context).textTheme.displaySmall!.copyWith(
                          //     fontSize: 12.sp,
                          //     fontWeight: FontWeight.w600,
                          //   ),
                          // ),
                        ],
                      ),
                      100.horizontalSpace,
                    ],
                  ],
                )
              : title != null
              ? Text(
                  title!,
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                )
              : isHome
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Assets.images.logo.image(
                      height: 50.h,
                      width: 70.w,
                      fit: BoxFit.fitWidth,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      "${serviceTypeToString(ServiceType.home)} Service",
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                )
              : Text(
                  "$selectedServiceTypeState Service",
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                );
        },
      ),
      actions: isHome ? null : actions,
      actionsPadding: EdgeInsets.symmetric(horizontal: 31.w),
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(withTabs ? kToolbarHeight + 48 : kToolbarHeight);
}
