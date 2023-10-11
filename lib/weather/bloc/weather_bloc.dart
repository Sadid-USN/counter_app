import 'package:counter_app/data/api_key.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/weather.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherInitalState()) {
    on<FetchWeatherEvent>((event, emit) async {
      emit(WeatherLoadingState());
      try {
        final WeatherFactory wf =
            WeatherFactory(apiKey, language: Language.ENGLISH);

        Weather weather = await wf.currentWeatherByLocation(
          event.position.latitude,
          event.position.longitude,
        );

        print(weather);
        emit(WeatherLoadedState(weather));
      } catch (error) {
        emit(WeatherErrorState(error.toString()));
      }
    });
  }
}
