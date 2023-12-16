import 'package:rxdart/rxdart.dart';

class LibraBloc {
  final BehaviorSubject<double> changeBalance = BehaviorSubject<double>();

  void dispose() {
    changeBalance.close();
  }
}
