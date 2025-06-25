import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hcs/features/MyOrders/data/models/orders_details_model.dart';
import 'package:hcs/features/MyOrders/data/models/services_orders_model.dart';
import 'package:hcs/src/theme/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';

class ShareToWhatsApp extends StatelessWidget {
  final String serviceOrderId;
  final Details? orderDetails;
  const ShareToWhatsApp({
    super.key,
    required this.serviceOrderId,
    required this.orderDetails,
  });

  void shareToWhatsApp() async {
    final String message =
        '''
📌 Booking Details

🔢 Booking Number: $serviceOrderId
📍 Address: Zone ${orderDetails?.customer?.zone},
🗺️ Location Link:
- Google Maps: ${orderDetails?.customer?.locationUrl}
📅 Date: ${orderDetails?.date}
🧴 Cleaning Material: ${orderDetails?.withCleaningSupplies == 0 ? 'No' : "Yes"}

💵 Payment: Cash, QR ${orderDetails?.totalNetAmount}

''';

    final url = Uri.parse(
      "https://wa.me/?text=${Uri.encodeComponent(message)}",
    );

    if (await canLaunchUrl(url)) {
      try {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      } catch (e) {
        debugPrint("Error launching WhatsApp: $e");
      }
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
