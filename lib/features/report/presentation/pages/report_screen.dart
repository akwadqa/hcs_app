import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hcs/features/report/domain/model/report_model.dart';
import 'package:hcs/features/report/presentation/controller/report_controller.dart';
import 'package:hcs/features/report/presentation/widgets/report_page/report_node_tile.dart';
import 'package:hcs/features/report/presentation/widgets/report_page/report_page_header.dart';
import 'package:hcs/src/extenssions/widget_extensions.dart';
import 'package:hcs/src/shared_widgets/app_error_widget.dart';
import 'package:hcs/src/shared_widgets/app_pagination_widget.dart';
import 'package:hcs/src/shared_widgets/custom_appbar.dart';
import 'package:hcs/src/shared_widgets/fade_circle_loading_indicator.dart';
import 'package:hcs/src/theme/app_colors.dart';

@RoutePage()
class ReportScreen extends ConsumerWidget {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(reportControllerProvider);

    return Scaffold(
      appBar: CustomAppbar(title: context.tr('Reports'), hasBackArrow: true),
      body: controller.when(
        loading: () => Center(child: FadeCircleLoadingIndicator()),
        data: (data) {
          if (data != null) {
            return _buildBody(context, data, ref);
          } else{
            return  AppErrorWidget(
            onTap: () {
              ref.read(reportControllerProvider.notifier).getReport(page: 1);
            },
          );
          }
        },
        error: (Object error, StackTrace stackTrace) {
          return AppErrorWidget(
            onTap: () {
              ref.read(reportControllerProvider.notifier).getReport(page: 1);
            },
          );
        },
      ),
    );
  }

  Column _buildBody(BuildContext context, OrdersReport? report, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //? Header content :
        ReportPageHeader(report: report),

        //? Divider :
        Divider(height: 0, color: AppColors.lightGray, thickness: 1.h),

        //? Title :
        Text(
          context.tr('recentTransactions'),
          style: Theme.of(
            context,
          ).textTheme.displayLarge!.copyWith(color: AppColors.blackText),
        ).onlyPadding(start: 8.w, top: 14.h, bottom: 20.h),

        //? Nodes list :
        Expanded(
          child: AppPaginationWidget(
            onLoading: (page) async => await ref
                .read(reportControllerProvider.notifier)
                .loadNextPage(),
            enablePullDown: true,
            onRefresh: () async =>
                ref.read(reportControllerProvider.notifier).refreshOrders(),

            child: ListView.builder(
              itemCount: report?.reports.length ?? 0,
              itemBuilder: (context, index) {
                final reportItem = report?.reports[index];
                if (index == 0) return ReportNodeTile.first(reportItem);
                if (index == report!.reports.length - 1) {
                  return ReportNodeTile.last(reportItem);
                }
                return ReportNodeTile.middle(reportItem);
              },
            ),
          ),
        ),
      ],
    );
  }
}
