import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:hcs/src/enums/orders_status_enums.dart';

Future<OrderStatus?> showStatusFilterMenu(BuildContext context) {
  return showGeneralDialog<OrderStatus>(
    context: context,
    barrierDismissible: true,
    barrierLabel: "",
    barrierColor: Colors.black.withOpacity(0.2),

    transitionDuration: const Duration(milliseconds: 250),

    pageBuilder: (_, __, ___) {
      return const SizedBox.shrink();
    },

    transitionBuilder: (context, animation, secondary, child) {
      final curved = CurvedAnimation(
        parent: animation,
        curve: Curves.easeOutCubic,
      );

      return Stack(
        children: [
          // BLUR BACKGROUND
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

          // ANIMATED DROPDOWN
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
                child: Material(
                  borderRadius: BorderRadius.circular(12),
                  elevation: 10,
                  color: Colors.white,
                  child: Container(
                    width: 180,
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: OrderStatus.values.map((status) {
                        return _statusItem(context, status);
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    },
  );
}

Widget _statusItem(BuildContext context,OrderStatus status) {
  return InkWell(
    onTap: () {
      Navigator.pop(context, status);
    },
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          status.label,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
      ),
    ),
  );
}
