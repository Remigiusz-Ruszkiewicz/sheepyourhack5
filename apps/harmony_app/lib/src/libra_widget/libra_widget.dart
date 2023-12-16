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
        return Column(
          children: [
            MaterialButton(
              child: Text('dsadsa'),
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
              builder: (context, balanceValue) {
                balanceValue ??= 0;
                return Stack(
                  children: [
                    const _LibraWidget('assets/libra/main_wage.png'),
                    const _LibraWidget('assets/libra/wage_bar.png'),
                    AnimatedContainer(
                      duration: const Duration(seconds: 1),
                      transform: Matrix4.translationValues(0, balanceValue, 0),
                      child: const _LibraWidget('assets/libra/left_wage.png'),
                    ),
                    AnimatedContainer(
                      duration: const Duration(seconds: 1),
                      transform: Matrix4.translationValues(0, -balanceValue, 0),
                      child: const _LibraWidget('assets/libra/right_wage.png'),
                    ),
                  ],
                );
              },
            ),
          ],
        );
      },
    );
  }
}

class _LibraWidget extends StatelessWidget {
  const _LibraWidget(this.path);

  final String path;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      path,
      width: 150,
    );
  }
}

LibraBloc _getBloc() {
  if (_getIt.isRegistered<LibraBloc>()) {
    return _getIt.get<LibraBloc>();
  }
  return _getIt.registerSingleton<LibraBloc>(LibraBloc());
}
