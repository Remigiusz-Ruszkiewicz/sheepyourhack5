import 'dart:async';

import 'package:comprehensive_utils/comprehensive_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:library_pkg/library_pkg.dart';
import 'package:rxdart/rxdart.dart';

abstract base class EntityManagerBloc<T extends Entity> {
  EntityManagerBloc(Stream<List<T>> entityStream)
      : _entityEntrySubject = DistinctSubject<Map<Uri, EntityListEntry<T>>>.seeded({}) {
    _subscription = entityStream.transform(_getTransformer(_pauseSubject)).listen((event) {
      final current = _entityEntrySubject.value;
      final Map<Uri, EntityListEntry<T>> map = {
        for (final T element in event)
          element.uri: EntityListEntry<T>(entity: element, isSelected: current[element.uri]?.isSelected ?? false),
      };
      _entityEntrySubject.add(map);
    });
  }

  final DistinctSubject<bool> _pauseSubject = DistinctSubject<bool>.seeded(false);
  final DistinctSubject<Map<Uri, EntityListEntry<T>>> _entityEntrySubject;
  StreamSubscription<List<T>>? _subscription;
  ValueStream<Iterable<EntityListEntry<T>>>? _entityEntriesStream;

  ValueStream<Iterable<EntityListEntry<T>>> get entityEntriesStream =>
      _entityEntriesStream ??= _entityEntrySubject.stream.map((event) => event.values).shareValue();

  Iterable<T> get selectedEntities =>
      _entityEntrySubject.value.values.where((element) => element.isSelected).map((e) => e.entity);

  void changeSelection(T entity) {
    final map = Map<Uri, EntityListEntry<T>>.of(_entityEntrySubject.value)
      ..update(entity.uri, (value) => EntityListEntry<T>(entity: value.entity, isSelected: !value.isSelected));
    _entityEntrySubject.add(map);
  }

  void clearSelection() {
    final map = {
      for (final element in _entityEntrySubject.value.entries)
        element.key: EntityListEntry<T>(entity: element.value.entity, isSelected: false),
    };
    _entityEntrySubject.add(map);
  }

  void pause() => _pauseSubject.add(true);

  void resume() => _pauseSubject.add(false);

  @mustCallSuper
  Future<void> onDispose() async {
    await _subscription?.cancel();
    await _entityEntrySubject.close();
    await _pauseSubject.close();
  }
}

StreamTransformer<T, T> _getTransformer<T>(Stream<bool> pauseStream) {
  late T lastEvent;
  bool isPending = false;
  bool isPaused = false;
  return StreamTransformer<T, T>((Stream<T> input, bool cancelOnError) {
    final controller = StreamController<T>(sync: true);
    controller.onListen = () {
      final subscriptions = CompositeSubscription();
      pauseStream.distinct().listen((event) {
        if (event) {
          isPaused = true;
        } else if (isPaused) {
          if (isPending) {
            controller.add(lastEvent);
            isPending = false;
          }
          isPaused = false;
        }
      }).addTo(subscriptions);
      input.listen(
        (data) {
          if (isPaused) {
            lastEvent = data;
            isPending = true;
          } else {
            controller.add(data);
          }
        },
        onError: controller.addError,
        onDone: controller.close,
        cancelOnError: cancelOnError,
      ).addTo(subscriptions);
      controller
        ..onPause = subscriptions.pause
        ..onResume = subscriptions.resume
        ..onCancel = subscriptions.cancel;
    };
    return controller.stream.listen(null);
  });
}
