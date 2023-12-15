/*
 * Copyright © 2023 Gossen Metrawatt GmbH
 * All rights reserved.
 */

import 'package:flutter/foundation.dart';

@immutable
class ValueRange {
  const ValueRange(this.min, this.max);
  final double min;
  final double max;
}
