import 'package:comprehensive_utils/comprehensive_utils.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:harmony_app/src/enums/activity_type.dart';
import 'package:harmony_app/src/models/task.dart';
import 'package:rxdart/rxdart.dart';

import '../widgets/badge_widget.dart';

class HomePageBloc implements Disposable {
  HomePageBloc() {
    Stream.periodic(const Duration(seconds: 1), (_) => _formatTime(DateTime.now()))
        .takeWhile((element) => !_timeTextSubject.isClosed)
        .listen(_timeTextSubject.add);
  }

  final DistinctSubject<String> _timeTextSubject = DistinctSubject<String>();
  final BehaviorSubject<String> _hintTextSubject = BehaviorSubject<String>.seeded('Czas na relaks');
  final BehaviorSubject<List<Task>> _tasksSubject = BehaviorSubject<List<Task>>.seeded(_mock);
  final DistinctSubject<double> _libreLevelSubject = DistinctSubject<double>();

  ValueStream<String> get timeStream => _timeTextSubject.stream;

  ValueStream<String> get hintTextStream => _hintTextSubject.stream;

  ValueStream<List<Task>> get tasksStream => _tasksSubject.stream;

  ValueStream<double> get libreLevelSubject => _libreLevelSubject.stream;

  void setCompleted(Task task) {
    final value = (_libreLevelSubject.valueOrNull ?? 0) + task.points;
    final tasks = _tasksSubject.value.toList()..remove(task);
    _tasksSubject.add(tasks);
    if (value != 0) {
      _libreLevelSubject.add(value / 2);
    }
    _libreLevelSubject.add(value);
  }

  String _formatTime(DateTime dateTime) {
    return '${dateTime.hour.toString().padLeft(2, '0')} : ${dateTime.minute.toString().padLeft(2, '0')}';
  }

  @override
  Future<void> onDispose() async {
    await _timeTextSubject.close();
    await _hintTextSubject.close();
    await _tasksSubject.close();
    await _libreLevelSubject.close();
  }
}

const List<Task> _mock = [
  Task(
    name: 'Czytanie książki',
    uid: '1',
    widget: BadgeWidget(
      icon: Icons.menu_book_outlined,
      pointsValue: 5,
    ),
    points: 5,
    activityType: ActivityType.education,
  ),
  Task(
    name: 'Jazda na rowerze',
    uid: '2',
    widget: BadgeWidget(
      icon: Icons.directions_bike_outlined,
      pointsValue: 10,
    ),
    activityType: ActivityType.sport,
    points: 10,
  ),
  Task(
    name: 'Masaż',
    uid: '3',
    widget: BadgeWidget(
      icon: Icons.balance_outlined,
      pointsValue: 5,
    ),
    points: 5,
    activityType: ActivityType.relax,
  ),
  Task(
    name: 'Mecz w koszykówkę',
    uid: '4',
    widget: BadgeWidget(
      icon: Icons.sports_basketball_outlined,
      pointsValue: 15,
    ),
    points: 15,
    activityType: ActivityType.integration,
  ),
];
