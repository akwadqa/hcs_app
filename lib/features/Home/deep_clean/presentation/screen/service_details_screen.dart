import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hcs/features/Home/Availability/presentation/controllers/availability_controller.dart';
import 'package:hcs/features/Home/deep_clean/presentation/controller/deep_clean_controller.dart';
import 'package:hcs/features/Home/deep_clean/presentation/widgets/add_another_service_button.dart';
import 'package:hcs/features/Home/deep_clean/presentation/widgets/service_picker_card.dart';
import 'package:hcs/src/enums/request_state.dart';
import 'package:hcs/src/enums/service_type.dart';
import 'package:hcs/src/routing/app_router.gr.dart';
import 'package:hcs/src/shared_widgets/app_error_widget.dart';
import 'package:hcs/src/shared_widgets/custom_appbar.dart';
import 'package:hcs/src/shared_widgets/custom_button.dart';
import 'package:hcs/src/shared_widgets/fade_circle_loading_indicator.dart';

@RoutePage()
class ServiceDetailsScreen extends ConsumerStatefulWidget {
  const ServiceDetailsScreen({super.key});

  @override
  ConsumerState<ServiceDetailsScreen> createState() =>
      _ServiceDetailsScreenState();
}

class _ServiceDetailsScreenState extends ConsumerState<ServiceDetailsScreen> {
  @override
  void initState() {
    super.initState();
    Future(() {
      final s = ref.read(deepCleanControllerProvider);
      if (s.services.isEmpty) {
        ref.read(deepCleanControllerProvider.notifier).fetchServices();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(deepCleanControllerProvider);
    final notifier = ref.read(deepCleanControllerProvider.notifier);
final selectedServiceType = ref.watch(
  availabilityControllerProvider.select((v) => v.selectedServiceType),
);
final mode = HomeServiceMode.fromSelectedServiceType(selectedServiceType);
    return Scaffold(
      appBar: const CustomAppbar(hasBackArrow: true, title: 'Service Details'),
      body: state.servicesState == RequestStates.loading
          ? const Center(child: FadeCircleLoadingIndicator())
          : state.servicesState == RequestStates.error
          ? AppErrorWidget(onTap: notifier.fetchServices)
          : Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Add Services',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          16.verticalSpace,
                          ...List.generate(state.selectedServices.length, (i) {
                            final selected = state.selectedServices[i];

                            return Padding(
                              padding: EdgeInsets.only(bottom: 16.h),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,

                                children: [
                                  ServicePickerCard(
                                    services: state.services,
                                    selected: selected,
                                    onChanged: (v) =>
                                        notifier.selectServiceAt(i, v),
                                    onRemove: state.selectedServices.length > 1
                                        ? () => notifier.removeServiceCard(i)
                                        : null,
                                  ),
                                  if (mode.showQtyField  &&
                                      selected != null) ...[
                                    8.verticalSpace,
                                    _QuantityField(
                                      label: 'Number of Devices (ACs)',
                                      initial: state.qtyFor(selected.itemCode),
                                      onChanged: (q) =>
                                          notifier.setQty(selected.itemCode, q),
                                    ),
                                  ],
                                ],
                              ),
                            );
                          }),
                          8.verticalSpace,
                          AddAnotherServiceButton(
                            onTap: notifier.addServiceCard,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    child: CustomButton(
                      title: 'Next',
                      onPressed: state.canGoToSummary
                          ? () => context.pushRoute(const OrderSummaryRoute())
                          : null,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
class _QuantityField extends StatelessWidget {
  final String label;
  final int initial;
  final ValueChanged<int> onChanged;
  const _QuantityField({
    required this.label,
    required this.initial,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.titleSmall),
        6.verticalSpace,
        TextFormField(
          initialValue: initial.toString(),
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: InputDecoration(
            hintText: 'e.g. 3 (optional)',
            filled: true,
            fillColor: Colors.white,
            contentPadding:
                EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide.none,
            ),
          ),
          onChanged: (v) => onChanged(int.tryParse(v) ?? 1),
        ),
      ],
    );
  }
}