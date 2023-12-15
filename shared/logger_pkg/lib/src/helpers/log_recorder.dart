/*
 * Copyright © 2023 Gossen Metrawatt GmbH
 * All rights reserved.
 */

import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:logger_pkg/src/helpers/constants.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rxdart/rxdart.dart';

class LogRecorder {
  LogRecorder._(this._saveToFile, this._dispose, this.logDirectoryPath);

  static Future<LogRecorder> createAsync(String applicationName, [String? suffix]) async {
    final logDirPath = await _getLogDirPath(applicationName);
    final logController = StreamController<_LogData>(sync: true);
    IOSink? writeSink;
    final subscription = logController.stream.flatMapIterable((value) async* {
      yield _generateLog(value);
    }).listen(null);

    subscription.onData((logData) {
      subscription.pause(
        File(_getLogFilePath(logDirPath, suffix)).create(recursive: true).then((logFile) {
          writeSink = logFile.openWrite(mode: FileMode.writeOnlyAppend)..write(logData);
          subscription.onData(writeSink!.write);
        }),
      );
    });

    return LogRecorder._(
      logController.add,
      () async {
        await logController.close();
        await subscription.cancel();
        await writeSink?.flush();
        await writeSink?.close();
      },
      logDirPath,
    );
  }

  final void Function(_LogData) _saveToFile;
  final Future<void> Function() _dispose;
  final String logDirectoryPath;
  bool _isAlive = true;

  void recordLog(Level logLevel, dynamic message, [dynamic error, StackTrace? stackTrace]) {
    if (_isAlive) {
      _saveToFile(_LogData(logLevel, DateTime.now(), message, error, stackTrace));
    }
  }

  Future<void> dispose() async {
    _isAlive = false;
    await _dispose();
  }
}

Future<String> _getLogDirPath(String applicationName) async {
  final appDocumentsDir = await getApplicationDocumentsDirectory();
  return '${appDocumentsDir.path}/gossen_logs/$applicationName/';
}

String _getLogFilePath(String logDirPath, [String? suffix]) {
  final dateTimeNow = DateTime.now();
  final date = '${dateTimeNow.year.toString().padLeft(4, '0')}-'
      '${dateTimeNow.month.toString().padLeft(2, '0')}-'
      '${dateTimeNow.day.toString().padLeft(2, '0')}';
  return '$logDirPath$date${suffix == null ? '' : '_$suffix'}.log.txt';
}

Iterable<Object?> _generateLog(_LogData log) sync* {
  yield Constants.equalSignSeparator;
  yield '\nEvent occurred on ';
  yield log.occurrenceTime;
  yield '\n\n';
  yield Constants.dashSignSeparator;
  yield ' DESCRIPTION ';
  yield Constants.dashSignSeparator;
  yield '\n';
  yield log.logLevel.name;
  yield '\n\n';
  yield Constants.dashSignSeparator;
  yield ' MESSAGE ';
  yield Constants.dashSignSeparator;
  yield '\n';
  yield log.message;
  yield '\n\n';
  yield Constants.dashSignSeparator;
  yield ' ERROR ';
  yield Constants.dashSignSeparator;
  yield '\n';
  yield log.error;
  yield '\n\n';
  yield Constants.dashSignSeparator;
  yield ' STACK TRACE ';
  yield Constants.dashSignSeparator;
  yield '\n';
  yield log.stackTrace;
  yield '\n\n\n';
}

@immutable
class _LogData {
  const _LogData(this.logLevel, this.occurrenceTime, this.message, this.error, this.stackTrace);

  final Level logLevel;
  final DateTime occurrenceTime;
  final dynamic message;
  final dynamic error;
  final StackTrace? stackTrace;
}
