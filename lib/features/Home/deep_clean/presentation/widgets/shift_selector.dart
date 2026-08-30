import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hcs/features/Home/deep_clean/presentation/controller/deep_clean_state.dart';

class ShiftSelector extends StatelessWidget {
  final DeepCleanShift? selectedShift;
  final ValueChanged<DeepCleanShift> onShiftSelected;

  const ShiftSelector({
    super.key,
    required this.selectedShift,
    required this.onShiftSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _chip(context, DeepCleanShift.morning)),
            12.horizontalSpace,
            Expanded(child: _chip(context, DeepCleanShift.evening)),
          ],
        ),
        // 12.verticalSpace,
        // Row(
        //   children: [
        //     Expanded(child: _chip(context, DeepCleanShift.fullDay)),
        //     12.horizontalSpace,
        //     const Expanded(child: SizedBox()),
        //   ],
        // ),
      ],
    );
  }

  Widget _chip(BuildContext context, DeepCleanShift shift) {
    final selected = selectedShift == shift;
    return InkWell(
      onTap: () => onShiftSelected(shift),
      borderRadius: BorderRadius.circular(8.r),
      child: Container(
        height: 50.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected ? Colors.white : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color: selected
                ? Theme.of(context).primaryColor
                : Colors.transparent,
          ),
        ),
        child: Text(
          shift.label,
          style: TextStyle(
            color: selected
                ? Theme.of(context).primaryColor
                : Colors.grey,
            fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
      ),
    );
  }
}