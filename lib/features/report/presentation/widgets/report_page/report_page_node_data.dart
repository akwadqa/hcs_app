import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hcs/features/report/domain/model/report_model.dart';
import 'package:hcs/src/extenssions/widget_extensions.dart';
import 'package:hcs/src/theme/app_colors.dart';
import 'package:intl/intl.dart';

class ReportPageNodeData extends StatelessWidget {
  const ReportPageNodeData({super.key, this.report});
  final ReportModel? report;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        16.horizontalSpace,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //? id :
            Text(
              // '6694',
              report?.serviceOrderId ?? 'id',
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: AppColors.blackText,
                fontSize: 14.sp,
              ),
            ),
            8.verticalSpace,

            //? type :
            Text(
              // '#14710',
              report?.serviceType ?? 'type',
              style: Theme.of(
                context,
              ).textTheme.bodySmall!.copyWith(color: AppColors.greyText),
            ),
            4.verticalSpace,

            //? status
            Text(
              // 'Online',
              report?.methodOfPayment ?? 'payment',
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: AppColors.primary,
                fontSize: 14.sp,
              ),
            ),
          ],
        ),
        Spacer(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //? QR :
            Text.rich(
              TextSpan(
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: AppColors.blackText,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp,
                ),
                children: [
                  TextSpan(text: ' + '),
                  TextSpan(text: report?.totalNetAmount.toString() ?? '0.0'),
                  TextSpan(text: context.tr('qr')),
                ],
              ),
            ),
            // Text(
            //   // '+ QR 130.0',
            //   '${context.tr('qr')} ${report?.totalNetAmount.toString() ?? '0.0'}',
            //   style: Theme.of(context).textTheme.bodySmall!.copyWith(
            //     color: AppColors.blackText,
            //     fontWeight: FontWeight.bold,
            //     fontSize: 16.sp,
            //   ),
            // ),

            //? date time :
            Text(
              // DateFormat('dd MMM yyyy').format(DateTime.now()),
              report?.postingDate ?? '00 MON Year',
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: AppColors.dividerGrey,
                fontSize: 12.sp,
              ),
            ),
          ],
        ),
      ],
    ).onlyPadding(bottom: 26.h);
  }
}
