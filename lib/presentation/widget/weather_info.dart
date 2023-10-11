import 'package:counter_app/weather/bloc/weather_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeatherInfo extends StatelessWidget {
  const WeatherInfo({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        if (state is WeatherLoadedState) {
          final weatherModel = state.weatherModel;
          final celsiusTemperature = weatherModel.temperature?.celsius ?? 0.0;
          final fahrenheitTemperature =
              weatherModel.temperature?.fahrenheit ?? 0.0;
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Weather for ${weatherModel.country ?? ""} ${weatherModel.areaName ?? ""}:",
                style: const TextStyle(fontSize: 18),
              ),
              Text(
                "${celsiusTemperature.toStringAsFixed(1)}°C (${fahrenheitTemperature.toStringAsFixed(1)}°F)",
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(
                height: 50,
              ),
            ],
          );
        } else if (state is WeatherLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return const Center(
            child: Text("Push the icon to get your location"),
          );
        }
      },
    );
  }
}
