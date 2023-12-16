import 'package:flutter/material.dart';
import 'package:harmony_app/src/enums/activity_type.dart';

@immutable
class Task {
  const Task({
    required this.points,
    required this.name,
    required this.uid,
    required this.widget,
    required this.activityType,
  });

  final double points;
  final String name;
  final String uid;
  final Widget widget;
  final ActivityType activityType;

  String get formattedPoints => '+ $points';
}