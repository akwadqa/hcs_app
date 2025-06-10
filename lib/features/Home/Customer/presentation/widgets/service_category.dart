import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hcs/src/theme/app_colors.dart';

class ServiceCategoryChips extends StatefulWidget {
  const ServiceCategoryChips({super.key});

  @override
  _ServiceCategoryChipsState createState() => _ServiceCategoryChipsState();
}

class _ServiceCategoryChipsState extends State<ServiceCategoryChips> {
  final List<String> _options = ['On Call', 'Stay in', 'Company', 'Package'];

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    // Wrap inside a fixed-height container if needed
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16.w,
        mainAxisSpacing: 16.h,
        childAspectRatio: 165.w / 80.h,
      ),
      itemCount: _options.length,
      itemBuilder: (context, index) {
        final bool isSelected = index == _selectedIndex;
        return GestureDetector(
          onTap: () => setState(() => _selectedIndex = index),
          child: Container(
            alignment: Alignment.center,
            width: 165.w,
            height: 80.h,
            decoration: BoxDecoration(
              color: isSelected ? AppColors.selectedBlue : AppColors.primary,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Text(
              _options[index],
              style: Theme.of(
                context,
              ).textTheme.displayLarge!.copyWith(fontWeight: FontWeight.w500),
            ),
          ),
        );
      },
    );
  }
}
