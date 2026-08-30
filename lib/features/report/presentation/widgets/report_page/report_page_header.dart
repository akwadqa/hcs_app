import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hcs/features/report/domain/model/report_model.dart';
import 'package:hcs/features/report/presentation/widgets/report_page/report_page_header_item.dart';
import 'package:hcs/src/theme/app_colors.dart';

class ReportPageHeader extends StatelessWidget {
  const ReportPageHeader({super.key, required this.report});

  final OrdersReport? report;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      
      children: [
        //? Total amount :
        ReportPageHeaderItem(
          title: context.tr('totalAmount'),
          value:
              '${report?.total.totalNetAmount.toString() ?? '0.0'} ${context.tr('qr')} ',
          
        ),

        Container(width: 1.w, height: 70.h, color: AppColors.dividerGrey),

        //? Total paid amount :
        ReportPageHeaderItem(
          title: context.tr('totalPaidAmount'),
          value: 
              '${report?.total.totalReceivedAmount.toString() ?? '0.0'} ${context.tr('qr')} ',

        ),

        Container(width: 1.w, height: 70.h, color: AppColors.dividerGrey),

        //? Outstanding amount :
        ReportPageHeaderItem(
          title: context.tr('outstandingAmount'),
          // value: '+ QR 0.0',
          value:
              '${report?.total.totalOutstandingAmount.toString() ?? '0.0'} ${context.tr('qr')} ',
        ),
      ],
    );
  }
}
