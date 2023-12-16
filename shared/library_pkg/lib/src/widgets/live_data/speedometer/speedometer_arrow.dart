import 'package:flutter/material.dart';

class SpeedometerArrow extends StatelessWidget {
  const SpeedometerArrow({
    required this.angle,
    required this.radius,
    super.key,
  });

  final double angle;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: angle,
      child: CustomPaint(
        size: Size(radius * 2, radius * 2),
        painter: _ArrowPainter(radius: radius),
      ),
    );
  }
}

class _ArrowPainter extends CustomPainter {
  _ArrowPainter({required this.radius});

  final double radius;

  @override
  void paint(Canvas canvas, Size size) {
    final double arrowSmallLever = radius / 4;
    final double arrowStartWidth = radius / 28;
    const arrowEndWidth = 1;
    final double arrowOverhang = radius / 30;
    final Path path = Path()
      ..moveTo(radius - arrowSmallLever, radius)
      ..lineTo(radius - arrowSmallLever + arrowStartWidth, radius - arrowStartWidth)
      ..lineTo(radius * 2 + arrowOverhang, radius - arrowEndWidth)
      ..lineTo(radius * 2 + arrowOverhang, radius + arrowEndWidth)
      ..lineTo(radius - arrowSmallLever + arrowStartWidth, radius + arrowStartWidth)
      ..close();

    canvas
      ..drawPath(
        path,
        Paint()..color = Colors.red,
      )
      ..drawCircle(
        Offset(radius, radius),
        radius / 15,
        Paint()
          ..color = Colors.red
          ..style = PaintingStyle.fill,
      )
      ..drawCircle(
        Offset(radius, radius),
        radius / 30,
        Paint()
          ..color = const Color.fromARGB(255, 146, 10, 10)
          ..style = PaintingStyle.fill,
      )
      ..translate(radius, radius);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
