/*
 * Copyright © 2023 Gossen Metrawatt GmbH
 * All rights reserved.
 */

import 'package:flutter/foundation.dart';
import 'package:library_pkg/library_pkg.dart';

@immutable
class EntityListEntry<T extends Entity> {
  const EntityListEntry({required this.entity, required this.isSelected});

  final T entity;
  final bool isSelected;
}
