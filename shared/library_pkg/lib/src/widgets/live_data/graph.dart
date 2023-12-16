import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:library_pkg/src/models/live_data_adapter.dart';
import 'package:library_pkg/src/models/live_data_response.dart';
import 'package:library_pkg/src/models/value_range.dart';

class Graph extends StatelessWidget {
  const Graph({
    required this.bloc,
    this.liveData,
    this.maxTime = 60,
    this.divisionCount = 7,
    super.key,
  });

  final LiveDataResponse? liveData;
  final LiveDataAdapter bloc;
  final double maxTime;
  final int divisionCount;

  @override
  Widget build(BuildContext context) {
    final textStyle = GoogleFonts.play(fontSize: 18);

    return Stack(
      children: [
        _Graph(
          liveData: liveData,
          bloc: bloc,
          maxTime: maxTime,
          divisionCount: divisionCount,
        ),
        SizedBox.expand(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, top: 2),
            child: Text(
              bloc.measureInformation(liveData),
              style: textStyle,
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Text(
            't, [s]',
            style: textStyle,
          ),
        ),
      ],
    );
  }
}

class _Graph extends StatefulWidget {
  const _Graph({
    required this.bloc,
    required this.maxTime,
    required this.divisionCount,
    this.liveData,
  });

  final LiveDataResponse? liveData;
  final LiveDataAdapter bloc;
  final double maxTime;
  final int divisionCount;

  @override
  State<_Graph> createState() => _GraphState();
}

class _GraphState extends State<_Graph> {
  List<FlSpot> measureValues = [FlSpot.zero, const FlSpot(60, 0)];
  String? measureType = 'VAC';

  List<HorizontalLine> horizontalLines(ValueRange valueRange, double interval) {
    return [
      for (double i = valueRange.min; i <= valueRange.max; i += interval)
        HorizontalLine(
          y: i,
          color: Colors.white24,
          label: HorizontalLineLabel(
            show: true,
            alignment: Alignment.centerLeft,
            style: GoogleFonts.play(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
          strokeWidth: 1.5,
        ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final LiveDataResponse liveData = widget.liveData!;
    final ValueRange valueRange = widget.bloc.calculateValueRange(liveData);
    final String? measureFunction = liveData.measureType;
    if (measureType != measureFunction) {
      measureType = measureFunction;
      measureValues = [FlSpot.zero, FlSpot(widget.maxTime, 0)];
    }

    return Padding(
      padding: const EdgeInsets.only(
        right: 18,
        left: 18,
        top: 32,
      ),
      child: LineChart(
        mainData(widget.bloc, valueRange),
      ),
    );
  }

  LineChartData mainData(LiveDataAdapter bloc, ValueRange valueRange) {
    final liveData = widget.liveData!;
    final double minOrNull = liveData.min ?? -3;
    final double minValueWithOffset = minOrNull >= 0 ? minOrNull - bloc.offset(liveData) : minOrNull;
    final double maxValue = liveData.max ?? 3;
    final double interval = (valueRange.max - valueRange.min) / (widget.divisionCount - 1);
    if (bloc.isResponseValid(liveData)) {
      measureValues = measureValues.map((obj) => FlSpot(obj.x - 0.5, obj.y)).toList();
      measureValues.add(
        FlSpot(
          60,
          double.parse(
            liveData.value!.toStringAsFixed(liveData.precision ?? 0),
          ),
        ),
      );
      if (measureValues.length > 120) {
        measureValues.removeAt(0);
      }
    }

    return LineChartData(
      lineTouchData: const LineTouchData(getTouchLineStart: defaultGetTouchLineEnd),
      backgroundColor: Colors.black87,
      extraLinesData: ExtraLinesData(
        verticalLines: [
          VerticalLine(
            x: 60,
            color: Colors.greenAccent,
            strokeWidth: 4,
          ),
        ],
        horizontalLines: horizontalLines(valueRange, interval),
      ),
      clipData: const FlClipData.all(),
      gridData: FlGridData(
        horizontalInterval: interval / 5,
        verticalInterval: 5,
        getDrawingHorizontalLine: (value) => const FlLine(
          color: Colors.white12,
          strokeWidth: 1,
        ),
        getDrawingVerticalLine: (value) => const FlLine(
          color: Colors.white12,
          strokeWidth: 1,
        ),
      ),
      titlesData: FlTitlesData(
        topTitles: const AxisTitles(),
        rightTitles: const AxisTitles(),
        leftTitles: const AxisTitles(),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            getTitlesWidget: (value, meta) => Text(
              (widget.maxTime - value).round().toString(),
              style: GoogleFonts.play(
                fontSize: 12,
              ),
            ),
            showTitles: true,
            reservedSize: 35,
            interval: 5,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: Colors.white12),
      ),
      minX: 0,
      maxX: widget.maxTime,
      minY: minValueWithOffset,
      maxY: maxValue,
      lineBarsData: [
        LineChartBarData(
          spots: measureValues,
          barWidth: 2.5,
          color: Colors.white,
          isStrokeCapRound: true,
          dotData: const FlDotData(show: false),
        ),
      ],
    );
  }
}
