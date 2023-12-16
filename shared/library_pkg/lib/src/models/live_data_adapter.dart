import 'package:library_pkg/src/models/live_data_response.dart';
import 'package:library_pkg/src/models/value_range.dart';

abstract interface class LiveDataAdapter {
  String measureInformation(LiveDataResponse? liveData);
  bool isResponseValid(LiveDataResponse? liveData);
  double offset(LiveDataResponse liveData);
  ValueRange calculateValueRange(LiveDataResponse liveData);
}
