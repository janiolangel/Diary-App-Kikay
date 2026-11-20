import 'package:flutter/material.dart';
import 'theme.dart';

class PixelBox extends StatelessWidget {
  final Widget child;
  final Color color;
  final double px;
  const PixelBox({
    super.key,
    required this.child,
    this.color = AppColors.bubblegum,
    this.px = 4,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _PixelPainter(color, px),
      child: Padding(
        padding: EdgeInsets.fromLTRB(px * 4, px * 4, px * 5, px * 5),
        child: child,
      ),
    );
  }
}

class _PixelPainter extends CustomPainter {
  final Color color;
  final double px;
  _PixelPainter(this.color, this.px);

  Path _shape(Rect r) {
    final p = px;
    return Path()
      ..moveTo(r.left + 2 * p, r.top)
      ..lineTo(r.right - 2 * p, r.top)
      ..lineTo(r.right - 2 * p, r.top + p)
      ..lineTo(r.right - p, r.top + p)
      ..lineTo(r.right - p, r.top + 2 * p)
      ..lineTo(r.right, r.top + 2 * p)
      ..lineTo(r.right, r.bottom - 2 * p)
      ..lineTo(r.right - p, r.bottom - 2 * p)
      ..lineTo(r.right - p, r.bottom - p)
      ..lineTo(r.right - 2 * p, r.bottom - p)
      ..lineTo(r.right - 2 * p, r.bottom)
      ..lineTo(r.left + 2 * p, r.bottom)
      ..lineTo(r.left + 2 * p, r.bottom - p)
      ..lineTo(r.left + p, r.bottom - p)
      ..lineTo(r.left + p, r.bottom - 2 * p)
      ..lineTo(r.left, r.bottom - 2 * p)
      ..lineTo(r.left, r.top + 2 * p)
      ..lineTo(r.left + p, r.top + 2 * p)
      ..lineTo(r.left + p, r.top + p)
      ..lineTo(r.left + 2 * p, r.top + p)
      ..close();
  }

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width - px, size.height - px);
    canvas.drawPath(_shape(rect.shift(Offset(px, px))), Paint()..color = AppColors.cocoa);
    canvas.drawPath(_shape(rect), Paint()..color = color);
    canvas.drawPath(
      _shape(rect),
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = px / 2
        ..color = AppColors.cocoa,
    );
  }

  @override
  bool shouldRepaint(covariant _PixelPainter old) => old.color != color || old.px != px;
}