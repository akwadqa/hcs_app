import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddAnotherServiceButton extends StatelessWidget {
  final VoidCallback onTap;
  const AddAnotherServiceButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).primaryColor;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8.r),
      child: DottedBorderBox(
        color: color,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 14.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add_circle_outline, color: color, size: 20.sp),
              8.horizontalSpace,
              Text(
                'Add Another Service',
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.w600,
                  fontSize: 14.sp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Simple dashed border container (no extra deps).
class DottedBorderBox extends StatelessWidget {
  final Widget child;
  final Color color;
  const DottedBorderBox({super.key, required this.child, required this.color});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DashedBorderPainter(color: color),
      child: child,
    );
  }
}

class _DashedBorderPainter extends CustomPainter {
  final Color color;
  _DashedBorderPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    const dash = 6.0;
    const gap = 4.0;
    final rrect = RRect.fromRectAndRadius(
      Offset.zero & size,
      const Radius.circular(8),
    );

    final path = Path()..addRRect(rrect);
    final metrics = path.computeMetrics().toList();
    for (final m in metrics) {
      double d = 0;
      while (d < m.length) {
        final next = d + dash;
        canvas.drawPath(
          m.extractPath(d, next.clamp(0, m.length)),
          paint,
        );
        d = next + gap;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}