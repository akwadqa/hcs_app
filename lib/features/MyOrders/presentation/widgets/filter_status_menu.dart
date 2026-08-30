import 'dart:ui';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hcs/features/MyOrders/presentation/controllers/myorders_controller.dart';
import 'package:hcs/src/enums/orders_status_enums.dart';
import 'package:hcs/src/enums/shift_type_enum.dart';
import 'package:hcs/src/shared_widgets/custom_button.dart';

// Future<OrderFilter?> showStatusFilterMenu(BuildContext context) {
//   return showGeneralDialog<OrderFilter>(
//     context: context,
//     barrierDismissible: true,
//     barrierLabel: "",
//     barrierColor: Colors.black.withOpacity(0.2),

//     transitionDuration: const Duration(milliseconds: 250),

//     pageBuilder: (_, __, ___) {
//       return const SizedBox.shrink();
//     },

//     transitionBuilder: (context, animation, secondary, child) {
//       final curved = CurvedAnimation(
//         parent: animation,
//         curve: Curves.easeOutCubic,
//       );

//       return
//       //       Column(
//       //   crossAxisAlignment: CrossAxisAlignment.start,
//       //   children: [
//       //     // STATUS SECTION
//       //     Padding(
//       //       padding: const EdgeInsets.all(12),
//       //       child: Text("Status", style: TextStyle(fontWeight: FontWeight.bold)),
//       //     ),
//       //     ...OrderStatus.values.map((status) => _statusItem(context, status)),
//       //     Divider(),
//       //     // SHIFT TYPE SECTION
//       //     Padding(
//       //       padding: const EdgeInsets.all(12),
//       //       child: Text("Shift Type", style: TextStyle(fontWeight: FontWeight.bold)),
//       //     ),
//       //     ...ShiftTypeEnum.values.map((shift) => _shiftItem(...)),
//       //     Divider(),
//       //     // APPLY BUTTON
//       //     TextButton(
//       //       onPressed: () {
//       //         Navigator.pop(context, OrderFilter(
//       //           status: selectedStatus,
//       //           shiftType: selectedShift,
//       //         ));
//       //       },
//       //       child: Text("Apply"),
//       //     )
//       //   ],
//       // );
//       Stack(
//         children: [
//           // BLUR BACKGROUND
//           Positioned.fill(
//             child: GestureDetector(
//               onTap: () => Navigator.of(context).pop(),
//               child: BackdropFilter(
//                 filter: ImageFilter.blur(
//                   sigmaX: 3 * animation.value,
//                   sigmaY: 3 * animation.value,
//                 ),
//                 child: Container(color: Colors.black12),
//               ),
//             ),
//           ),

//           // ANIMATED DROPDOWN
//           Positioned(
//             top: kToolbarHeight + 80,
//             right: 20,
//             child: FadeTransition(
//               opacity: curved,
//               child: SlideTransition(
//                 position: Tween<Offset>(
//                   begin: const Offset(0, -0.1),
//                   end: Offset.zero,
//                 ).animate(curved),
//                 child: Material(
//                   borderRadius: BorderRadius.circular(12),
//                   elevation: 10,
//                   color: Colors.white,
//                   child: Container(
//                     width: 180,
//                     padding: const EdgeInsets.symmetric(vertical: 6),
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: OrderStatus.values.map((status) {
//                         return _statusItem(context, status);
//                       }).toList(),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       );
//     },
//   );
// }

// Widget _statusItem(BuildContext context, OrderStatus status) {
//   return InkWell(
//     onTap: () {
//       Navigator.pop(context, status);
//     },
//     child: Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//       child: Align(
//         alignment: Alignment.centerLeft,
//         child: Text(
//           status.label,
//           style: const TextStyle(
//             fontSize: 15,
//             fontWeight: FontWeight.w500,
//             color: Colors.black87,
//           ),
//         ),
//       ),
//     ),
//   );
// }

Future<void> showOrderFilterMenu(
  BuildContext context,
  WidgetRef ref,
  int tabIndex,
) {
  return showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: "",
    barrierColor: Colors.black.withOpacity(0.2),
    transitionDuration: const Duration(milliseconds: 250),
    pageBuilder: (_, __, ___) => const SizedBox.shrink(),
    transitionBuilder: (context, animation, secondary, child) {
      final curved = CurvedAnimation(
        parent: animation,
        curve: Curves.easeOutCubic,
      );

      return Stack(
        children: [
          // Blur Background
          Positioned.fill(
            child: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 3 * animation.value,
                  sigmaY: 3 * animation.value,
                ),
                child: Container(color: Colors.black12),
              ),
            ),
          ),

          // Filter Panel
          Positioned(
            top: kToolbarHeight + 80,
            right: 20,
            child: FadeTransition(
              opacity: curved,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, -0.1),
                  end: Offset.zero,
                ).animate(curved),
                child: Consumer(
                  builder: (context, ref, _) {
                    ref.watch(myOrdersControllerProvider);

                    // 👇 This reads current filter
                    final controller = ref.read(
                      myOrdersControllerProvider.notifier,
                    );

                    final filter = controller.filter;
                    debugPrint("Current filter: ${filter.status} - ${filter.shiftType}");

                    return Material(
                      borderRadius: BorderRadius.circular(16),
                      elevation: 12,
                      color: Colors.white,
                      child: Container(
                        width: 260,
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /// STATUS SECTION
                            const Text(
                              "Status",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 8),

                            ...OrderStatus.values.map((status) {
                              return _radioItem<OrderStatus>(
                                title: status.label,
                                value: status,
                                groupValue: filter.status,
                                onChanged: (value) {
                                  controller.updateStatus(value);
                                },
                              );
                            }),

                            const Divider(height: 24),

                            /// SHIFT TYPE SECTION
                            const Text(
                              "Shift Type",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 8),

                            ...ShiftTypeEnum.values.map((shift) {
                              return _radioItem<ShiftTypeEnum>(
                                title: shift.label,
                                value: shift,
                                groupValue: filter.shiftType,
                                onChanged: (value) {
                                  controller.updateShiftType(value);
                                },
                              );
                            }),

                            const SizedBox(height: 16),

                            /// ACTION BUTTONS
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: TextButton(
                                    onPressed: () {
                                      controller.clearFilters();
                                    },
                                    child: const Text("Clear"),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: CustomButton(
                                    title: "apply".tr(),
                                    onPressed: () {
                                      controller.applyFilters(
                                        tabIndex: tabIndex,
                                      );
                                      Navigator.pop(context);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      );
    },
  );
}

Widget _radioItem<T>({
  required String title,
  required T value,
  required T? groupValue,
  required ValueChanged<T?> onChanged,
}) {
  return InkWell(
    onTap: () => onChanged(value),
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Radio<T>(value: value, groupValue: groupValue, onChanged: onChanged),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    ),
  );
}
