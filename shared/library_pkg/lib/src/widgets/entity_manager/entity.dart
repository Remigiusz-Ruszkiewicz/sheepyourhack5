import 'package:flutter/foundation.dart';

@immutable
class Entity {
  const Entity({required this.name, required this.uri, this.lastModified});

  final String name;
  final Uri uri;
  final DateTime? lastModified;
}
