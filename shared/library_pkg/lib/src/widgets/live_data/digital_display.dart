import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:library_pkg/src/constants/live_data_constants.dart';
import 'package:library_pkg/src/models/live_data_adapter.dart';
import 'package:library_pkg/src/models/live_data_response.dart';
import 'package:segment_display/segment_display.dart';

class DigitalDisplay extends StatelessWidget {
  const DigitalDisplay({
    required this.bloc,
    this.liveData,
    super.key,
  });

  final LiveDataResponse? liveData;
  final LiveDataAdapter bloc;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final bool isValidResponse = bloc.isResponseValid(liveData);
    final TextStyle textStyle = GoogleFonts.play(color: Colors.grey, fontSize: 50);

    return ColoredBox(
      color: Colors.black87,
      child: Column(
        children: [
          Expanded(
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SevenSegmentDisplay(
                    value: isValidResponse
                        ? liveData!.value!.toStringAsFixed(liveData!.precision ?? 0)
                        : LiveDataConstants.digitalDisplayPlaceholder,
                    size: min(size.width, size.height) / 50,
                    backgroundColor: Colors.transparent,
                    segmentStyle: const HexSegmentStyle(
                      enabledColor: Colors.white70,
                      disabledColor: Colors.transparent,
                      segmentBaseSize: Size(1, 4),
                    ),
                  ),
                  if (isValidResponse)
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: AutoSizeText(
                        '${liveData!.prefix}${liveData!.unit}',
                        maxLines: 1,
                        style: textStyle,
                      ),
                    ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: AutoSizeText(
                bloc.measureInformation(liveData),
                maxLines: 1,
                style: textStyle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
