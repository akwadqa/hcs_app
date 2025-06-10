import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hcs/features/Auth/presentation/controller/auth_controller.dart';
import 'package:hcs/features/Home/Customer/data/models/customers_model.dart';
import 'package:hcs/features/Home/Customer/presentation/controllers/home_controller.dart';
import 'package:hcs/features/Home/Customer/presentation/widgets/add_customer_dialog.dart';
import 'package:hcs/features/Home/Customer/presentation/widgets/drop_down_textfield.dart';
import 'package:hcs/features/Home/Customer/presentation/widgets/paginated_dropdown.dart';
import 'package:hcs/src/enums/request_state.dart';
import 'package:hcs/src/manager/app_strings.dart';
import 'package:hcs/src/routing/app_router.gr.dart';
import 'package:hcs/src/shared_widgets/app_error_widget.dart';
import 'package:hcs/src/shared_widgets/custom_appbar.dart';
import 'package:hcs/src/shared_widgets/custom_button.dart';

@RoutePage()
class CustomerScreen extends ConsumerStatefulWidget {
  const CustomerScreen({super.key});

  @override
  ConsumerState<CustomerScreen> createState() => _CustomerScreenState();
}

class _CustomerScreenState extends ConsumerState<CustomerScreen> {
  final _formKey = GlobalKey<FormState>();
  Customers? _chosenCustomer;
  @override
  void initState() {
    super.initState();
    // Future(() => ref.read(homeControllerProvider.notifier).fetchHomeBlocks());
  }

  @override
  Widget build(BuildContext context) {
    // final homeState = ref.watch(homeControllerProvider);

    return Scaffold(
      // body: homeState.homeStates == RequestStates.loaded
      //     ? _buildContent(homeState.homeBlock!)
      //     : homeState.homeStates == RequestStates.loading
      //     ? const Center(child: CircularProgressIndicator())
      //     : homeState.homeStates == RequestStates.error
      //     ? AppErrorWidget(
      //         onTap: () => Future(
      //           () =>
      //               ref.read(homeControllerProvider.notifier).fetchHomeBlocks(),
      //         ),
      //       )
      //     : SizedBox.shrink(),
      body: _buildContent(),
      appBar: CustomAppbar(hasBackArrow: true, title: 'On Call Service'),
    );
  }

  Widget _buildContent() {
    final homeState = ref.watch(homeControllerProvider);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
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
                  Form(
                    key: _formKey,
                    child: Consumer(
                      builder: (context, ref, child) {
                        if (homeState.customersStates == RequestStates.loaded) {
                          // return DropDownField(customers: homeState.customers);
                          return PaginatedDropdown(
                            customers: homeState.customers,

                            hasMore: homeState.currentCustomersPage != null,
                            isLoading:
                                homeState.customersStates ==
                                RequestStates.loading,
                            onLoadMore: () => ref
                                .read(homeControllerProvider.notifier)
                                .onLoadMoreCostumers(),
                            initialValue: ref
                                .read(homeControllerProvider)
                                .selectedCustomer,
                            // local state in parent
                            onChanged: (cust) {
                              setState(
                                () => _chosenCustomer = cust,
                              ); // or update Riverpod state
                              ref
                                  .read(homeControllerProvider.notifier)
                                  .selectCustomer(cust);
                              debugPrint(
                                '$_chosenCustomer koko _chosenCustomer',
                              );
                              debugPrint('$cust koko cust ');
                            },
                          );
                        } else if (homeState.customersStates ==
                            RequestStates.loading) {
                          return CircularProgressIndicator();
                        } else if (homeState.customersStates ==
                            RequestStates.error) {
                          return AppErrorWidget(
                            onTap: () => ref
                                .read(homeControllerProvider.notifier)
                                .fetchCostumers(),
                          );
                        } else {
                          return SizedBox.shrink();
                        }
                      },
                    ),
                  ),
                  20.verticalSpace,

                  TextButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Colors.white),
                    ),
                    onPressed: () async {
                      await showDialog<String>(
                        context: context,
                        builder: (_) => const AddCustomerDialog(),
                      );
                    },
                    child: Text('+ Add Customer'),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 25.h),
            child: Consumer(
              builder: (context, ref, child) {
                final asyncCustomers = ref.watch(authControllerProvider);

                return CustomButton(
                  title: tr(context: context, AppStrings.next),
                  onPressed: asyncCustomers is AsyncLoading
                      ? null
                      : () {
                          context.pushRoute(ServiceConfigurationRoute());

                          if (_formKey.currentState!.validate()) {
                            // ref
                            //     .read(authControllerProvider.notifier)
                            //     .login(
                            //       LoginParams(
                            //         email: _emailController.text,
                            //         pass: _passwordController.text,
                            //       ),
                            //     );
                          }
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
