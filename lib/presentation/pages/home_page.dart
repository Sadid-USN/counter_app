import 'package:counter_app/core/determene_position.dart';
import 'package:counter_app/counter/bloc/counter_bloc.dart';
import 'package:counter_app/counter/bloc/counter_event.dart';
import 'package:counter_app/counter/bloc/counter_state.dart';
import 'package:counter_app/presentation/widget/button_actions.dart';
import 'package:counter_app/presentation/widget/weather_info.dart';
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
                            const WeatherInfo(),
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
                        return const Center(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(),
                          ],
                        ));
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
