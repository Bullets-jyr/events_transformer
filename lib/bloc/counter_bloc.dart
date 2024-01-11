import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';

part 'counter_event.dart';
part 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterState.initial()) {
    // on<IncrementCounterEvent>(
    //   _handleIncrementCounterEvent,
    //   transformer: sequential(),
    // );

    // on<DecrementCounterEvent>(
    //   _handleDecrementCounterEvent,
    //   transformer: sequential(),
    // );

    on<CounterEvent>(
          (event, emit) async {
        if (event is IncrementCounterEvent) {
          await _handleIncrementCounterEvent(event, emit);
        } else if (event is DecrementCounterEvent) {
          await _handleDecrementCounterEvent(event, emit);
        }
      },
      transformer: sequential(),
    );
  }

  Future<void> _handleIncrementCounterEvent(event, emit) async {
    await Future.delayed(Duration(seconds: 4));
    emit(state.copyWith(counter: state.counter + 1));
  }

  Future<void> _handleDecrementCounterEvent(event, emit) async {
    await Future.delayed(Duration(seconds: 2));
    emit(state.copyWith(counter: state.counter - 1));
  }
}