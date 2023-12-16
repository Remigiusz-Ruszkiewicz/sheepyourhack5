import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:harmony_app/src/enums/activity_type.dart';

part 'task.freezed.dart';
part 'task.g.dart';

@freezed
class Task {
  const Task({
    required this.points,
    required this.name,
    required this.uid,
    required this.widget,
    required this.activityType,
    this.isSelected = false,
  });

  final double points;
  final String name;
  final String uid;
  final Widget widget;
  final ActivityType activityType;
  final bool isSelected;

  String get formattedPoints => '+ $points';
}
