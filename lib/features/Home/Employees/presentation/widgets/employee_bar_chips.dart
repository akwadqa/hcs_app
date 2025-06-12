import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hcs/features/Home/Employees/data/models/employees_model.dart';
import 'package:hcs/features/Home/Employees/presentation/controllers/employees_controller.dart';
import 'package:hcs/src/theme/app_colors.dart';

/// A single employee chip with enabled/disabled styling.
class EmployeeBarChip extends StatefulWidget {
  final Employee employee;
  final VoidCallback? onTap;

  const EmployeeBarChip({super.key, required this.employee, this.onTap});

  @override
  State<EmployeeBarChip> createState() => _EmployeeBarChipState();
}

class _EmployeeBarChipState extends State<EmployeeBarChip> {
  bool enabled = false;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final controller = ref.read(employeesControllerProvider.notifier);
        return GestureDetector(
          onTap: () {
            if (!enabled) {
              controller.selectEmployee(widget.employee);
            } else {
                controller.unSelectEmployee(widget.employee);
            }
            setState(() {
              enabled = !enabled;
            });
          },

          child: Container(
            width: 345.w,
            height: 48.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              color: enabled ? Colors.white : AppColors.unSelectedGrey,
              border: Border.all(
                style: enabled ? BorderStyle.solid : BorderStyle.none,
                color: AppColors.primary,
              ),
            ),
            child: Text(
              widget.employee.employeeName,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: enabled ? AppColors.blackText : AppColors.unSelectedText,
              ),
            ),
          ),
        );
      },
    );
  }
}
