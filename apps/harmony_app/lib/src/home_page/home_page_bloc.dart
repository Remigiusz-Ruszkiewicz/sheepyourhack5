import 'package:comprehensive_utils/comprehensive_utils.dart';
import 'package:get_it/get_it.dart';
import 'package:harmony_app/src/home_page/data_holder.dart';
import 'package:harmony_app/src/models/task.dart';
import 'package:rxdart/rxdart.dart';

class HomePageBloc implements Disposable {
  HomePageBloc() {
    Stream.periodic(const Duration(seconds: 1), (_) => _formatTime(DateTime.now()))
        .takeWhile((_) => !_timeTextSubject.isClosed)
        .listen(_timeTextSubject.add);
  }

  final DataHolder _dataHolder = GetIt.I.get<DataHolder>();
  final DistinctSubject<String> _timeTextSubject = DistinctSubject<String>();
  final DistinctSubject<String> _hintTextSubject = DistinctSubject<String>.seeded('Czas na relaks');

  ValueStream<String> get timeStream => _timeTextSubject.stream;

  ValueStream<String> get hintTextStream => _hintTextSubject.stream;

  ValueStream<List<Task>> get tasksStream => _dataHolder.tasksStream;

  double get libreLevel => _dataHolder.libreLevel;

  void setTaskCompleted(Task task) {
    final value = libreLevel + task.points;
    if (value != 0) {
      _dataHolder.setLibreLevel(value / 2);
    }
    _dataHolder.setLibreLevel(value);
    final tasks = _dataHolder.tasks.toList()..remove(task);
    _dataHolder.updateTasksList(tasks);
  }

  String _formatTime(DateTime dateTime) {
    return '${dateTime.hour.toString().padLeft(2, '0')} : ${dateTime.minute.toString().padLeft(2, '0')}';
  }

  @override
  Future<void> onDispose() async {
    await _timeTextSubject.close();
    await _hintTextSubject.close();
  }
}
