import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hcs/features/report/domain/model/report_model.dart';
import 'package:hcs/features/report/presentation/widgets/report_page/report_page_node_data.dart';
import 'package:hcs/src/extenssions/widget_extensions.dart';
import 'package:hcs/src/theme/app_colors.dart';
import 'package:timeline_tile/timeline_tile.dart';

class ReportNodeTile extends StatelessWidget {
  const ReportNodeTile({
    super.key,
    required this.isFirst,
    required this.isLast,
    required this.report,
  });
  final ReportModel? report;
  final bool isFirst, isLast;

  //? For first item in list :
  factory ReportNodeTile.first(ReportModel? report) =>
      ReportNodeTile(isFirst: true, isLast: false, report: report);

  //? For normal item :
  factory ReportNodeTile.middle(ReportModel? report) =>
      ReportNodeTile(isFirst: false, isLast: false, report: report);

  //? For last item :
  factory ReportNodeTile.last(ReportModel? report) =>
      ReportNodeTile(isFirst: false, isLast: true, report: report);

  @override
  Widget build(BuildContext context) {
    return TimelineTile(
      //? Data widget :
      endChild: ReportPageNodeData(report: report),
      isFirst: isFirst,
      isLast: isLast,
      beforeLineStyle: LineStyle(thickness: 2.w, color: AppColors.gray02),
      afterLineStyle: LineStyle(thickness: 2.w, color: AppColors.gray02),
      indicatorStyle: IndicatorStyle(
        width: 10.w,
        color: AppColors.primary,
        indicatorXY: 0,
      ),
    ).symmetricPadding(horizontal: 8.w);
  }
}
