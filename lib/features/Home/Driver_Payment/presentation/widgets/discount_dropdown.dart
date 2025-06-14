import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hcs/features/Home/Availability/data/models/packages_model.dart';
import 'package:hcs/features/Home/Customer/presentation/widgets/drop_down_textfield.dart';
import 'package:hcs/src/manager/app_strings.dart';

class DiscountDropdown extends StatelessWidget {
  final List<String> items;
  final String? selectedItem;
  final Function(PackagesData) onSelected;

  const DiscountDropdown({
    super.key,
    required this.items,
    required this.selectedItem,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.tr(AppStrings.driverName),
          style: Theme.of(context).textTheme.displayMedium!,
        ),
        8.verticalSpace,
        DropDownField(
          enabled: true,
          value: selectedItem,
          items: items,
          onChanged: (value) {
            // final selected = items.firstWhere((pkg) => pkg.id == value);
            // onSelected(selected);
          },
        ),
      ],
    );
  }
}
