import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:harmony_app/src/libra_widget/libra_bloc.dart';

final GetIt _getIt = GetIt.instance;

// if (bloc!.changeBalance.hasValue) {
// final value = bloc.changeBalance.value;
// bloc.changeBalance.add(-value);
// return;
// }
// bloc.changeBalance.add(20);
class LibraWidget extends StatelessWidget {
  const LibraWidget({super.key, required this.value});

  final double value;

  @override
  Widget build(BuildContext context) {
    print(value * (3.14159 / 180.0));
    return Center(
      child: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 4, top: 42),
            child: _AnimatedBuilder(
              // transform: Matrix4.skew(value, value),
              transform: Matrix4.rotationZ(value * (3.14159 / 180.0)),
              child: const _LibraWidget('assets/libra/wage_bar.png', width: 80),
            ),
          ),
          Positioned(
            left: 26,
            top: 20,
            child: _AnimatedBuilder(
              transform: Matrix4.translationValues(0, value, 0),
              child: const _LibraWidget('assets/libra/right_wage.png'),
            ),
          ),
          _AnimatedBuilder(
            transform: Matrix4.translationValues(0, -value, 0),
            child: const _LibraWidget('assets/libra/left_wage.png'),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 12),
            child: _LibraWidget('assets/libra/main_wage.png'),
          ),
        ],
      ),
    );
  }

  Matrix4 smallRotationMatrix(double deltaTheta) {
    double cosTheta = cos(deltaTheta);
    double sinTheta = sin(deltaTheta);

    return Matrix4(
      cosTheta,
      -sinTheta,
      0.0,
      0.0,
      sinTheta,
      cosTheta,
      0.0,
      0.0,
      0.0,
      0.0,
      1.0,
      0.0,
      0.0,
      0.0,
      0.0,
      1.0,
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
      duration: const Duration(seconds: 1),
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
      width: width ?? 140,
    );
  }
}

LibraBloc _getBloc() {
  if (_getIt.isRegistered<LibraBloc>()) {
    return _getIt.get<LibraBloc>();
  }
  return _getIt.registerSingleton<LibraBloc>(LibraBloc());
}

class SpinningLine extends StatefulWidget {
  const SpinningLine({super.key});

  @override
  _SpinningLineState createState() => _SpinningLineState();
}

class _SpinningLineState extends State<SpinningLine> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _controller,
      child: const _LibraWidget('assets/libra/wage_bar.png'),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
