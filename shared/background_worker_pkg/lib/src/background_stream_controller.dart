import 'dart:async';
import 'package:flutter/foundation.dart';

typedef AddSubscription<T> = FutureOr<void> Function(BackgroundStreamSubscription<T> subs);
typedef RemoveSubscription<T> = FutureOr<void> Function();

class BackgroundStreamController<T> {
  BackgroundStreamController({this.onCancel});

  FutureOr<void> Function()? onCancel;

  BackgroundStreamSubscription<T>? _subscription;
  bool _isBusy = false;

  bool get isClosed => _subscription == null;

  void add(T event) {
    assert(!isClosed, 'You cannot add event to closed Stream');
    _isBusy = true;
    _subscription!._onAdd(event);
    _isBusy = false;
  }

  void close() {
    if (isClosed) {
      return;
    }
    _isBusy = true;
    _subscription!._onClose();
    _subscription = null;
    _isBusy = false;
  }

  FutureOr<void> _addSubscription(BackgroundStreamSubscription<T> subs) async {
    if (_isBusy) {
      await Future<void>.delayed(Duration.zero);
    }
    _subscription = subs;
  }

  FutureOr<void> _removeSubscription() async {
    if (_isBusy) {
      await Future<void>.delayed(Duration.zero);
    }
    _subscription = null;
    await onCancel?.call();
  }

  Stream<T> get stream => _BackgroundStreamTransformation<T>(_addSubscription, _removeSubscription);
}

class _BackgroundStreamTransformation<T> extends Stream<T> {
  const _BackgroundStreamTransformation(this._addSubscription, this._removeSubscription);

  final AddSubscription<T> _addSubscription;
  final RemoveSubscription<T> _removeSubscription;

  @override
  BackgroundStreamSubscription<T> listen(
    ValueSetter<T>? onData, {
    Function? onError,
    VoidCallback? onDone,
    bool? cancelOnError,
  }) {
    final subs = BackgroundStreamSubscription<T>(_removeSubscription)
      ..onData(onData)
      ..onError(onError)
      ..onDone(onDone);
    _addSubscription(subs);
    return subs;
  }
}

class BackgroundStreamSubscription<T> implements StreamSubscription<T> {
  BackgroundStreamSubscription(
    this._removeSubscription, {
    this.onPause,
    this.onResume,
    this.onCancel,
  });

  final RemoveSubscription<T> _removeSubscription;
  final VoidCallback? onPause;
  final VoidCallback? onResume;
  final FutureOr<void> Function()? onCancel;

  bool _isPaused = false;
  ValueSetter<T>? _data;
  VoidCallback? _onDone;

  @override
  Future<E> asFuture<E>([E? futureValue]) => Future<E>.value(futureValue);

  @override
  Future<void> cancel() async {
    await _removeSubscription();
    await onCancel?.call();
  }

  @override
  bool get isPaused => _isPaused;

  @override
  void onData(ValueSetter<T>? handleData) => _data = handleData;

  @override
  void onDone(VoidCallback? handleDone) => _onDone = handleDone;

  @override
  void onError(Function? handleError) {}

  @override
  void pause([Future<void>? resumeSignal]) {
    _isPaused = true;
    onPause?.call();
    resumeSignal?.then((_) => resume());
  }

  @override
  void resume() {
    _isPaused = false;
    onResume?.call();
  }
}

extension _BackgroundSubscriptionExtention<T> on BackgroundStreamSubscription<T> {
  void _onAdd(T event) {
    if (!isPaused) {
      _data?.call(event);
    }
  }

  void _onClose() {
    if (!isPaused) {
      _onDone?.call();
    }
  }
}
