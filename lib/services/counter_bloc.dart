import 'dart:async';
import 'package:test_app/services/user.dart';
import 'data_dummy.dart';
import 'counter_event.dart';
import 'package:bloc/bloc.dart';

class CounterBloc {
  User _user = User();

  final _counterStateController = StreamController<int>();

  StreamSink<int> get _inCounter => _counterStateController.sink;

  Stream<int> get status => _counterStateController.stream;


  final _counterEventController = StreamController<CounterEvent>();

  Sink<CounterEvent> get counterEventSink => _counterEventController.sink;

  CounterBloc() {
    _counterEventController.stream.listen(_mapEventToState);
  }

  void _mapEventToState(CounterEvent event) {
    if (event is SuccessEvent) {

    }
    if (event is ValidateEvent) {
      userDummyList.map((tempUser) => {
        if (tempUser.phone == _user.phone) {
          if (tempUser.password == _user.password) {
            _counterStateController.sink.add(0)
          }
          else {
            _counterStateController.sink.add(1)
          }
        }
        else {
          _counterStateController.sink.add(1)
        }
      });
    }
  }

  void dispose() {
    _counterEventController.close();
    _counterStateController.close();
  }
}
