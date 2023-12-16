import 'package:dependency_interfaces/src/base/disposable.dart';

abstract interface class MetrahitHandler implements Disposable, MetrahitBase, StoredMeasurements, LiveData, Sequences {
  void initSocket();
}

abstract interface class MetrahitBase {
  Future<Object> getMeterInfo();

  Future<Object?> getVersion();
}

abstract interface class StoredMeasurements {
  Future<Map<int, Object>> readHeaders();

  Stream<MapEntry<int, Object>> readHeaderStream();

  Future<String> allRowsCsv();

  Stream<String> allRowsCsvStream();

  Stream<String> selectedRowsCsvStream(List<int> ids);
}

abstract interface class LiveData {
  Stream<Object?> pullRawLiveData();

  void stopLiveDataPulling();
}

abstract interface class Sequences {
  Future<List<Object>> readSequences();

  Future<bool> isSequencesFutureAvailable();

  Future<bool> writeSequences(covariant List<Object> sequences);
}
