import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hcs/features/Auth/application/auth_service.dart';
import 'package:hcs/src/enums/service_type.dart';
import 'package:hcs/src/shared_widgets/custom_button.dart';
import 'package:hcs/src/manager/app_strings.dart';
import 'package:hcs/src/shared_widgets/custom_appbar.dart';

@RoutePage()
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppbar(
          serviceTypeTitle: ServiceType.settings,
          hasBackArrow: false,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 60.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 200.h),

              Consumer(
                builder: (context, ref, child) => CustomButton(
                  title: tr(context: context, AppStrings.letMeOut),
                  textSize: 26.sp,
                  onPressed: () {
                    ref.read(userDataProvider.notifier).removeData();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
