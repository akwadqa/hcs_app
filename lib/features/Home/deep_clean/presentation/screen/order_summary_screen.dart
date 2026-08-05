import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hcs/features/Home/deep_clean/domain/models/service_item_model.dart';
import 'package:hcs/features/Home/deep_clean/presentation/controller/deep_clean_controller.dart';
import 'package:hcs/src/routing/app_router.gr.dart';
import 'package:hcs/src/shared_widgets/custom_appbar.dart';
import 'package:hcs/src/shared_widgets/custom_button.dart';

@RoutePage()
class OrderSummaryScreen extends ConsumerWidget {
  const OrderSummaryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(deepCleanControllerProvider);
    final notifier = ref.read(deepCleanControllerProvider.notifier);
    final services = state.chosenServices;

    return Scaffold(
      appBar: const CustomAppbar(hasBackArrow: true, title: 'Order Summary'),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Selected Services (${services.length})',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            16.verticalSpace,
            Expanded(
              child: ListView.separated(
                itemCount: services.length,
                separatorBuilder: (_, __) => 12.verticalSpace,
                itemBuilder: (context, i) {
                  final s = services[i];
                  return _ServiceItemCard(
                    item: s,
                    qty: state.qtyFor(s.itemCode),
                    onDelete: () => notifier.removeChosenService(s.itemCode),
                  );
                },
              ),
            ),
            12.verticalSpace,
            _TotalsCard(
              totalServices: services.length,
              subtotal: state.subtotal,
              total:
                  state.subtotal, // total = subtotal for now (discount later)
            ),
            16.verticalSpace,
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    title: 'Back',
                    onPressed: () => context.maybePop(),
                    // adjust to your CustomButton variants
                  ),
                ),
                12.horizontalSpace,
                Expanded(
                  child: CustomButton(
                    title: 'Create Order',
                    onPressed: services.isEmpty
                        ? null
                        : () {
                            // Final flow — pick driver & payment
                            context.pushRoute(DriverPaymentRoute());
                          },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ServiceItemCard extends StatelessWidget {
  final ServiceItemModel item;
  final int qty;
  final VoidCallback onDelete;
  const _ServiceItemCard({
    required this.item,
    required this.qty,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).primaryColor;
    final lineTotal = (item.rate ?? 0) * qty;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  item.itemName,
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Text(
                '${lineTotal.toStringAsFixed(0)} QAR',
                style: TextStyle(color: primary, fontWeight: FontWeight.w700),
              ),
            ],
          ),
          8.verticalSpace,
          Row(
            children: [
              Expanded(
                child: Text(
                  qty > 1 ? '${item.itemCode} · ×$qty' : item.itemCode,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 13.sp,
                  ),
                ),
              ),
              InkWell(
                onTap: onDelete,
                child: Padding(
                  padding: EdgeInsets.all(6.w),
                  child: Icon(
                    Icons.delete_outline,
                    color: Colors.red.shade400,
                    size: 22.sp,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TotalsCard extends StatelessWidget {
  final int totalServices;
  final double subtotal;
  final double total;

  const _TotalsCard({
    required this.totalServices,
    required this.subtotal,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).primaryColor;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        children: [
          _row(
            icon: Icons.description_outlined,
            label: 'Total Services',
            trailing: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.h),
              decoration: BoxDecoration(
                color: primary.withOpacity(.1),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Text(
                '$totalServices',
                style: TextStyle(color: primary, fontWeight: FontWeight.w700),
              ),
            ),
          ),
          8.verticalSpace,
          _row(
            icon: Icons.local_offer_outlined,
            label: 'Subtotal',
            trailing: Text(
              '${subtotal.toStringAsFixed(0)} QAR',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14.sp),
            ),
          ),
          const Divider(height: 20),
          _row(
            icon: Icons.credit_card,
            label: 'Total Amount',
            labelBold: true,
            trailing: Text(
              '${total.toStringAsFixed(0)} QAR',
              style: TextStyle(
                color: primary,
                fontWeight: FontWeight.w800,
                fontSize: 16.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _row({
    required IconData icon,
    required String label,
    bool labelBold = false,
    required Widget trailing,
  }) {
    return Builder(
      builder: (context) {
        final primary = Theme.of(context).primaryColor;
        return Row(
          children: [
            Container(
              padding: EdgeInsets.all(6.w),
              decoration: BoxDecoration(
                color: primary.withOpacity(.1),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Icon(icon, size: 18.sp, color: primary),
            ),
            10.horizontalSpace,
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: labelBold ? FontWeight.w700 : FontWeight.w500,
                  color: labelBold ? Colors.black : Colors.grey.shade700,
                ),
              ),
            ),
            trailing,
          ],
        );
      },
    );
  }
}
