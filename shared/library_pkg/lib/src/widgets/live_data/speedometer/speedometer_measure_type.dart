import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SpeedometerMeasureType extends StatelessWidget {
  const SpeedometerMeasureType({
    required this.radius,
    required this.measureType,
    super.key,
  });

  final double radius;
  final String measureType;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _SpeedometerMeasureTypePainter(radius: radius, measureType: measureType),
    );
  }
}

class _SpeedometerMeasureTypePainter extends CustomPainter {
  _SpeedometerMeasureTypePainter({
    required this.radius,
    required this.measureType,
  }) : textStyle = GoogleFonts.play(
          color: Colors.black,
          fontSize: radius / 5,
        );

  final double radius;
  final String measureType;
  final TextStyle textStyle;

  @override
  void paint(Canvas canvas, Size size) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: measureType,
        style: textStyle,
      ),
      textDirection: ui.TextDirection.ltr,
    )..layout();

    final offset = Offset(radius - textPainter.width / 2, radius / 2 - textPainter.height / 2);
    textPainter.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(covariant _SpeedometerMeasureTypePainter oldDelegate) {
    return oldDelegate.radius != radius || oldDelegate.measureType != measureType;
  }
}
