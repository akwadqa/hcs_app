import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hcs/src/manager/font_family.dart';
import 'package:hcs/src/theme/app_colors.dart';
import 'package:hcs/src/theme/app_sizes.dart';

class CustomButton extends ElevatedButton {
  CustomButton({
    super.key,
    required String title,
    required void Function()? onPressed,
    double? textSize,
    WidgetStateProperty<Size?>? fixedSize,
  }) : super(
         onPressed: onPressed,
         style: ElevatedButton.styleFrom(
           backgroundColor: AppColors.primary,
           fixedSize:
               fixedSize?.resolve({}) ??
               Size(AppSizes.authButtonWidth.w, AppSizes.authButtonHeight.h),
           shadowColor: Colors.transparent,
         ),
         child: Text(
           title,
           style: TextStyle(
             fontSize: textSize ?? 16.sp,
             fontWeight: FontWeight.w700,
             color: AppColors.white,
             fontFamily: FontFamily.instrumentSan,
           ),
         ),
       );
}
