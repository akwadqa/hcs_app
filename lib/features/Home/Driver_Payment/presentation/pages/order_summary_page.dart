import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hcs/features/Home/Employees/data/models/order_summary.dart';
import 'package:hcs/src/extenssions/int_extenssion.dart';
import 'package:hcs/src/extenssions/widget_extensions.dart';
import 'package:hcs/src/routing/app_router.gr.dart';
import 'package:hcs/src/shared_widgets/custom_appbar.dart';
import 'package:hcs/src/theme/app_colors.dart';

@RoutePage()
class OrderSummaryPage extends StatelessWidget {
  final OrderSummary order;

  const OrderSummaryPage({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color(0xffF3F5F9),
      appBar: CustomAppbar(title: "Order Summary", hasBackArrow: true),
      //  AppBar(
      //   backgroundColor: Colors.white,
      //   elevation: 0,
      //   title: const Text(
      //     "Order Summary",
      //     style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
      //   ),
      // ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ...order.visits.map(
            (visit) => Container(
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Service Category",
                          style: Theme.of(context).textTheme.bodyLarge!
                              .copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w800,
                                fontSize: 14,
                              ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: Color(0xffE8EEF9),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            "Visit : ${visit.visitNumber}",
                            style: Theme.of(context).textTheme.displayMedium!
                                .copyWith(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                          ),
                        ),
                      ],
                    ),
                    6.verticalSpace,
                    Text(
                      visit.serviceCategory,
                      // order.serviceType,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: AppColors.grayishCharcoal,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),

                    10.verticalSpace,
                    const Divider(height: 8, color: AppColors.primary),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Shift Type",
                          style: Theme.of(context).textTheme.bodyLarge!
                              .copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w800,
                                fontSize: 15,
                              ),
                        ),
                        Text(
                          DateFormat('E, dd-MM-yyyy').format(visit.date),
                          style: Theme.of(context).textTheme.bodyLarge!
                              .copyWith(
                                color: AppColors.grayishCharcoal,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 6),

                    Text(
                      order.shiftType.startsWith("Part")
                          ? "${order.shiftType} - ${visit.shiftType}"
                          : visit.shiftType,

                      // visit.shiftType,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: AppColors.grayishCharcoal,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),

                    12.verticalSpace,

                    Text(
                      "Employees",
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w800,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 6),

                    ...visit.employees.map(
                      (e) => Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Text(
                          e.employeeName,
                          style: Theme.of(context).textTheme.displayMedium!
                              .copyWith(
                                color: AppColors.blackText,
                                fontSize: 14,
                              ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        color: Colors.white,
        child: SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              context.pushRoute(DriverPaymentRoute());
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xff4A6FA5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              "Submit Order",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
