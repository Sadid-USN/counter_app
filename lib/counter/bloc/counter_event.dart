import 'package:equatable/equatable.dart';

abstract class CounterEvents extends Equatable {}

class Increment extends CounterEvents {
  @override
  List<Object?> get props => [];
}

class Decrement extends CounterEvents {
  @override
  List<Object?> get props => [];
}
class SwitchThemeEvent extends CounterEvents {
  @override
  List<Object?> get props => [];
}