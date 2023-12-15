/*
 * Copyright © 2023 Gossen Metrawatt GmbH
 * All rights reserved.
 */

import 'package:flutter/foundation.dart';

@immutable
class Arc {
  const Arc(this.startAngle, this.sweepAngle);
  final double startAngle;
  final double sweepAngle;
}

@immutable
class Divisions {
  const Divisions(this.divisionCount, this.divisionLength);
  final int divisionCount;
  final double divisionLength;
}
