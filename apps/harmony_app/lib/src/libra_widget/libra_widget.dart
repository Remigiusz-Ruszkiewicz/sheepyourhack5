import 'package:async_builder/async_builder.dart';
import 'package:async_builder/init_builder.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:harmony_app/src/libra_widget/libra_bloc.dart';

final GetIt _getIt = GetIt.instance;

class LibraWidget extends StatelessWidget {
  const LibraWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return InitBuilder<LibraBloc>(
      getter: _getBloc,
      builder: (context, bloc) {
        return Center(
          child: Column(
            children: [
              MaterialButton(
                child: const Text('dsadsa'),
                onPressed: () {
                  if (bloc!.changeBalance.hasValue) {
                    final value = bloc.changeBalance.value;
                    bloc.changeBalance.add(-value);
                    return;
                  }
                  bloc.changeBalance.add(20);
                },
              ),
              AsyncBuilder<double>(
                stream: bloc!.changeBalance.stream,
                initial: 0,
                builder: (context, balanceValue) {
                  return Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 34, top: 42),
                        child: _AnimatedBuilder(
                          transform: Matrix4.rotationZ(balanceValue! / 2),
                          child: const _LibraWidget('assets/libra/wage_bar.png', width: 100),
                        ),
                      ),
                      _AnimatedBuilder(
                        transform: Matrix4.translationValues(0, -balanceValue, 0),
                        child: const _LibraWidget('assets/libra/left_wage.png'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 34, top: 22),
                        child: _AnimatedBuilder(
                          transform: Matrix4.translationValues(0, balanceValue, 0),
                          child: const _LibraWidget('assets/libra/right_wage.png'),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 12),
                        child: _LibraWidget('assets/libra/main_wage.png'),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        );
      },
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
      width: width ?? 150,
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
