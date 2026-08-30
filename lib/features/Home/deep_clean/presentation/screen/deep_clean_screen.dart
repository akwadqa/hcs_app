import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hcs/features/Home/Availability/presentation/controllers/availability_controller.dart';
import 'package:hcs/features/Home/deep_clean/domain/models/deep_clean_service_model.dart';
import 'package:hcs/features/Home/deep_clean/presentation/controller/deep_clean_controller.dart';
import 'package:hcs/features/Home/deep_clean/presentation/controller/deep_clean_state.dart';
import 'package:hcs/features/Home/deep_clean/presentation/widgets/custom_dropdown.dart';
import 'package:hcs/features/Home/deep_clean/presentation/widgets/date_picker_field.dart';
import 'package:hcs/features/Home/deep_clean/presentation/widgets/shift_selector.dart';
import 'package:hcs/src/enums/request_state.dart';
import 'package:hcs/src/enums/service_type.dart';
import 'package:hcs/src/routing/app_router.gr.dart';
import 'package:hcs/src/shared_widgets/app_error_widget.dart';
import 'package:hcs/src/shared_widgets/custom_appbar.dart';
import 'package:hcs/src/shared_widgets/custom_button.dart';
import 'package:hcs/src/shared_widgets/fade_circle_loading_indicator.dart';
import 'package:hcs/src/theme/app_colors.dart';

@RoutePage()
class DeepCleanScreen extends ConsumerStatefulWidget {
  const DeepCleanScreen({super.key});

  @override
  ConsumerState<DeepCleanScreen> createState() => _DeepCleanScreenState();
}

class _DeepCleanScreenState extends ConsumerState<DeepCleanScreen> {
  @override
  void initState() {
    super.initState();
    Future(
      () => ref.read(deepCleanControllerProvider.notifier).fetchServices(),
    );
  }

  // 0937675324
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(deepCleanControllerProvider);
    final notifier = ref.read(deepCleanControllerProvider.notifier);
 final selectedServiceType = ref.watch(
    availabilityControllerProvider.select((v) => v.selectedServiceType),
  );
  final mode = HomeServiceMode.fromSelectedServiceType(selectedServiceType);

    return Scaffold(
      appBar: CustomAppbar(hasBackArrow: true, title: mode.title),
      body: state.servicesState == RequestStates.loading
          ? const Center(child: FadeCircleLoadingIndicator())
          : state.servicesState == RequestStates.error
          ? AppErrorWidget(onTap: () => notifier.fetchServices())
          : Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Text('Choose the required service',
                          //     style:
                          //         Theme.of(context).textTheme.titleMedium),
                          // 8.verticalSpace,

                          // 🔽 Services now come from the backend
                          // CustomDropdown<DeepCleanServiceModel>(
                          //   hint: 'Choose the service',
                          //   value: state.selectedService,
                          //   items: state.services
                          //       .map((s) => DropdownMenuItem(
                          //             value: s,
                          //             child: Text(s.name),
                          //           ))
                          //       .toList(),
                          //   onChanged: (v) {
                          //     if (v != null) notifier.selectService(v);
                          //   },
                          // ),
                          20.verticalSpace,
                          Text(
                            'Service Type',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          8.verticalSpace,
                          Container(
                            width: double.infinity,
                            height: 45,
                            padding: EdgeInsets.all(12),
                            alignment: AlignmentDirectional.centerStart,
                            decoration: BoxDecoration(
                              color: AppColors.white,

                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              mode.title,
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          ),

                          // CustomDropdown<DeepCleanServiceType>(
                          //   hint: 'On Call',
                          //   value: state.selectedServiceType,
                          //   items: DeepCleanServiceType.values
                          //       .map((e) => DropdownMenuItem(
                          //             value: e,
                          //             child: Text(e.label),
                          //           ))
                          //       .toList(),
                          //   onChanged: (v) {
                          //     if (v != null) notifier.selectServiceType(v);
                          //   },
                          // ),
                          20.verticalSpace,
                          Text(
                            'Shift Type',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          8.verticalSpace,
                          ShiftSelector(
                            selectedShift: state.selectedShift,
                            onShiftSelected: notifier.selectShift,
                          ),

                          20.verticalSpace,
                          Text(
                            'Date',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          8.verticalSpace,
                          DatePickerField(
                            selectedDate: state.selectedDate,
                            onDateSelected: notifier.selectDate,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    child: CustomButton(
                      title: 'Next',
                      onPressed: state.isFirstStepValid
                          ? () => context.pushRoute(const ServiceDetailsRoute())
                          : null,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
