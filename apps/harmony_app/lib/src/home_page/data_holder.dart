import 'dart:async';

import 'package:comprehensive_utils/comprehensive_utils.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:harmony_app/src/enums/activity_type.dart';
import 'package:harmony_app/src/models/task.dart';
import 'package:rxdart/rxdart.dart';

class DataHolder implements Disposable {
  DataHolder();

  final BehaviorSubject<List<Task>> _tasksSubject = BehaviorSubject<List<Task>>.seeded(_mock);
  final DistinctSubject<double> _libreLevelSubject = DistinctSubject<double>.seeded(0);

  ValueStream<List<Task>> get tasksStream => _tasksSubject.stream;

  List<Task> get tasks => _tasksSubject.value;

  double get libreLevel => _libreLevelSubject.value;

  void setTasks(List<Task> tasks) => _tasksSubject.add(tasks);

  void setLibreLevel(double value) => _libreLevelSubject.add(value);

  void setCompleted(Task task) {
    final value = libreLevel + task.points;
    if (value != 0) {
      _libreLevelSubject.add(value / 2);
    }
    _libreLevelSubject.add(value);
    final tasks = _tasksSubject.value.toList()..remove(task);
    _tasksSubject.add(tasks);
  }

  @override
  Future<void> onDispose() async {
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

class BadgeWidget extends StatelessWidget {
  const BadgeWidget({required this.icon, required this.pointsValue, super.key});

  final IconData icon;
  final int pointsValue;

  @override
  Widget build(BuildContext context) {
    return Badge(
      largeSize: 50,
      smallSize: 50,
      backgroundColor: Colors.transparent,
      textColor: Colors.black,
      alignment: Alignment.topRight,
      padding: const EdgeInsets.only(left: 12, bottom: 30),
      label: Text(
        '+ $pointsValue  ',
        style: const TextStyle(fontSize: 15),
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color.fromRGBO(119, 125, 242, 1),
        ),
        child: Icon(icon),
      ),
    );
  }
}
