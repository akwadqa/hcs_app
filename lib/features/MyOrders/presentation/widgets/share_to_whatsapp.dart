import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hcs/features/MyOrders/data/models/services_orders_model.dart';
import 'package:hcs/src/theme/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';

class ShareToWhatsApp extends StatelessWidget {
  final Orders order;
  const ShareToWhatsApp({super.key, required this.order});

  void shareToWhatsApp() async {
    final String message =
        '''
📌 Booking Details

🔢 Booking Number: 5665

👤 Samehmaarouf  
📍 Address: Zone 22, Street 918, Building 18  
📱 Mobile: 66400990

🗺️ Location Links:
- Waze: https://www.waze.com/ul?ll=25.28548150929512,51.51493348181247
- Google Maps: https://maps.google.com/?q=25.28548150929512,51.51493348181247

📅 Date: ${order.postingDate}
⏰ Time: 08:30 AM to 09:00 AM  
⏳ Duration: 5 Hours  
🧹 Cleaners: 1  
🧴 Cleaning Material: NO

💵 Payment: Cash, QR ${order.totalNetAmount}

🔗 Booking Link:  
https://admin.aldobi.com/homecleaning/hc-store/order/start/5665
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
