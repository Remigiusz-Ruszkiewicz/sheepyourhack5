import 'dart:async';

import 'package:dependency_interfaces/src/base/disposable.dart';

abstract interface class Instantiable implements Disposable {
  FutureOr<void> init();
}
