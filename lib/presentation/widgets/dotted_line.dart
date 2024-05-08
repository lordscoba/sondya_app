import 'package:flutter/material.dart';

class DottedVerticalLine extends StatelessWidget {
  final double height;
  final Color color;
  final double thickness;
  final double spacing;

  const DottedVerticalLine({
    super.key,
    required this.height,
    this.color = Colors.black,
    this.thickness = 1.0,
    this.spacing = 5.0,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(thickness, height),
      painter: DottedLinePainter(color, thickness, spacing),
    );
  }
}

class DottedLinePainter extends CustomPainter {
  final Color color;
  final double thickness;
  final double spacing;

  DottedLinePainter(this.color, this.thickness, this.spacing);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = thickness
      ..strokeCap = StrokeCap.round;

    final double dashHeight = spacing;
    final double dashSpace = spacing;

    double startY = 0.0;
    while (startY < size.height) {
      canvas.drawLine(Offset(size.width / 2, startY),
          Offset(size.width / 2, startY + dashHeight), paint);
      startY += dashHeight + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
