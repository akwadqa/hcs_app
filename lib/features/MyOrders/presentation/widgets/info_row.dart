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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          title != null
              ? Text(
                  title!,
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
                    color: AppColors.blueText,
                    fontWeight: FontWeight.w600,
                  ),
                )
              : SizedBox.shrink(),
          SizedBox(
            width: 170.w,
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
