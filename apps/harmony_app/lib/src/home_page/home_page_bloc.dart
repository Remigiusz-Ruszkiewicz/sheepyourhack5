import 'package:comprehensive_utils/comprehensive_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get_it/get_it.dart';
import 'package:harmony_app/src/enums/activity_type.dart';
import 'package:harmony_app/src/models/task.dart';
import 'package:rxdart/rxdart.dart';

class HomePageBloc implements Disposable {
  HomePageBloc() {
    Stream.periodic(const Duration(seconds: 1), (_) => _formatTime(DateTime.now()))
        .takeWhile((element) => !_timeTextSubject.isClosed)
        .listen(_timeTextSubject.add);
  }

  final DistinctSubject<String> _timeTextSubject = DistinctSubject<String>();
  final BehaviorSubject<String> _hintTextSubject = BehaviorSubject<String>.seeded('Czas na relaks');
  final BehaviorSubject<List<Task>> _tasksSubject = BehaviorSubject<List<Task>>.seeded(_mock);

  ValueStream<String> get timeStream => _timeTextSubject.stream;

  ValueStream<String> get hintTextStream => _hintTextSubject.stream;

  ValueStream<List<Task>> get tasksStream => _tasksSubject.stream;

  void setCompleted(Task task) {
    // recalculate balance
    final tasks = _tasksSubject.value.toList()..remove(task);
    _tasksSubject.add(tasks);
  }

  String _formatTime(DateTime dateTime) {
    return '${dateTime.hour.toString().padLeft(2, '0')} : ${dateTime.minute.toString().padLeft(2, '0')}';
  }

  @override
  Future<void> onDispose() async {
    await _timeTextSubject.close();
    await _hintTextSubject.close();
    await _tasksSubject.close();
  }
}

const List<Task> _mock = [
  Task(
    name: 'Czytanie książki',
    uid: '1',
    icon: BadgeWidget(
      icon: Icons.menu_book_outlined,
      pointsValue: 5,
    ),
    points: 5,
    activityType: ActivityType.education,
  ),
  Task(
    name: 'Jazda na rowerze',
    uid: '2',
    icon: BadgeWidget(
      icon: Icons.directions_bike_outlined,
      pointsValue: 10,
    ),
    activityType: ActivityType.sport,
    points: 10,
  ),
  Task(
    name: 'Masaż',
    uid: '3',
    icon: BadgeWidget(
      icon: Icons.balance_outlined,
      pointsValue: 5,
    ),
    points: 10,
    activityType: ActivityType.relax,
  ),
  Task(
    name: 'Mecz w koszykówkę',
    uid: '4',
    icon: BadgeWidget(
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
