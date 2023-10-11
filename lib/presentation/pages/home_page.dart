import 'package:counter_app/counter/bloc/counter_bloc.dart';
import 'package:counter_app/counter/bloc/counter_event.dart';
import 'package:counter_app/counter/bloc/counter_state.dart';
import 'package:counter_app/weather/bloc/weather_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          BlocBuilder<CounterBloc, CounterState>(
            builder: (context, state) {
              final isMaxValue = (state).counter >= 10;
              final isMinValue = (state).counter <= 0;
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                
                  Text(
                    state.counter.toString(),
                    style: const TextStyle(fontSize: 50),
                  ),

                  BlocBuilder<WeatherBloc, WeatherState>(
                    builder: (context, state) {
                      if(state is WeatherLoadedState){
                      return  Text(state.weatherModel.temperature!.celsius.toString());

                      }else{

                        return const Text("No weather data");
                      }
                    }
                    
                    ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            FloatingActionButton(
                              shape: const CircleBorder(),
                              onPressed: () {
                               
                              },
                              child: const Icon(Icons.cloud),
                            ),
                            const SizedBox(height: 16.0),
                            FloatingActionButton(
                              shape: const CircleBorder(),
                              onPressed: () {
                                context
                                    .read<CounterBloc>()
                                    .add(SwitchThemeEvent());
                              },
                              child: const Icon(
                                Icons.palette,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Visibility(
                              replacement: const SizedBox(height: 52),
                              visible: !isMaxValue,
                              child: FloatingActionButton(
                                shape: const CircleBorder(),
                                onPressed: () {
                                  context.read<CounterBloc>().add(Increment());
                                },
                                child: const Icon(Icons.add),
                              ),
                            ),
                            const SizedBox(height: 16.0),
                            Visibility(
                              replacement: const SizedBox(height: 52),
                              visible: !isMinValue,
                              child: FloatingActionButton(
                                shape: const CircleBorder(),
                                onPressed: () {
                                  context.read<CounterBloc>().add(Decrement());
                                },
                                child: const Icon(Icons.remove),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
