import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hcs/features/Home/Customer/presentation/controllers/customer_controller.dart';
import 'package:hcs/features/Home/Customer/presentation/controllers/customer_state.dart';
import 'package:hcs/features/Home/Customer/presentation/widgets/add_customer_dialog.dart';
import 'package:hcs/features/Home/Customer/presentation/widgets/paginated_customers_dropdown.dart';
import 'package:hcs/src/enums/request_state.dart';
import 'package:hcs/src/enums/service_type.dart';
import 'package:hcs/src/manager/app_strings.dart';
import 'package:hcs/src/routing/app_router.gr.dart';
import 'package:hcs/src/shared_widgets/app_error_widget.dart';
import 'package:hcs/src/shared_widgets/custom_appbar.dart';
import 'package:hcs/src/shared_widgets/custom_button.dart';
import 'package:hcs/src/shared_widgets/fade_circle_loading_indicator.dart';

@RoutePage()
class CustomerScreen extends ConsumerStatefulWidget {
  final ServiceType serviceType;
  const CustomerScreen({super.key, required this.serviceType});

  @override
  ConsumerState<CustomerScreen> createState() => _CustomerScreenState();
}

class _CustomerScreenState extends ConsumerState<CustomerScreen> {
  @override
  void initState() {
    super.initState();
    Future(
      () => ref.read(customerControllerProvider.notifier).fetchCostumers(),
    );
  }


  @override
  Widget build(BuildContext context) {
    final customerState = ref.watch(customerControllerProvider);

    return Scaffold(
      body: customerState.customersStates == RequestStates.loaded
          ? _buildContent(customerState)
          : customerState.customersStates == RequestStates.loading
          ? const Center(child: FadeCircleLoadingIndicator())
          : customerState.customersStates == RequestStates.error
          ? AppErrorWidget(
              onTap: () => Future(
                () => ref
                    .read(customerControllerProvider.notifier)
                    .fetchCostumers(),
              ),
            )
          : SizedBox.shrink(),
      // body: _buildContent(CustomerState),
      appBar: CustomAppbar(hasBackArrow: true),
    );
  }

  Widget _buildContent(CustomerState customerState) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        children: [
          // This Column will take available space
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(vertical: 32.h),
                  child: Text(
                    context.tr(AppStrings.customer),
                    style: Theme.of(context).textTheme.displayMedium!,
                  ),
                ),
                8.verticalSpace,
                PaginatedCustomerDropdown(),
                20.verticalSpace,

                SizedBox(
                  height: 48.h,
                  child: TextButton(
                    style: const ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Colors.white),
                    ),
                    onPressed: () async {
                      await showDialog<String>(
                        context: context,
                        builder: (_) => const AddCustomerDialog(),
                      );
                    },
                    child: const Text(
                      '+ Add Customer',
                    ), // Changed to const Text
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 25.h),
            child: Consumer(
              builder: (context, ref, child) {
                final selectedCustomerState = ref.watch(
                  customerControllerProvider.select(
                    (value) => value.selectedCustomer,
                  ),
                );

                return CustomButton(
                  title: tr(context: context, AppStrings.next),
                  onPressed: selectedCustomerState == null
                      ? null
                      : () {
                          context.pushRoute(ServiceConfigurationRoute());
                        },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
