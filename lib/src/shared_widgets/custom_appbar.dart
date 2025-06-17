import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hcs/features/Home/Availability/presentation/controllers/availability_controller.dart';
import 'package:hcs/src/enums/service_type.dart';
import 'package:hcs/src/shared_widgets/custom_back_arrow_widget.dart';
import 'package:hcs/gen/assets.gen.dart'; // for your SVG assets
import 'package:hcs/src/theme/app_colors.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  /// If true, shows [CustomBackArrowWidget] in the leading slot
  final bool hasBackArrow;

  /// If true, shows the home‐style title row: [logo + title], and hides leading/actions
  final bool isHome;

  /// Optional list of action widgets (e.g. icons/buttons) to show
  final List<Widget>? actions;

  const CustomAppbar({
    super.key,
    this.hasBackArrow = false,
    this.isHome = false,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // only show back arrow if requested, and not on home
      leading: isHome
          ? null
          : hasBackArrow
          ? const CustomBackArrowWidget()
          : null,
      // centerTitle must be true to keep our custom title centered
      centerTitle: true,
      backgroundColor: AppColors.white,
      elevation: 0,

      // if home: show logo + title; else just the text title
      title: Consumer(
        builder: (context, ref, child) {
          var selectedServiceTypeState = ref.watch(
            availabilityControllerProvider.select(
              (value) => value.selectedServiceType,
            ),
          );
          return isHome
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

      // only show actions if NOT home
      actions: isHome ? null : actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
