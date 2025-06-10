import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hcs/features/Home/Customer/presentation/widgets/drop_down_textfield.dart';
import 'package:hcs/src/enums/service_type.dart';
import 'package:hcs/src/manager/app_strings.dart';

class ServiceTypeMenu extends StatelessWidget {
  final ServiceType serviceType;
  ServiceTypeMenu({super.key, required this.serviceType});

  List<ServiceType> serviceTypeList = [
    ServiceType.onCall,
    ServiceType.packages,
    ServiceType.deepClean,
    ServiceType.maintenance,
  ];
  @override
  Widget build(BuildContext context) {
    List<String> serviceTypeStringList = serviceTypeList
        .map((type) => type.name)
        .toList();

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Text(
          context.tr(AppStrings.serviceType),
          style: Theme.of(context).textTheme.displayMedium!,
        ),
        8.verticalSpace,
        DropDownField(
          enabled: true,
          items: serviceTypeStringList,
          initialSelect: serviceTypeToString(serviceType),
        ),
      ],
    );
  }
}
