import 'package:flutter/cupertino.dart';
import 'package:equatable/equatable.dart';

@immutable
class CounterState extends Equatable {
  final int counter;
  final bool isDarkMode;

  const CounterState({required this.counter, required this.isDarkMode});

  @override
  List<Object> get props => [counter, isDarkMode];
}

