import 'package:comprehensive_utils/comprehensive_utils.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:harmony_app/src/enums/activity_type.dart';
import 'package:harmony_app/src/home_page/data_holder.dart';
import 'package:harmony_app/src/models/task.dart';
import 'package:harmony_app/src/widgets/badge_widget.dart';
import 'package:rxdart/rxdart.dart';

class ActivityListBloc implements Disposable {
  ActivityListBloc();

  final DistinctSubject<IList<Task>> _tasksSubject = DistinctSubject<IList<Task>>.seeded(_mock.lock);

  ValueStream<IList<Task>> get tasksStream => _tasksSubject.stream;

  IList<Task> get tasks => _tasksSubject.value;

  void addTasks(IList<Task> tasks) => _tasksSubject.add(tasks);

  void saveTasks() {
    GetIt.I.get<DataHolder>().updateTasksList(tasks.unlock);
  }

  @override
  Future<void> onDispose() async {
    await _tasksSubject.close();
  }
}

const List<Task> _mock = [
  Task(
    name: 'Czytanie książki 1',
    uid: '1',
    widget: BadgeWidget(
      icon: Icons.menu_book_outlined,
      pointsValue: 5,
    ),
    points: 5,
    activityType: ActivityType.education,
    icon: Icons.menu_book_outlined,
  ),
  Task(
    name: 'Czytanie książki 2',
    uid: '1',
    widget: BadgeWidget(
      icon: Icons.menu_book_outlined,
      pointsValue: 5,
    ),
    points: 5,
    activityType: ActivityType.education,
    icon: Icons.menu_book_outlined,
  ),
  Task(
    name: 'Czytanie książki 3',
    uid: '1',
    widget: BadgeWidget(
      icon: Icons.menu_book_outlined,
      pointsValue: 5,
    ),
    points: 5,
    activityType: ActivityType.education,
    icon: Icons.menu_book_outlined,
  ),
  Task(
    name: 'Czytanie książki 4',
    uid: '1',
    widget: BadgeWidget(
      icon: Icons.menu_book_outlined,
      pointsValue: 5,
    ),
    points: 5,
    activityType: ActivityType.education,
    icon: Icons.menu_book_outlined,
  ),
];
