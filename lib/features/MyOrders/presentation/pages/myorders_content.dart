import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hcs/features/Home/Employees/presentation/widgets/search_field.dart';
import 'package:hcs/features/MyOrders/presentation/controllers/myorders_controller.dart';
import 'package:hcs/features/MyOrders/presentation/controllers/myorders_state.dart';
import 'package:hcs/features/MyOrders/presentation/pages/accepted_orders_section.dart';
import 'package:hcs/features/MyOrders/presentation/pages/canceled_orders_section.dart';
import 'package:hcs/features/MyOrders/presentation/pages/pending_orders_section.dart';
import 'package:hcs/src/manager/app_strings.dart';
import 'package:hcs/src/shared_widgets/custom_appbar.dart';

@RoutePage()
class MyOrdersContentScreen extends ConsumerStatefulWidget {
  const MyOrdersContentScreen({super.key});

  @override
  ConsumerState<MyOrdersContentScreen> createState() => _MyOrdersContentState();
}

class _MyOrdersContentState extends ConsumerState<MyOrdersContentScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(myOrdersControllerProvider.notifier);
    // listen for external changes to the searchQuery in state
    ref.listen<String>(
      myOrdersControllerProvider.select((state) => state.orderSearchedFor),
      (previous, next) {
        if (_searchController.text != next) {
          _searchController
            ..text = next
            ..selection = TextSelection.collapsed(offset: next.length);
        }
      },
    );
    return Scaffold(
      appBar: CustomAppbar(
        hasBackArrow: false,
        title: context.tr(AppStrings.myOrders),
        withTabs: true,
        tabController: _tabController,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: SearchField(
              hintText: "Search Orders...",
              controller: _searchController,

              onFieldSubmitted: (value) => notifier.searchOrder(
                searchedOrder: value,
                tabIndex: _tabController.index,
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                AcceptedOrdersScreen(),
                PendingOrdersScreen(),
                CanceledOrdersScreen(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
