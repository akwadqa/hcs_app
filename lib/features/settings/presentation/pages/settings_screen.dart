import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hcs/features/Auth/presentation/controller/auth_controller.dart';
import 'package:hcs/gen/assets.gen.dart';
import 'package:hcs/src/routing/app_router.gr.dart';
import 'package:hcs/src/shared_widgets/custom_button.dart';
import 'package:hcs/src/manager/app_strings.dart';
import 'package:hcs/src/shared_widgets/custom_appbar.dart';
import 'package:hcs/src/theme/app_colors.dart';

@RoutePage()
class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    // Register listener exactly once
    ref.listen<AsyncValue<void>>(authControllerProvider, (previous, next) {
      if (next is AsyncData) {
        context.router.replaceAll([IntroRoute()]);
      } else if (next is AsyncError) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(next.error.toString())));
      }
    });

    return Scaffold(
      appBar: CustomAppbar(
        hasBackArrow: false,
        withouTitle: true,
        title: context.tr(AppStrings.settings),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 26.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //         30.verticalSpace,

                  //         Assets.images.goodbye.image(width: 100, height: 100),
                  //         10.verticalSpace,
                  //         Text(
                  //           context.tr(AppStrings.settingsDesc),
                  //           style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  //             decoration: TextDecoration.overline,
                  //             decorationStyle: TextDecorationStyle.dotted,
                  //             fontStyle: FontStyle.italic,
                  //             fontSize: 15.sp,
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  _buildMenuItem(
                    context,
                    'Report',
                    onTap: () {
                      context.router.push(ReportRoute());
                    },
                  ),
                  Spacer(),
                  // Padding(
                  //   padding: EdgeInsets.symmetric(horizontal: 26.w, vertical: 25.h),
                  //   child: CustomButton(
                  //     title: context.tr('report'),
                  //     onPressed: () {
                  //       context.router.push(ReportRoute());
                  //     },
                  //   ),
                  // ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 26.w,
                      vertical: 25.h,
                    ),
                    child: CustomButton(
                      title: tr(context: context, AppStrings.logOut),
                      onPressed:
                          ref.read(authControllerProvider) is AsyncLoading
                          ? null
                          : () {
                              ref
                                  .read(authControllerProvider.notifier)
                                  .logout();
                            },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context,
    String title, {
    required VoidCallback onTap,
    bool showDivider = true,
  }) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          leading: Icon(Icons.settings, color: AppColors.primary), // ✅
          title: Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.titleMedium!.copyWith(color: AppColors.black900),
          ),
          trailing: Icon(Icons.arrow_forward_ios, size: 18, color: Colors.grey),
          onTap: onTap,
        ),
        if (showDivider)
          const Divider(
            height: 1,
            indent: 12,
            endIndent: 12,
            color: AppColors.lightGray,
          ),
      ],
    );
  }
}
