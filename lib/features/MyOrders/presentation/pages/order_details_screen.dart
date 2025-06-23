import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hcs/features/MyOrders/presentation/widgets/info_row.dart';
import 'package:hcs/src/manager/app_strings.dart';
import 'package:hcs/src/shared_widgets/custom_appbar.dart';
import 'package:hcs/src/theme/app_colors.dart';

@RoutePage()
class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        hasBackArrow: true,
        title: context.tr(AppStrings.orderDetails),
        withTabs: false,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 17.h, horizontal: 26.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                "Booking Number 4522",
                style: Theme.of(context).textTheme.displayMedium!.copyWith(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.blueTitle,
                ),
              ),
            ),
            16.verticalSpace,

            // --- Info Rows ---
            InfoRow("Customer", value: "Mohamed"),
            InfoRow("Area", value: "Qatar - Doha"),
            InfoRow("Zone", value: "Doha....."),
            InfoRow(
              "Location",
              url: "https://www.google.com/maps/@?api=1&map_action=map",
            ),

            Padding(
              padding: EdgeInsets.symmetric(vertical: 24.h),
              child: Divider(height: 0.1, color: AppColors.dividerGrey),
            ),

            InfoRow("Service type", value: "On Call"),
            InfoRow("Shift type", value: "Full day"),
            InfoRow("Date", value: "30-05-2025"),
            InfoRow("Service Category", value: "On Call"),

            Padding(
              padding: EdgeInsets.symmetric(vertical: 24.h),
              child: Divider(height: 0.1, color: AppColors.dividerGrey),
            ),

            InfoRow("Employee name", value: "Mari, Judy"),
            InfoRow("Driver name", value: "Harry Dived"),

            Padding(
              padding: EdgeInsets.symmetric(vertical: 24.h),
              child: Divider(height: 0.1, color: AppColors.dividerGrey),
            ),

            InfoRow("Discount Type", value: "MAZAYA Card"),
            InfoRow("Discount Percentage", value: "10%"),
            InfoRow("Payment Method", value: "Online"),

            Padding(
              padding: EdgeInsets.symmetric(vertical: 24.h),
              child: Divider(height: 0.1, color: AppColors.dividerGrey),
            ),

            InfoRow("Cleaning supply", value: "No"),

            24.verticalSpace,
            Center(
              child: Text(
                "QR 500",
                style: TextStyle(
                  fontSize: 20.sp,
                  color: AppColors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
