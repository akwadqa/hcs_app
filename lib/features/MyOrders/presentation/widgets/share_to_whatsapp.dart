import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hcs/features/MyOrders/domain/models/order_details/order_details_model.dart';
import 'package:hcs/src/theme/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';

class ShareToWhatsApp extends StatelessWidget {
  final String serviceOrderId;
  final OrderDetails? orderDetails;
  const ShareToWhatsApp({
    super.key,
    required this.serviceOrderId,
    required this.orderDetails,
  });

  // https://www.waze.com/ul?ll=${orderDetails?.customer?.locationUrl?.split('=').last}

  void shareToWhatsApp() async {
    final emplyeesName = orderDetails?.staffAppointment != null
        ? orderDetails!.staffAppointment!.join('\n')
        : '';

    final String message =
        '''
Booking Number: $serviceOrderId

Supervisor Name: ${orderDetails?.supervisor?.supervisorName}
${orderDetails?.customer?.customerName}
${orderDetails?.customer?.zone != null ? 'Zone ${orderDetails?.customer?.zone}, ${orderDetails?.customer?.location} \n' : ''}
Mobile: ${orderDetails?.customer?.phoneNumber}
${orderDetails?.customer?.locationUrl ?? ""}

Driver: ${orderDetails?.driver?.driverName}
Date: ${orderDetails?.date}
Service Type: ${orderDetails?.serviceType}

Shift Type: ${orderDetails?.shiftType}
Duration: ${orderDetails?.shiftType == "Full Day" ? "10 Hours" : "5 Hours"}
${orderDetails?.days != null ? 'Days: ${(orderDetails?.days as List?)?.join(', ')}' : ''}

${orderDetails?.staffAppointment != null ? 'Names of Cleaners: ${orderDetails!.staffAppointment!.length > 1 ? '\n' : ''}$emplyeesName' : ''}

Cleaning Material: ${orderDetails?.withCleaningSupplies == 0 ? 'NO' : "YES"}

${(orderDetails?.note != null && orderDetails?.note != "") ? "Note: ${orderDetails?.note}\n" : ""}
Order Amount : ${orderDetails?.totalNetAmount} QR By ${(orderDetails?.methodOfPayment == 'SkipCash') ? 'Skip Cash \n${orderDetails!.skipcashLink}' : 'Cash'}
''';
// ${orderDetails?.skipcashLink != null ? orderDetails!.skipcashLink : ''}
    // ${(orderDetails?.methodOfPayment == 'Cash') ? 'Payment collect by Cash QR ${orderDetails?.totalNetAmount}' : ''}

    // ${(orderDetails?.methodOfPayment == 'SkipCash') ? 'Skip Cash ${orderDetails!.skipcashLink}' : ''}
    // Payment collect by ${orderDetails?.methodOfPayment} QR ${orderDetails?.totalNetAmount}

    final waScheme = Uri.parse(
      'whatsapp://send?text=${Uri.encodeComponent(message)}',
    );
    final waWeb = Uri.parse(
      'https://wa.me/?text=${Uri.encodeComponent(message)}',
    );
    print('-------------------');
    print(orderDetails?.staffAppointment?.length ?? 'link');
    print('-------------------');

    // Try the WhatsApp app first
    final launched = await launchUrl(
      waScheme,
      mode: LaunchMode.externalApplication,
    ).catchError((_) => false);

    if (launched == true) return;

    // Fallback to web (needs a browser)
    final webLaunched = await launchUrl(
      waWeb,
      mode: LaunchMode.externalApplication,
    ).catchError((_) => false);

    if (webLaunched != true) {
      debugPrint('No app/browser available to handle WhatsApp link');
      // Show a snackbar/toast to the user if you want
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: shareToWhatsApp,
      icon: Icon(Icons.share, size: 20.sp, color: AppColors.blueText),
    );
  }
}
