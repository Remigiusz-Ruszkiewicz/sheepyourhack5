import 'package:comprehensive_utils/comprehensive_utils.dart';
import 'package:flutter/painting.dart';
import 'package:get_it/get_it.dart';
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
    name: 'Spinach Pizza',
    totalPriceCents: 1299,
    uid: '1',
    imageProvider: NetworkImage('https://flutter'
        '.dev/docs/cookbook/img-files/effects/split-check/Food1.jpg'),
  ),
  Task(
    name: 'Veggie Delight',
    totalPriceCents: 799,
    uid: '2',
    imageProvider: NetworkImage('https://flutter'
        '.dev/docs/cookbook/img-files/effects/split-check/Food2.jpg'),
  ),
  Task(
    name: 'Chicken Parmesan',
    totalPriceCents: 1499,
    uid: '3',
    imageProvider: NetworkImage('https://flutter'
        '.dev/docs/cookbook/img-files/effects/split-check/Food3.jpg'),
  ),
];
