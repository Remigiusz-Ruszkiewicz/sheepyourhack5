/*
 * Copyright © 2023 Gossen Metrawatt GmbH
 * All rights reserved.
 */

import 'package:dependency_interfaces/src/enums/background_service_command.dart';
import 'package:flutter/foundation.dart';

@immutable
sealed class _MessageBase {
  const _MessageBase(this.commandId);

  final String commandId;
}

@immutable
final class MessageWrapper<T, S> extends _MessageBase {
  const MessageWrapper(super.commandId, this.serviceName, this.command, this.arg);

  final BackgroundServiceCommand serviceName;
  final Enum command;
  final S arg;

  WrappedResult<T> call(T result) => WrappedResult<T>._(commandId, result);

  WrappedEmptyResult wrapEmpty() => WrappedEmptyResult._(commandId);
}

@immutable
final class WrappedResult<T> extends _MessageBase {
  const WrappedResult._(super.commandId, this._result);

  final T _result;

  R unwrap<R>() => _result as R;

  R? tryUnwrap<R>() {
    if (_result is R) {
      return _result;
    }
    return null;
  }
}

@immutable
final class WrappedEmptyResult extends WrappedResult<void> {
  const WrappedEmptyResult._(String commandId) : super._(commandId, null);
}
