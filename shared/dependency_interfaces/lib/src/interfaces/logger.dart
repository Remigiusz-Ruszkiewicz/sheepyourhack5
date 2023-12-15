/*
 * Copyright © 2023 Gossen Metrawatt GmbH
 * All rights reserved.
 */

import 'package:dependency_interfaces/src/base/disposable.dart';

abstract interface class Logger implements Disposable {
  String get logDirectoryPath;

  void t(dynamic message, {DateTime? time, Object? error, StackTrace? stackTrace});

  void d(dynamic message, {DateTime? time, Object? error, StackTrace? stackTrace});

  void i(dynamic message, {DateTime? time, Object? error, StackTrace? stackTrace});

  void w(dynamic message, {DateTime? time, Object? error, StackTrace? stackTrace});

  void e(dynamic message, {DateTime? time, Object? error, StackTrace? stackTrace});

  void f(dynamic message, {DateTime? time, Object? error, StackTrace? stackTrace});
}
