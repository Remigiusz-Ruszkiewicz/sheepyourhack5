import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:library_pkg/src/models/live_data_adapter.dart';
import 'package:library_pkg/src/models/live_data_response.dart';
import 'package:library_pkg/src/models/value_range.dart';
import 'package:library_pkg/src/widgets/live_data/speedometer/speedometer_arrow.dart';
import 'package:library_pkg/src/widgets/live_data/speedometer/speedometer_bloc.dart';
import 'package:library_pkg/src/widgets/live_data/speedometer/speedometer_labels.dart';
import 'package:library_pkg/src/widgets/live_data/speedometer/speedometer_measure_type.dart';
import 'package:library_pkg/src/widgets/live_data/speedometer/speedometer_model.dart';
import 'package:library_pkg/src/widgets/live_data/speedometer/speedometer_scale.dart';
import 'package:segment_display/segment_display.dart';

class Speedometer extends StatelessWidget {
  const Speedometer({
    required this.bloc,
    this.liveData,
    this.startAngle = 9 * pi / 8,
    this.sweepAngle = 6 * pi / 8,
    this.mainDivisionCount = 7,
    super.key,
    this.secondaryDivisionCount = 4,
    this.mainDivisionPaint,
    this.secondaryDivisionPaint,
  });

  final LiveDataResponse? liveData;
  final LiveDataAdapter bloc;
  final double startAngle;
  final double sweepAngle;
  final int mainDivisionCount;
  final int secondaryDivisionCount;
  final Paint? mainDivisionPaint;
  final Paint? secondaryDivisionPaint;

  @override
  Widget build(BuildContext context) {
    const SpeedometerBloc speedometerBloc = SpeedometerBloc();
    final Arc arc = Arc(startAngle, sweepAngle);
    final bool isResponseValid = bloc.isResponseValid(liveData);

    return LayoutBuilder(
      builder: (context, constraints) {
        final double radius = min(constraints.maxWidth, constraints.maxHeight) / 2.4;
        return ColoredBox(
          color: Colors.white,
          child: Stack(
            children: [
              Align(
                alignment: constraints.maxWidth > constraints.maxHeight ? Alignment.bottomCenter : Alignment.center,
                child: _Speedometer(
                  bloc: bloc,
                  speedometerBloc: speedometerBloc,
                  radius: radius,
                  arc: arc,
                  mainDivisions: Divisions(mainDivisionCount, radius / 20),
                  secondaryDivisions: Divisions(secondaryDivisionCount, radius / 50),
                  isResponseValid: isResponseValid,
                  liveData: liveData,
                  mainDivisionPaint: mainDivisionPaint,
                  secondaryDivisionPaint: secondaryDivisionPaint,
                ),
              ),
              _NumericDisplay(bloc: bloc, liveData: liveData, size: 5),
            ],
          ),
        );
      },
    );
  }
}

class _Speedometer extends StatelessWidget {
  const _Speedometer({
    required this.bloc,
    required this.speedometerBloc,
    required this.radius,
    required this.arc,
    required this.mainDivisions,
    required this.secondaryDivisions,
    required this.isResponseValid,
    this.liveData,
    this.mainDivisionPaint,
    this.secondaryDivisionPaint,
  });

  final LiveDataAdapter bloc;
  final SpeedometerBloc speedometerBloc;
  final double radius;
  final Arc arc;
  final Divisions mainDivisions;
  final Divisions secondaryDivisions;
  final LiveDataResponse? liveData;
  final Paint? mainDivisionPaint;
  final Paint? secondaryDivisionPaint;
  final bool isResponseValid;

  @override
  Widget build(BuildContext context) {
    final double edgeOffset = bloc.offset(liveData!);
    final ValueRange valueRange = bloc.calculateValueRange(liveData!);
    return Stack(
      children: [
        SpeedometerScale(
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
        if (isResponseValid)
          SpeedometerLabels(
            speedometerBloc: speedometerBloc,
            radius: radius,
            valueRange: valueRange,
            arc: arc,
            mainDivisions: mainDivisions,
          ),
        SpeedometerMeasureType(
          radius: radius,
          measureType: bloc.measureInformation(liveData),
        ),
        SpeedometerArrow(
          angle: speedometerBloc.calculateRotationAngle(
            liveData,
            valueRange,
            arc,
            edgeOffset,
            isResponseValid: isResponseValid,
          ),
          radius: radius,
        ),
      ],
    );
  }
}

class _NumericDisplay extends StatelessWidget {
  const _NumericDisplay({
    required this.bloc,
    required this.size,
    this.liveData,
  });

  final LiveDataAdapter bloc;
  final LiveDataResponse? liveData;
  final double size;

  @override
  Widget build(BuildContext build) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              style: GoogleFonts.play(
                color: Colors.grey,
              ),
              liveData?.measureType != null ? '${liveData!.measureType}, ${liveData!.prefix}${liveData!.unit}' : '',
            ),
            SevenSegmentDisplay(
              value:
                  bloc.isResponseValid(liveData) ? liveData!.value!.toStringAsFixed(liveData!.precision ?? 0) : '-.--',
              size: size,
              backgroundColor: Colors.transparent,
              segmentStyle: const HexSegmentStyle(
                enabledColor: Colors.black45,
                disabledColor: Colors.transparent,
                segmentBaseSize: Size(1, 5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
