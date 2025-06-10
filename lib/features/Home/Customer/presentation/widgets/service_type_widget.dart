import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hcs/src/manager/app_strings.dart';

class ServiceTypeMenu extends StatelessWidget {
  const ServiceTypeMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Text(
          context.tr(AppStrings.serviceType),
          style: Theme.of(context).textTheme.displayMedium!,
        ),
        8.verticalSpace,
        // DropDownField(enabled: false),
      ],
    );
  }
}
