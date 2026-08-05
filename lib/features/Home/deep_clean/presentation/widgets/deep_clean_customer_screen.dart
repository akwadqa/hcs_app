// // lib/features/Home/DeepClean/presentation/screens/deep_clean_customer_screen.dart
// import 'package:auto_route/auto_route.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:hcs/features/Home/Customer/presentation/controllers/customer_controller.dart';
// import 'package:hcs/features/Home/Customer/presentation/widgets/add_customer_dialog.dart';
// import 'package:hcs/features/Home/Customer/presentation/widgets/custoemr_bar_chip.dart';
// import 'package:hcs/features/Home/Employees/presentation/widgets/search_field.dart';
// import 'package:hcs/gen/assets.gen.dart';
// import 'package:hcs/src/enums/request_state.dart';
// import 'package:hcs/src/manager/app_strings.dart';
// import 'package:hcs/src/routing/app_router.gr.dart';
// import 'package:hcs/src/shared_widgets/app_error_widget.dart';
// import 'package:hcs/src/shared_widgets/custom_appbar.dart';
// import 'package:hcs/src/shared_widgets/custom_button.dart';
// import 'package:hcs/src/shared_widgets/fade_circle_loading_indicator.dart';

// @RoutePage()
// class DeepCleanCustomerScreen extends ConsumerStatefulWidget {
//   const DeepCleanCustomerScreen({super.key});

//   @override
//   ConsumerState<DeepCleanCustomerScreen> createState() =>
//       _DeepCleanCustomerScreenState();
// }

// class _DeepCleanCustomerScreenState
//     extends ConsumerState<DeepCleanCustomerScreen> {
//   final ScrollController _scrollController = ScrollController();

//   @override
//   void initState() {
//     super.initState();
//     Future(
//       () => ref.read(customerControllerProvider.notifier).fetchCostumers(),
//     );
//     _scrollController.addListener(() {
//       final max = _scrollController.position.maxScrollExtent;
//       final pos = _scrollController.position.pixels;
//       final nextPage =
//           ref.read(customerControllerProvider).currentCustomersPage;

//       if (pos == max && nextPage != null) {
//         ref.read(customerControllerProvider.notifier).onLoadMoreCostumers();
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _scrollController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final customerState = ref.watch(customerControllerProvider);

//     return Scaffold(
//       appBar: CustomAppbar(hasBackArrow: true),
//       body: customerState.customersStates == RequestStates.loading
//           ? const Center(child: FadeCircleLoadingIndicator())
//           : customerState.customersStates == RequestStates.error
//               ? AppErrorWidget(
//                   onTap: () => ref
//                       .read(customerControllerProvider.notifier)
//                       .fetchCostumers(),
//                 )
//               : Padding(
//                   padding:
//                       EdgeInsets.only(left: 24.w, right: 24.w, top: 16.h),
//                   child: Column(
//                     children: [
//                       Row(
//                         children: [
//                           Expanded(
//                             flex: 8,
//                             child: SearchField(
//                               hintText: "Search Customers",
//                               controller: TextEditingController(
//                                 text: customerState.customerSearchedFor,
//                               ),
//                               onFieldSubmitted: (value) {
//                                 ref
//                                     .read(customerControllerProvider.notifier)
//                                     .searchCustomer(value);
//                               },
//                             ),
//                           ),
//                           Expanded(
//                             flex: 2,
//                             child: Padding(
//                               padding: EdgeInsets.only(left: 8.w),
//                               child: Container(
//                                 height: kMinInteractiveDimension,
//                                 decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   borderRadius: BorderRadius.circular(8.r),
//                                 ),
//                                 child: IconButton(
//                                   onPressed: () {
//                                     showDialog(
//                                       context: context,
//                                       builder: (_) =>
//                                           const AddCustomerDialog(),
//                                     );
//                                   },
//                                   icon: const Icon(Icons.person_add),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       22.verticalSpace,
//                       Text(
//                         context.tr(AppStrings.customers),
//                         style: Theme.of(context).textTheme.displayMedium,
//                       ),
//                       16.verticalSpace,
//                       Expanded(
//                         child: customerState.customers.isEmpty
//                             ? Assets.images.noDataMin.image()
//                             : ListView.separated(
//                                 controller: _scrollController,
//                                 itemCount:
//                                     customerState.customers.length + 1,
//                                 itemBuilder: (context, index) {
//                                   if (index ==
//                                       customerState.customers.length) {
//                                     return customerState
//                                                 .currentCustomersPage ==
//                                             null
//                                         ? Center(
//                                             child: Text('No More Customers'))
//                                         : const Center(
//                                             child:
//                                                 FadeCircleLoadingIndicator());
//                                   }
//                                   return CustomerBarChip(
//                                     customer: customerState.customers[index],
//                                     isEnabled: customerState
//                                             .selectedCustomer?.customerId ==
//                                         customerState
//                                             .customers[index].customerId,
//                                   );
//                                 },
//                                 separatorBuilder: (_, __) =>
//                                     16.verticalSpace,
//                               ),
//                       ),
//                       Padding(
//                         padding:
//                             EdgeInsets.only(top: 10.h, bottom: 10.h),
//                         child: CustomButton(
//                           title: tr(context: context, AppStrings.next),
//                           onPressed: customerState.selectedCustomer == null
//                               ? null
//                               : () {
//                                   // Navigate to Service Details for Deep Clean flow
//                                   context.pushRoute(
//                                      ServiceDetailsRoute(),
//                                   );
//                                 },
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//     );
//   }
// }