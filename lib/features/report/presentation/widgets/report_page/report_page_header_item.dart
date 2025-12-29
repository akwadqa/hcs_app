
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hcs/src/extenssions/int_extenssion.dart';
import 'package:hcs/src/extenssions/widget_extensions.dart';

class ReportPageHeaderItem extends StatelessWidget {
  const ReportPageHeaderItem({
    super.key,
    required this.title,
    required this.value,
  });
  final String title, value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        4.verticalSpace,
    
        //? Title :
        Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.displayMedium!.copyWith(fontSize: 12.sp),
        ),
        4.verticalSpace,
    
        //? Value :
        Text(
          value,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium!.copyWith(fontSize: 18.sp),
        ),
      ],
    ).symmetricPadding(vertical: 8.h);
  }
}
