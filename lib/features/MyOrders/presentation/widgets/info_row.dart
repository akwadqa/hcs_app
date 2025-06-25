import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hcs/src/theme/app_colors.dart';

class InfoRow extends StatelessWidget {
  final String? title;
  final String? value;
  final Widget? widget;

  const InfoRow(this.title, {super.key, this.value, this.widget});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null)
            Expanded(
              flex: 3,
              child: Text(
                title!,
                style: Theme.of(context).textTheme.displayMedium!.copyWith(
                  color: AppColors.blueText,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          SizedBox(width: 16.w),
          Expanded(
            flex: 5,
            child:
                widget ??
                Text(
                  "$value",
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.displayMedium,
                ),
          ),
        ],
      ),
    );
  }
}
