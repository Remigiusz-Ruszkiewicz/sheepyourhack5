import 'package:flutter/material.dart';
import 'package:harmony_app/src/libra_widget/libra_widget.dart';

class ScaleWidget extends StatelessWidget {
  const ScaleWidget({this.highlighted = false, super.key, this.value = 0});

  final bool highlighted;
  final double value;

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: highlighted ? 1.075 : 1.0,
      child: Material(
        elevation: highlighted ? 8 : 4,
        borderRadius: BorderRadius.circular(22),
        color: highlighted ? const Color(0xFFF64209) : Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 24,
          ),
          child: ClipOval(
            child: SizedBox(
              width: 150,
              height: 146,
              child: LibraWidget(value: value),
            ),
          ),
        ),
      ),
    );
  }
}
