import 'package:rxdart/rxdart.dart';

class SocketBloc {
  // ignore: close_sinks
  final BehaviorSubject<bool> _isDisplay = BehaviorSubject<bool>();
  Stream<bool> get isDisplay => _isDisplay.stream;

  void initboolIsDisplay() {
    _isDisplay.value = false;
    _isDisplay.sink;
  }

  void updateIsDisplay(bool value) {
    _isDisplay.value = value;
    _isDisplay.sink;
  }

  bool getIsDisplay() {
    return _isDisplay.value;
  }
}

// ignore: non_constant_identifier_names
SocketBloc socketBloc = SocketBloc();
