import 'package:flutter/material.dart';

class LibraWidget extends StatelessWidget {
  const LibraWidget({required this.value, super.key});

  final double value;

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 1.8,
      child: Center(
        child: Stack(
          alignment: AlignmentDirectional.topCenter,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 4, top: 42),
              child: _AnimatedBuilder(
                transform: Matrix4.rotationZ(value * (3.14159 / 180.0)),
                child: const _LibraWidget('assets/libra/wage_bar.png', width: 105),
              ),
            ),
            Positioned(
              left: 28,
              top: 20,
              child: _AnimatedBuilder(
                transform: Matrix4.translationValues(0, value, 0),
                child: const _LibraWidget('assets/libra/right_wage.png'),
              ),
            ),
            Positioned(
              right: 8,
              top: -2,
              child: _AnimatedBuilder(
                transform: Matrix4.translationValues(0, -value, 0),
                child: const _LibraWidget('assets/libra/left_wage.png'),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 12),
              child: _LibraWidget('assets/libra/main_wage.png'),
            ),
          ],
        ),
      ),
    );
  }
}

class _AnimatedBuilder extends StatelessWidget {
  const _AnimatedBuilder({required this.child, required this.transform});

  final Widget child;
  final Matrix4 transform;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 600),
      transform: transform,
      transformAlignment: Alignment.center,
      child: child,
    );
  }
}

class _LibraWidget extends StatelessWidget {
  const _LibraWidget(this.path, {this.width});

  final String path;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      path,
      width: width ?? 150,
    );
  }
}
