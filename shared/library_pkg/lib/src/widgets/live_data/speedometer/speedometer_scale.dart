/*
 * Copyright © 2023 Gossen Metrawatt GmbH
 * All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:library_pkg/src/models/value_range.dart';
import 'package:library_pkg/src/widgets/live_data/speedometer/speedometer_bloc.dart';
import 'package:library_pkg/src/widgets/live_data/speedometer/speedometer_model.dart';

class SpeedometerScale extends StatelessWidget {
  const SpeedometerScale({
    required this.speedometerBloc,
    required this.radius,
    required this.arc,
    required this.mainDivisions,
    required this.secondaryDivisions,
    required this.edgeOffset,
    required this.valueRange,
    super.key,
    this.mainDivisionPaint,
    this.secondaryDivisionPaint,
  });

  final SpeedometerBloc speedometerBloc;
  final double radius;
  final Arc arc;
  final Divisions mainDivisions;
  final Divisions secondaryDivisions;
  final double edgeOffset;
  final ValueRange valueRange;
  final Paint? mainDivisionPaint;
  final Paint? secondaryDivisionPaint;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _SpeedometerScalePainter(
        speedometerBloc: speedometerBloc,
        radius: radius,
        arc: arc,
        valueRange: valueRange,
        mainDivisions: mainDivisions,
        secondaryDivisions: secondaryDivisions,
        edgeOffset: edgeOffset,
        mainDivisionPaint: mainDivisionPaint,
        secondaryDivisionPaint: secondaryDivisionPaint,
      ),
    );
  }
}

class _SpeedometerScalePainter extends CustomPainter {
  const _SpeedometerScalePainter({
    required this.speedometerBloc,
    required this.radius,
    required this.arc,
    required this.mainDivisions,
    required this.secondaryDivisions,
    required this.edgeOffset,
    required this.valueRange,
    this.mainDivisionPaint,
    this.secondaryDivisionPaint,
  });

  final SpeedometerBloc speedometerBloc;
  final double radius;
  final Arc arc;
  final Divisions mainDivisions;
  final Divisions secondaryDivisions;
  final double edgeOffset;
  final ValueRange valueRange;
  final Paint? mainDivisionPaint;
  final Paint? secondaryDivisionPaint;

  @override
  void paint(Canvas canvas, Size _) {
    final divisionAngle = arc.sweepAngle / (mainDivisions.divisionCount - 1);
    final secondaryDivisionAngle = divisionAngle / (secondaryDivisions.divisionCount + 1);
    final Arc arcWithOffset = speedometerBloc.calculateArcParametersWithOffset(valueRange, edgeOffset, arc);

    for (int i = 0; i < mainDivisions.divisionCount; i++) {
      speedometerBloc.drawDivision(
        canvas,
        radius,
        arc.startAngle + (i * divisionAngle),
        mainDivisions.divisionLength,
      );
    }

    for (int i = 0; i < mainDivisions.divisionCount - 1; i++) {
      for (int j = 1; j <= secondaryDivisions.divisionCount; j++) {
        speedometerBloc.drawDivision(
          canvas,
          radius,
          arc.startAngle + (i * divisionAngle) + (j * secondaryDivisionAngle),
          secondaryDivisions.divisionLength,
        );
      }
    }

    canvas
      ..drawArc(
        Rect.fromCircle(center: Offset(radius, radius), radius: radius),
        arcWithOffset.startAngle,
        arcWithOffset.sweepAngle,
        false,
        Paint()
          ..color = Colors.black87
          ..style = PaintingStyle.stroke
          ..strokeWidth = 3,
      )
      ..clipRect(Rect.fromLTWH(0, 0, radius * 2, 3 / 2 * radius));
  }

  @override
  bool shouldRepaint(covariant _SpeedometerScalePainter oldDelegate) {
    return oldDelegate.radius != radius ||
        oldDelegate.arc != arc ||
        oldDelegate.mainDivisions != mainDivisions ||
        oldDelegate.secondaryDivisions != secondaryDivisions ||
        oldDelegate.edgeOffset != edgeOffset ||
        oldDelegate.valueRange != valueRange;
  }
}
