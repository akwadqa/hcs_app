import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hcs/features/Home/Employees/presentation/controllers/employees_controller.dart';
import 'package:hcs/src/enums/service_type.dart';
import 'package:hcs/src/theme/app_colors.dart';

import '../../../Availability/presentation/controllers/availability_controller.dart';

class ServiceCategoryChips extends ConsumerStatefulWidget {
  final String selectedChip;
  const ServiceCategoryChips({super.key, required this.selectedChip});

  @override
  ServiceCategoryChipsState createState() => ServiceCategoryChipsState();
}

class ServiceCategoryChipsState extends ConsumerState<ServiceCategoryChips> {
  late List<String> serviceCategoryStringList;
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    serviceCategoryStringList = [
      ServiceCategory.onCall,
      ServiceCategory.stayIn,
      ServiceCategory.company,
      ServiceCategory.flexible,
    ].map((type) => serviceCategoryToString(type)).toList();

    _selectedIndex = serviceCategoryStringList.indexOf(widget.selectedChip);
    if (_selectedIndex == -1) {
      _selectedIndex = 0; // fallback if selectedChip is not found
    }
    Future.microtask(() {
      _selectedIndex == 0 || _selectedIndex == 3
          ? ref
                .read(employeesControllerProvider.notifier)
                .selectServiceCategory("Flexible")
          : _selectedIndex == 1
          ? ref
                .read(employeesControllerProvider.notifier)
                .selectServiceCategory(serviceCategoryStringList[1])
          : ref
                .read(employeesControllerProvider.notifier)
                .selectServiceCategory(
                  serviceCategoryStringList[_selectedIndex],
                );
      // ref.read(employeesControllerProvider.notifier).fetchEmployees(page: 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    var selectedShift = ref.watch(
      availabilityControllerProvider.select((s) => s.selectedShiftType),
    );
    bool disabled = selectedShift == shiftTypeToString(ShiftType.overTime);
    if (disabled) {
      int companyIndex = serviceCategoryStringList.indexOf(
        serviceCategoryToString(ServiceCategory.company),
      );

      if (_selectedIndex != companyIndex) {
        // force update in UI
        WidgetsBinding.instance.addPostFrameCallback((_) {
          setState(() => _selectedIndex = companyIndex);

          // update provider state
          ref
              .read(employeesControllerProvider.notifier)
              .selectServiceCategory("Company");
        });
      }
    }
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16.w,
        mainAxisSpacing: 16.h,
        childAspectRatio: 100.w / 30.h,
      ),
      itemCount: serviceCategoryStringList.length,
      itemBuilder: (context, index) {
        final bool isSelected = index == _selectedIndex;
        return GestureDetector(
          onTap: disabled
              ? null
              : () {
                  setState(() => _selectedIndex = index);
                  Future.microtask(() {
                    _selectedIndex == 0 || _selectedIndex == 3
                        ? ref
                              .read(employeesControllerProvider.notifier)
                              .selectServiceCategory("Flexible")
                        : _selectedIndex == 1
                        ? ref
                              .read(employeesControllerProvider.notifier)
                              .selectServiceCategory(
                                serviceCategoryStringList[1],
                              )
                        : ref
                              .read(employeesControllerProvider.notifier)
                              .selectServiceCategory(
                                serviceCategoryStringList[_selectedIndex],
                              );
                    // ref
                    //     .read(employeesControllerProvider.notifier)
                    //     .fetchEmployees(page: 1);
                  });
                },
          child: Container(
            width: 345.w,
            height: 48.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              color: isSelected ? Colors.white : AppColors.unSelectedGrey,
              border: Border.all(
                style: isSelected ? BorderStyle.solid : BorderStyle.none,
                color: AppColors.primary,
              ),
            ),
            child: Text(
              serviceCategoryStringList[index],
              style: Theme.of(context).textTheme.displayLarge!.copyWith(
                fontWeight: FontWeight.w500,
                color: isSelected
                    ? AppColors.blackText
                    : AppColors.unSelectedText,
              ),
            ),
          ),
        );
      },
    );
  }
}
