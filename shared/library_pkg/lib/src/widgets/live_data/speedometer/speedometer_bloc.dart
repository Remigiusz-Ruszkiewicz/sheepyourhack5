/*
 * Copyright © 2023 Gossen Metrawatt GmbH
 * All rights reserved.
 */

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:library_pkg/src/models/live_data_response.dart';
import 'package:library_pkg/src/models/value_range.dart';
import 'package:library_pkg/src/widgets/live_data/speedometer/speedometer_model.dart';

class SpeedometerBloc {
  const SpeedometerBloc();

  Offset calculateStartPoint(double radius, double angle) {
    final startX = radius * (1 + cos(angle));
    final startY = radius * (1 + sin(angle));
    return Offset(startX, startY);
  }

  Offset calculateEndPoint({
    required Offset start,
    required double length,
    required double angle,
  }) {
    final endX = start.dx + length * cos(angle);
    final endY = start.dy + length * sin(angle);
    return Offset(endX, endY);
  }

  double calculateRotationAngle(
    LiveDataResponse? liveData,
    ValueRange valueRange,
    Arc arc,
    double edgeOffset, {
    required bool isResponseValid,
  }) {
    final Arc arcParametersWithOffset = calculateArcParametersWithOffset(valueRange, edgeOffset, arc);
    final startAngle = arcParametersWithOffset.startAngle;
    final sweepAngle = arcParametersWithOffset.sweepAngle;
    if (!isResponseValid || liveData!.measureType == null) {
      return startAngle;
    }
    final normalizedValue =
        (liveData.value! - valueRange.min + edgeOffset) / (valueRange.max + 2 * edgeOffset - valueRange.min);
    final angle = startAngle + normalizedValue * sweepAngle;
    return angle.clamp(startAngle, startAngle + sweepAngle);
  }

  Arc calculateArcParametersWithOffset(
    ValueRange valueRange,
    double edgeOffset,
    Arc arc,
  ) {
    final shiftedMaxValue = valueRange.max + (valueRange.min < 0 ? -valueRange.min : valueRange.min);
    final valueOffsetToAngle = (shiftedMaxValue + 2 * edgeOffset) * arc.sweepAngle / shiftedMaxValue;
    final edgeAngleOffset = (valueOffsetToAngle - arc.sweepAngle) / 2;
    final startAngleWithOffset = arc.startAngle - edgeAngleOffset;
    final sweepAngleWithOffset = arc.sweepAngle + 2 * edgeAngleOffset;
    return Arc(startAngleWithOffset, sweepAngleWithOffset);
  }

  void drawDivision(
    Canvas canvas,
    double radius,
    double divisionAngle,
    double divisionLength, [
    Paint? divisionPaint,
  ]) {
    final startPoint = calculateStartPoint(radius, divisionAngle);
    final endPoint = calculateEndPoint(start: startPoint, length: divisionLength, angle: divisionAngle);

    canvas.drawLine(
      startPoint,
      endPoint,
      divisionPaint ?? Paint()
        ..color = Colors.black87
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2
        ..strokeCap = StrokeCap.round,
    );
  }
}
