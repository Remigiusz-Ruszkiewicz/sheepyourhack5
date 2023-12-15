/*
 * Copyright © 2023 Gossen Metrawatt GmbH
 * All rights reserved.
 */

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

final _getIt = GetIt.instance;

abstract base class _Provider<T extends Object> extends StatefulWidget {
  const _Provider({required this.instance, this.disposer, super.key});

  final T Function() instance;
  final FutureOr<void> Function(T)? disposer;
}

abstract base class _ProviderState<T extends Object, S extends _Provider<T>> extends State<S> {
  @override
  void initState() {
    super.initState();
    _getIt.pushNewScope(init: (getIt) => getIt.registerSingleton<T>(widget.instance(), dispose: widget.disposer));
  }

  @override
  void dispose() {
    _getIt
        .popScope()
        .timeout(const Duration(seconds: 3), onTimeout: () => throw TimeoutException('Dispose timed out!'));
    super.dispose();
  }
}

final class BlocProvider<T extends Object> extends _Provider<T> {
  const BlocProvider({required super.instance, required this.child, super.disposer, super.key});

  final Widget child;

  @override
  State<BlocProvider<T>> createState() => _BlocProviderState<T>();
}

final class _BlocProviderState<T extends Object> extends _ProviderState<T, BlocProvider<T>> {
  @override
  Widget build(BuildContext context) => widget.child;
}

final class BlocBuilder<T extends Object> extends _Provider<T> {
  const BlocBuilder({required super.instance, required this.builder, super.disposer, super.key});

  final Widget Function(BuildContext context, T bloc) builder;

  @override
  State<BlocBuilder<T>> createState() => _BlocBuilderState<T>();
}

final class _BlocBuilderState<T extends Object> extends _ProviderState<T, BlocBuilder<T>> {
  @override
  Widget build(BuildContext context) => widget.builder(context, _getIt.get<T>());
}
