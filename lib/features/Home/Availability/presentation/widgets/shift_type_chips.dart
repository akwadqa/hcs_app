import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hcs/features/Home/Availability/presentation/controllers/availability_controller.dart';
import 'package:hcs/src/enums/service_type.dart';
import 'package:hcs/src/manager/app_strings.dart';
import 'package:hcs/src/theme/app_colors.dart';

class ShiftTypeChips extends StatefulWidget {
  const ShiftTypeChips({super.key});

  @override
  _ShiftTypeChipsState createState() => _ShiftTypeChipsState();
}

class _ShiftTypeChipsState extends State<ShiftTypeChips> {
  final List<String> _options = [
    ShiftType.morning,
    ShiftType.evening,
    ShiftType.fullDay,
  ].map((type) => shiftTypeToString(type)).toList();
  int _selectedIndex = 0; // default to first

  @override
  Widget build(BuildContext context) {
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,

      children: [
        Text(
          context.tr(AppStrings.shiftType),
          style: Theme.of(context).textTheme.displayMedium,
        ),
        8.verticalSpace,
        Wrap(
          spacing: 19.w,
          runSpacing: 16.h,
          children: List.generate(_options.length, (i) {
            final bool isSelected = i == _selectedIndex;
            return Consumer(
              builder: (context, ref, child) {
                var availabilityController = ref.read(
                  availabilityControllerProvider.notifier,
                );

                return GestureDetector(
                  onTap: () {
                    setState(() => _selectedIndex = i);
                    availabilityController.selectShift(_options[i]);
                  },
                  child: Container(
                    // padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 12.h),
                    alignment: Alignment.center,
                    width: 162.w,
                    height: 48.h,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Colors.white
                          : AppColors.unSelectedGrey,
                      border: isSelected
                          ? Border.all(color: AppColors.blueText, width: 0.5)
                          : null,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Text(
                      _options[i],
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: isSelected
                            ? AppColors.blueText
                            : AppColors.unSelectedText,
                      ),
                    ),
                  ),
                );
              },
            );
          }),
        ),
      ],
    );
  }
}
