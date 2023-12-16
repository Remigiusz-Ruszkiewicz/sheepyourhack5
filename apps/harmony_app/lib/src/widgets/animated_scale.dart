import 'package:flutter/material.dart';

class ScaleWidget extends StatelessWidget {
  const ScaleWidget({this.highlighted = false, super.key});

  final bool highlighted;

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: highlighted ? 1.075 : 1.0,
      child: Material(
        elevation: highlighted ? 8 : 4,
        borderRadius: BorderRadius.circular(22),
        color: highlighted ? const Color(0xFFF64209) : Colors.white,
        child: const Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipOval(
                child: SizedBox(
                  width: 146,
                  height: 146,
                  child: Placeholder(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
