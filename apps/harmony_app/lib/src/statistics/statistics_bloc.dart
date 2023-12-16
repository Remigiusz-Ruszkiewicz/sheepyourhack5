import 'package:get_it/get_it.dart';
import 'package:harmony_app/src/enums/statistics_period.dart';
import 'package:rxdart/rxdart.dart';

class StatisticsBloc implements Disposable {
  StatisticsBloc();

  final BehaviorSubject<StatisticsPeriod> _statisticsPeriodSubject = BehaviorSubject<StatisticsPeriod>();

  ValueStream<StatisticsPeriod> get statisticsPeriodStream => _statisticsPeriodSubject.stream;

  StatisticsPeriod get statisticsPeriodValue => _statisticsPeriodSubject.value;

  void setStatisticsPeriodValue(StatisticsPeriod value) {
    _statisticsPeriodSubject.add(value);
  }

  @override
  Future<void> onDispose() async {}
}
