/*
 * Copyright © 2023 Gossen Metrawatt GmbH
 * All rights reserved.
 */

import 'dart:async';

abstract interface class Disposable {
  FutureOr<void> dispose();
}
