import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:harmony_app/src/enums/activity_type.dart';

part 'task.freezed.dart';

@freezed
class Task with _$Task {
  const factory Task({
    required double points,
    required String name,
    required String uid,
    required Widget widget,
    required ActivityType activityType,
    required IconData icon,
    @Default(false) bool isSelected,
  }) = _Task;

  // String get formattedPoints => '+ $points';
}
