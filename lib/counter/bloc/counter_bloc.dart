import 'package:counter_app/counter/bloc/counter_event.dart';
import 'package:counter_app/counter/bloc/counter_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterBloc extends Bloc<CounterEvents, CounterState> {
  CounterBloc() : super(const CounterState(counter: 0, isDarkMode: false)) {
    on<Increment>(
      (event, emit) {
        final currentCounter = (state).counter;
        final isDarkMode = state.isDarkMode;
        final incrementValue = isDarkMode ? 2 : 1;
        if (currentCounter < 10) {
          emit(CounterState(
            counter: currentCounter + incrementValue,
            isDarkMode: state.isDarkMode,
          ));
        }
      },
    );
    on<Decrement>((event, emit) {
      final currentCounter = (state).counter;
      final isDarkMode = state.isDarkMode;
      final decrementValue = isDarkMode ? 2 : 1;
      if (currentCounter > 0) {
        emit(CounterState(
          counter: currentCounter - decrementValue,
          isDarkMode: state.isDarkMode,
        ));
      }
    });
    on<SwitchThemeEvent>((event, emit) {
      emit(CounterState(
        counter: state.counter,
        isDarkMode: !state.isDarkMode,
      ));
    });
  }
}
