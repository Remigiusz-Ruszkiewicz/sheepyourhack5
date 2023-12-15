/*
 * Copyright © 2023 Gossen Metrawatt GmbH
 * All rights reserved.
 */

import 'package:flutter/foundation.dart';

@immutable
class Entity {
  const Entity({required this.name, required this.uri, this.lastModified});

  final String name;
  final Uri uri;
  final DateTime? lastModified;
}
