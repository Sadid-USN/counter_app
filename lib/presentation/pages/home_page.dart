import 'package:counter_app/counter/bloc/counter_bloc.dart';
import 'package:counter_app/counter/bloc/counter_event.dart';
import 'package:counter_app/counter/bloc/counter_state.dart';
import 'package:counter_app/main.dart';
import 'package:counter_app/presentation/widget/button_actions.dart';
import 'package:counter_app/weather/bloc/weather_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            BlocBuilder<CounterBloc, CounterState>(
              builder: (context, state) {
                final isMaxValue = (state).counter >= 10;
                final isMinValue = (state).counter <= 0;
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
                  child: FutureBuilder(
                    future: determinePosition(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Column(
                          children: [
                            BlocBuilder<WeatherBloc, WeatherState>(
                              builder: (context, state) {
                                if (state is WeatherLoadedState) {
                                  final weatherModel = state.weatherModel;
                                  final celsiusTemperature =
                                      weatherModel.temperature?.celsius ?? 0.0;
                                  final fahrenheitTemperature =
                                      weatherModel.temperature?.fahrenheit ??
                                          0.0;
                                  return Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                    child: Text(
                                        "Push the icon to get your location"),
                                  );
                                }
                              },
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                            const Text(
                                "have pushed the button this many times:"),
                            Text(
                              state.counter.toString(),
                              style: const TextStyle(fontSize: 50),
                            ),
                            const SizedBox(
                              height: 200,
                            ),
                            ActionButtons(
                              isMaxValue: isMaxValue,
                              isMinValue: isMinValue,
                              onWeatherPressed: () async {
                                context.read<WeatherBloc>().add(
                                    FetchWeatherEvent(
                                        snapshot.data as Position));
                              },
                              onThemeChanged: () {
                                context
                                    .read<CounterBloc>()
                                    .add(SwitchThemeEvent());
                              },
                              onIncrementPressed: () {
                                context.read<CounterBloc>().add(Increment());
                              },
                              onDecrementPressed: () {
                                context.read<CounterBloc>().add(Decrement());
                              },
                            )
                          ],
                        );
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}


// Column(
//                       children: [
//                         BlocBuilder<WeatherBloc, WeatherState>(
//                           builder: (context, state) {
//                             if (state is WeatherLoadedState) {
//                               final weatherModel = state.weatherModel;
//                               final celsiusTemperature =
//                                   weatherModel.temperature?.celsius ?? 0.0;
//                               final fahrenheitTemperature =
//                                   weatherModel.temperature?.fahrenheit ?? 0.0;
//                               return Column(
//                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     "Weather for ${weatherModel.country ?? ""} ${weatherModel.areaName ?? ""}:",
//                                     style: const TextStyle(fontSize: 18),
//                                   ),
//                                   Text(
//                                     "${celsiusTemperature.toStringAsFixed(1)}°C (${fahrenheitTemperature.toStringAsFixed(1)}°F)",
//                                     style: const TextStyle(fontSize: 18),
//                                   ),
//                                   const SizedBox(
//                                     height: 100,
//                                   ),
//                                   const Text(
//                                       "have pushed the button this many times:"),
//                                 ],
//                               );
//                             } else {
//                               return const Center(
//                                 child: CircularProgressIndicator(),
//                               );
//                             }
//                           },
//                         ),
//                         Text(
//                           state.counter.toString(),
//                           style: const TextStyle(fontSize: 50),
//                         ),
//                         ActionButtons(
//                           isMaxValue: isMaxValue,
//                           isMinValue: isMinValue,
//                           onWeatherPressed: () {},
//                           onThemeChanged: () {
//                             context.read<CounterBloc>().add(SwitchThemeEvent());
//                           },
//                           onIncrementPressed: () {
//                             context.read<CounterBloc>().add(Increment());
//                           },
//                           onDecrementPressed: () {
//                             context.read<CounterBloc>().add(Decrement());
//                           },
//                         )
//                       ],
//                     ),