/*
 * Copyright © 2023 Gossen Metrawatt GmbH
 * All rights reserved.
 */

import 'dart:async';

import 'package:dependency_interfaces/src/base/service.dart';
import 'package:dependency_interfaces/src/helpers/message_wrapper.dart';
import 'package:flutter/foundation.dart';

final class ReverseRedirect<T, S> implements RedirectionRegister<T>, StreamRedirection<T>, RedirectionCancel {
  ReverseRedirect._(this._messageWrapper, this._callback);

  final MessageWrapper<T, S> _messageWrapper;
  final ValueChanged<WrappedResult<Object?>> _callback;
  StreamSubscription<T>? _subscription;

  @override
  StreamRedirection<T> registerFor(Service service) {
    service.addRedirection(_messageWrapper.commandId, this);
    return this;
  }

  @override
  void redirectStream(Stream<T> stream) {
    _subscription = stream.listen(
      (event) => _callback(_messageWrapper(event)),
      onDone: () async {
        _callback(_messageWrapper.wrapEmpty());
        await cancel();
      },
    );
  }

  @override
  Future<void> cancel() async {
    await _subscription?.cancel();
    _subscription = null;
  }
}

extension RedirectResponse<T, S> on MessageWrapper<T, S> {
  RedirectionRegister<T> bind(ValueChanged<WrappedResult<Object?>> callback) => ReverseRedirect<T, S>._(this, callback);
}

abstract interface class RedirectionRegister<T> {
  StreamRedirection<T> registerFor(Service service);
}

abstract interface class StreamRedirection<T> {
  void redirectStream(Stream<T> stream);
}

abstract interface class RedirectionCancel {
  Future<void> cancel();
}
