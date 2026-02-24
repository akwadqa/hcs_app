import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hcs/features/MyOrders/domain/models/appointment/appoitnment_model.dart';
import 'package:hcs/features/MyOrders/presentation/controllers/myorders_controller.dart';
import 'package:hcs/gen/assets.gen.dart';
import 'package:hcs/src/theme/app_colors.dart';

import '../controllers/order_details_controller.dart';
import 'share_to_whatsapp.dart';

class AppointmentCard extends ConsumerWidget {
  final Appointment appointmentData;
  final String serviceOrderID;
  // final Details? orderDetailstData;
  // final String logId;
  // final String logStatus;
  // final String orderId;
  // final String driverStatus;
  // final String servicetype;
  // final String date;
  // final String employeeName;
  const AppointmentCard({
    super.key,
    required this.appointmentData,
    required this.serviceOrderID,
    // required this.orderDetailstData,
    // required this.logId,
    // required this.logStatus,
    // required this.orderId,
    // required this.driverStatus,
    // required this.servicetype,
    // required this.date,
    // required this.employeeName,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncAppointmentData = ref.read(myOrdersControllerProvider);
        final controller = ref.watch(orderDetailsControllerProvider);

    return Stack(
      children: [
        InkWell(
onTap: () {
  debugPrint(controller.value!.supervisor?.supervisorName??"");
},
          child: Card(
            color: Colors.white,
            shadowColor: Colors.transparent,
            elevation: 0,
            margin: EdgeInsets.symmetric(vertical: 18.h, horizontal: 24.w),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 18.w),
              child: Column(
                children: [
                  if (appointmentData.logStatus == "Cancelled")
                    Chip(
                      label: Text(
                        "Canceled",
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      backgroundColor: Colors.red.shade50,
                      padding: EdgeInsets.symmetric(horizontal: 6.w),
                    ),
          
                  //? for the id :
                  // AppoinmentInfoRow(
                  //   'Order Number:',
                  //   value: appointmentData.logId,
                  //   image: Assets.images.numberVector.path,
                  // ),
                  AppoinmentInfoRow(
                    'Driver Status:',
                    value: appointmentData.driverStatus,
                    image: Assets.images.driverStatus.path,
                  ),
                  AppoinmentInfoRow(
                    'Service type:',
                    value: appointmentData.serviceType,
                    image: Assets.images.serviceType.path,
                  ),
                  AppoinmentInfoRow(
                    'Date:',
                    value: appointmentData.date,
                    image: Assets.images.date.path,
                  ),
                  AppoinmentInfoRow(
                    'Employee Name:',
                    value: appointmentData.employeeName,
                    image: Assets.images.employeeName.path,
                  ),
                  AppoinmentInfoRow(
                    'supervisor Name:',
                    value: appointmentData.supervisorName,
                    image: Assets.images.employeeName.path,
                  ),
                ],
              ),
            ),
          ),
        ),

        PositionedDirectional(
          end: 30,
          top: 20,
          child: ShareToWhatsApp(
            serviceOrderId: serviceOrderID,
            orderDetails: controller.value,
            appointment: appointmentData,
          ),
        ),
        // PositionedDirectional(
        //   start: 12,
        //   top: 12,
        //   child: InkWell(
        //     onTap: () async{
        //           await    showAcceptCancelOrder(context, orderNumber, true, ref);

        //     },
        //     child: Container(
        //       height: 25,
        //       width: 25,
        //       decoration: BoxDecoration(
        //         shape: BoxShape.circle,
        //         color: Colors.red,
        //       ),

        //       child: Icon(Icons.close, color: Colors.white),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}

class AppoinmentInfoRow extends StatelessWidget {
  final String? title;
  final String? value;
  final Widget? widget;
  final String image;

  const AppoinmentInfoRow(
    this.title, {
    super.key,
    this.value,
    this.widget,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return value != null
        ? Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (title != null)
                  Expanded(
                    flex: 3,
                    child: Row(
                      children: [
                        SizedBox(
                          height: 15.sp,
                          width: 15.sp,
                          child: SvgPicture.asset(
                            image,
                            height: 15.sp,
                            width: 15.sp,
                          ),

                          //  image?.svg(
                          //   fit: BoxFit.contain,
                          //   width: 15.sp,
                          //   height: 15.sp,
                          // ),
                        ),
                        11.horizontalSpace,
                        Text(
                          title!,
                          softWrap: true,
                          style: Theme.of(
                            context,
                          ).textTheme.displayMedium!.copyWith(fontSize: 14.sp),
                        ),
                      ],
                    ),
                  ),
                SizedBox(width: 16.w),
                Expanded(
                  flex: 2,
                  child:
                      widget ??
                      Text(
                        "$value",
                        softWrap: true,
                        style: Theme.of(context).textTheme.displayMedium!
                            .copyWith(
                              fontSize: 12.sp,
                              color: AppColors.greyText,
                            ),
                      ),
                ),
              ],
            ),
          )
        : SizedBox();
  }
}
