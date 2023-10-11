part of 'weather_bloc.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();
  
  @override
  List<Object> get props => [];
}

class WeatherInitalState extends WeatherState {}

class WeatherLoadingState extends WeatherState {}


class WeatherLoadedState extends WeatherState {
  final Weather weatherModel;

 const WeatherLoadedState(this.weatherModel);

  @override
  List<Object> get props => [weatherModel];
}

class WeatherErrorState extends WeatherState {
  final String error;

const  WeatherErrorState(this.error);

  @override
  List<Object> get props => [error];
}
