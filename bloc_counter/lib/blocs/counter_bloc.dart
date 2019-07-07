import 'package:bloc/bloc.dart';
import 'package:bloc_counter/blocs/counter_event.dart';

// MARK: input が event で output が int
class CounterBloc extends Bloc<CounterEvent, int> {

  // MARK: Stateの初期値
  @override
  int get initialState => 0;

  @override
  Stream<int> mapEventToState(CounterEvent event) async* {
    switch (event) {
      case CounterEvent.increment:
        yield currentState + 1;
        break;
      case  CounterEvent.decrement:
        yield currentState - 1;
        break;
    }
  }
}