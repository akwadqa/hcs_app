import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hcs/src/theme/app_colors.dart';

class InfoRow extends StatelessWidget {
  final String? title;
  final String? value;
  final String? url;
  const InfoRow(this.title, {super.key, this.value, this.url});

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
            child: url != null
                ? InkWell(
                    child: Text(
                      url!,
                      style: TextStyle(
                        fontFamily: 'Instrument Sans',
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                        height: 1.0, // 100% line-height
                        letterSpacing: 0,
                        decoration: TextDecoration.underline,
                        decorationStyle: TextDecorationStyle.solid,
                        decorationColor: AppColors.blueTitle, // optional
                      ),
                    ),
                    onTap: () {},
                  )
                : value != null
                ? Text(
                    value!,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.displayMedium,
                  )
                : SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
