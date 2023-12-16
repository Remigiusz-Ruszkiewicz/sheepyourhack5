import 'package:flutter/material.dart';
import 'package:harmony_app/src/enums/activity_type.dart';

@immutable
class Task {
  const Task({
    required this.points,
    required this.name,
    required this.uid,
    required this.icon,
    required this.activityType,
  });

  final int points;
  final String name;
  final String uid;
  final Widget icon;
  final ActivityType activityType;

  String get formattedPoints => '+ $points';
}
