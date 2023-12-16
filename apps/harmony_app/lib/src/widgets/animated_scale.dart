import 'package:flutter/material.dart';
import 'package:harmony_app/src/libra_widget/libra_widget.dart';

class ScaleWidget extends StatelessWidget {
  const ScaleWidget({this.highlighted = false, super.key, this.value = 0});

  final bool highlighted;
  final double value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 24,
      ),
      child: SizedBox(
        width: 150,
        height: 150,
        child: LibraWidget(value: value),
      ),
    );
  }
}
