import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hcs/features/Home/Driver_Payment/presentation/controllers/drivers_payment_controllers.dart';
import 'package:hcs/gen/assets.gen.dart';
import 'package:hcs/src/enums/service_type.dart';
import 'package:hcs/src/manager/app_strings.dart';
import 'package:hcs/src/theme/app_colors.dart';

class PaymentMethodChips extends StatefulWidget {
  const PaymentMethodChips({super.key});

  @override
  _PaymentMethodChipsState createState() => _PaymentMethodChipsState();
}

class _PaymentMethodChipsState extends State<PaymentMethodChips> {
  final List<String> _options = [
    PaymentMethod.online,
    PaymentMethod.cash,
  ].map((type) => paymentMethodToString(type)).toList();

  final List<SvgGenImage> _image = [
    Assets.images.creditCard,
    Assets.images.cash,
  ];

  int _selectedIndex = 0; // default to first

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,

      children: [
        Text(
          context.tr(AppStrings.paymentMethod),
          style: Theme.of(context).textTheme.displayMedium,
        ),
        16.verticalSpace,
        Wrap(
          spacing: 19.w,
          runSpacing: 16.h,
          children: List.generate(_options.length, (i) {
            final bool isSelected = i == _selectedIndex;
            return Consumer(
              builder: (context, ref, child) {
                //TODO MAKE STATE FOR IT AND CHANGE CONTROLLER USE HERE
                var driversPaymentController = ref.read(
                  driversPaymentControllerProvider.notifier,
                );

                return GestureDetector(
                  onTap: () {
                    setState(() => _selectedIndex = i);
                    driversPaymentController.selectPaymentMethod(_options[i]);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      // horizontal: 40.w,
                      vertical: 10.h,
                    ),
                    alignment: Alignment.center,
                    width: 155.w,
                    height: 115.h,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Colors.white
                          : AppColors.unSelectedGrey,
                      border: isSelected
                          ? Border.all(color: AppColors.blueText, width: 0.5)
                          : null,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Column(
                      children: [
                        _image[i].svg(),
                        12.verticalSpace,
                        Text(
                          _options[i],
                          style: Theme.of(context).textTheme.bodyMedium!
                              .copyWith(
                                color: isSelected
                                    ? AppColors.blackText
                                    : AppColors.unSelectedText,
                              ),
                        ),
                      ],
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
