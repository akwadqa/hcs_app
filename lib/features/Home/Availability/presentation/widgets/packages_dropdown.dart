import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hcs/features/Home/Customer/presentation/widgets/drop_down_textfield.dart';
import 'package:hcs/src/manager/app_strings.dart';

class PackagesDropdown extends StatelessWidget {
  const PackagesDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Text(
          context.tr(AppStrings.packages),
          style: Theme.of(context).textTheme.displayMedium!,
        ),
        8.verticalSpace,
        DropDownField(
          enabled: true,
          items: ['8- Visit /month', '4- Visit /month'],
        ),
      ],
    );
  }
}
