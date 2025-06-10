import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hcs/gen/assets.gen.dart';
import 'package:hcs/src/theme/app_colors.dart';

class ServiceCard extends StatelessWidget {
  final String? title;
  const ServiceCard({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 342.w,
      height: 150.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        // gradient: AppColors.serviceCardGradient,
        image: DecorationImage(
          image: AssetImage(Assets.images.dummycard.path),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        width: 342.w,
        height: 150.h,
        alignment: Alignment.bottomCenter,
        padding: EdgeInsets.only(
          top: 85.h,
          bottom: 15.h,
          left: 50.w,
          right: 50.w,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          gradient: AppColors.serviceCardGradient,
        ),
        child: title != null
            ? Text(
                title!,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displayLarge!.copyWith(
                  fontSize: 32.sp,
                  fontWeight: FontWeight.w700,
                ),
              )
            : SizedBox.shrink(),
      ),
    );
  }
}
