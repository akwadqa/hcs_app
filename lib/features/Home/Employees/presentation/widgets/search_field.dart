import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hcs/features/MyOrders/presentation/controllers/myorders_controller.dart';
import 'package:hcs/features/MyOrders/presentation/widgets/filter_status_menu.dart';
import 'package:hcs/gen/assets.gen.dart';
import 'package:hcs/src/enums/orders_status_enums.dart';
import 'package:hcs/src/extenssions/widget_extensions.dart';
import 'package:hcs/src/theme/app_colors.dart';

/// A reusable search input styled like the app's TextFormField theme.
class SearchField extends ConsumerWidget {
  final TextEditingController? controller;
  final String hintText;
  final VoidCallback? onClear;
  final ValueChanged<String>? onChanged;
  final Function(String)? onFieldSubmitted;
final int? tabIndex;
  const SearchField({
    super.key,
    this.controller,
    this.hintText = 'Search',
    this.onClear,
    this.onChanged,
    this.onFieldSubmitted,
    this.tabIndex,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextFormField(
      controller: controller,
      // onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: Theme.of(context).inputDecorationTheme.hintStyle,
        isDense: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),

        prefixIcon: Assets.images.search.svg(
          width: 16,
          height: 16,
          fit: BoxFit.scaleDown,
        ),
        
        suffixIcon:tabIndex!=null? GestureDetector(
          onTap: () async{
               final selected = await showStatusFilterMenu(context);

    if (selected != null) {
      // final currentTabIndex = DefaultTabController.of(context).index ?? 0;

      ref
          .read(myOrdersControllerProvider.notifier)
          .applyStatusFilter(selected.apiValue, tabIndex: tabIndex!);
    }
          },
          child: Icon(
            Icons.filter_alt_rounded,
            color: AppColors.primary,
            size: 33,
          ),
        ).onlyPadding(end: 8):null,
      ),
    );
  }
}
