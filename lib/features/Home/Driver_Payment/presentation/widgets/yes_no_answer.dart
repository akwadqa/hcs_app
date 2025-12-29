import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hcs/features/Home/Driver_Payment/presentation/controllers/drivers_payment_controllers.dart';
import 'package:hcs/src/manager/app_strings.dart';
import 'package:hcs/src/theme/app_colors.dart';

class AreCleaningSuppliesAvailable extends ConsumerWidget {
  const AreCleaningSuppliesAvailable({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var notifier = ref.read(driversPaymentControllerProvider.notifier);
    // final List<String> options = ['Yes', 'No'];
      var withCleaningSupplies = ref.watch(
              driversPaymentControllerProvider.select(
                (value) => value.withCleaningSupplies,
              ),
            );
            // final bool isSelected =
            //     "true" == withCleaningSupplies;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,

      children: [
        Row(
          children: [
             Checkbox.adaptive(value: withCleaningSupplies, onChanged: (c){
                notifier.withCleaningSupplies(c!);
                debugPrint(c.toString());

                  }),
            Text(
              context.tr(AppStrings.areCleaningSuppliesAvaliable),
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ],
        ),
        16.verticalSpace,
        //  GestureDetector(
        //       onTap: () {
        //         // notifier.withCleaningSupplies(options[i].toLowerCase());
        //       },
        //       child: Row(
        //         children: [
        //           Checkbox.adaptive(value: isSelected, onChanged: (c){
        //         notifier.withCleaningSupplies(c!);

        //           }),
        //           // Container(
        //           //   alignment: Alignment.center,
        //           //   width: 162.w,
        //           //   height: 50.h,
        //           //   decoration: BoxDecoration(
        //           //     color: isSelected ? Colors.white : AppColors.unSelectedGrey,
        //           //     border: isSelected
        //           //         ? Border.all(color: AppColors.blueText, width: 0.5)
        //           //         : null,
        //           //     borderRadius: BorderRadius.circular(8.r),
        //           //   ),
        //           //   child: Text(
        //           //     options[i],
        //           //     style: Theme.of(context).textTheme.bodyMedium!.copyWith(
        //           //       color: isSelected
        //           //           ? AppColors.blackText
        //           //           : AppColors.unSelectedText,
        //           //     ),
        //           //   ),
        //           // ),
        //         ],
        //       ),
        //     ),
         
        // Wrap(
        //   spacing: 19.w,
        //   runSpacing: 16.h,
        //   children: List.generate(options.length, (i) {
        //     var notifier = ref.read(driversPaymentControllerProvider.notifier);
        //     var withCleaningSupplies = ref.watch(
        //       driversPaymentControllerProvider.select(
        //         (value) => value.withCleaningSupplies,
        //       ),
        //     );
        //     final bool isSelected =
        //         options[i].toLowerCase() == withCleaningSupplies;

        //     return GestureDetector(
        //       onTap: () {
        //         // notifier.withCleaningSupplies(options[i].toLowerCase());
        //       },
        //       child: Row(
        //         children: [
        //           Checkbox.adaptive(value: isSelected, onChanged: (c){
        //         notifier.withCleaningSupplies(c!);

        //           }),
        //           Container(
        //             alignment: Alignment.center,
        //             width: 162.w,
        //             height: 50.h,
        //             decoration: BoxDecoration(
        //               color: isSelected ? Colors.white : AppColors.unSelectedGrey,
        //               border: isSelected
        //                   ? Border.all(color: AppColors.blueText, width: 0.5)
        //                   : null,
        //               borderRadius: BorderRadius.circular(8.r),
        //             ),
        //             child: Text(
        //               options[i],
        //               style: Theme.of(context).textTheme.bodyMedium!.copyWith(
        //                 color: isSelected
        //                     ? AppColors.blackText
        //                     : AppColors.unSelectedText,
        //               ),
        //             ),
        //           ),
        //         ],
        //       ),
        //     );
        //   }),
        // ),
      ],
    );
  }
}
