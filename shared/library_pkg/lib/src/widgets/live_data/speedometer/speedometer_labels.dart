import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:library_pkg/src/constants/regex_patterns.dart';
import 'package:library_pkg/src/models/value_range.dart';
import 'package:library_pkg/src/widgets/live_data/speedometer/speedometer_bloc.dart';
import 'package:library_pkg/src/widgets/live_data/speedometer/speedometer_model.dart';

class SpeedometerLabels extends StatelessWidget {
  const SpeedometerLabels({
    required this.speedometerBloc,
    required this.radius,
    required this.arc,
    required this.mainDivisions,
    required this.valueRange,
    super.key,
  });

  final SpeedometerBloc speedometerBloc;
  final double radius;
  final Arc arc;
  final Divisions mainDivisions;
  final ValueRange valueRange;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _SpeedometerLabelsPainter(
        bloc: speedometerBloc,
        radius: radius,
        arc: arc,
        mainDivisions: mainDivisions,
        valueRange: valueRange,
      ),
    );
  }
}

class _SpeedometerLabelsPainter extends CustomPainter {
  const _SpeedometerLabelsPainter({
    required this.bloc,
    required this.radius,
    required this.arc,
    required this.mainDivisions,
    required this.valueRange,
  });

  final SpeedometerBloc bloc;
  final double radius;
  final Arc arc;
  final Divisions mainDivisions;
  final ValueRange valueRange;

  @override
  void paint(Canvas canvas, Size size) {
    final int divisionsCount = mainDivisions.divisionCount;
    final double divisionsInterval = (valueRange.max - valueRange.min) / (divisionsCount - 1);

    for (int i = 0; i < divisionsCount; i++) {
      final angle = arc.startAngle + (i * arc.sweepAngle / (divisionsCount - 1));
      final label =
          (valueRange.min + (i * divisionsInterval)).toString().replaceAll(RegExp(RegexPatterns.labelRegexPattern), '');

      final textPainter = TextPainter(
        text: TextSpan(
          text: label,
          style: GoogleFonts.play(
            color: Colors.black54,
            fontSize: radius / 9,
            fontWeight: FontWeight.bold,
          ),
        ),
        textDirection: ui.TextDirection.ltr,
      )..layout();

      final divisionLineEndPoint = bloc.calculateEndPoint(
        start: bloc.calculateStartPoint(radius, angle),
        length: mainDivisions.divisionLength,
        angle: angle,
      );

      final labelPosition = bloc.calculateEndPoint(
        start: divisionLineEndPoint,
        length: radius / 10,
        angle: angle,
      );

      canvas
        ..save()
        ..translate(labelPosition.dx, labelPosition.dy)
        ..rotate(angle - 3 * pi / 2)
        ..translate(-textPainter.width / 2, -textPainter.height / 2);
      textPainter.paint(canvas, Offset.zero);
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
