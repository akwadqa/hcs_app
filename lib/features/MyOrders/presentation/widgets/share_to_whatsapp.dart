import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hcs/src/theme/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';

class ShareToWhatsApp extends StatelessWidget {
  final String message = "Hello, this is a message from my Flutter app!";

  const ShareToWhatsApp({super.key});

  void shareToWhatsApp() async {
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

void main() => runApp(MaterialApp(home: ShareToWhatsApp()));
