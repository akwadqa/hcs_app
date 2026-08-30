import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hcs/features/Home/Employees/presentation/widgets/search_field.dart';
import 'package:hcs/features/MyOrders/presentation/controllers/custom_date_orders_controller.dart';
import 'package:hcs/features/MyOrders/presentation/controllers/myorders_controller.dart';
import 'package:hcs/features/MyOrders/presentation/pages/today_orders_section.dart';
import 'package:hcs/features/MyOrders/presentation/pages/tomorrow_orders_section.dart';
import 'package:hcs/features/MyOrders/presentation/pages/custom_order_date_widget.dart';
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
  DateTime? _pickedDate;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this,initialIndex: 1);
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }
  Future<void> _handleTabTap(int index) async {
    if (index != 0) return; // only for "Pick date"

    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      firstDate: DateTime(now.year - 2),
      lastDate: DateTime(now.year + 2),
      initialDate: _pickedDate ?? now,
    );

    if (picked == null) {
      // user canceled; return to the previous tab
      _tabController.index = _tabController.previousIndex;
      return;
    }

    // format as yyyy-MM-dd for API
    final selected = DateTime(picked.year, picked.month, picked.day);
    setState(() => _pickedDate = selected);

    // call API
    final dateStr =
        "${selected.year.toString().padLeft(4, '0')}-"
        "${selected.month.toString().padLeft(2, '0')}-"
        "${selected.day.toString().padLeft(2, '0')}";

    // ask controller to fetch custom-date orders
    final notifier = ref.read(customDateOrdersControllerProvider.notifier);
    await notifier.fetchOrdersForDate(date: dateStr);

    // stay on the "Custom" tab to show results (index 3)
    _tabController.index = 0;
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(myOrdersControllerProvider.notifier);
    //TODO :
    // // listen for external changes to the searchQuery in state
    // ref.listen<String>(
    //   myOrdersControllerProvider.select((state) => state.orderSearchedFor),
    //   (previous, next) {
    //     if (_searchController.text != next) {
    //       _searchController
    //         ..text = next
    //         ..selection = TextSelection.collapsed(offset: next.length);
    //     }
    //   },
    // );
    return Scaffold(
      appBar: CustomAppbar(
        hasBackArrow: false,
        title: context.tr(AppStrings.myOrders),
        withTabs: true,
        withouTitle: true,
        onTabTap: _handleTabTap,

        tabController: _tabController,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: SearchField(
              hintText: "Search Orders...",
              controller: _searchController,
tabIndex: _tabController.index,
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
                CustomDateOrdersScreen(),

                AcceptedOrdersScreen(),
                // PendingOrdersScreen(),
                CanceledOrdersScreen(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
