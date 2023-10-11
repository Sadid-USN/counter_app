import 'package:counter_app/counter/bloc/counter_bloc.dart';
import 'package:counter_app/counter/bloc/counter_event.dart';
import 'package:counter_app/counter/bloc/counter_state.dart';

import 'package:counter_app/presentation/pages/home_page.dart';
import 'package:counter_app/weather/bloc/weather_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CounterBloc>(
          create: (context) => CounterBloc(),
        ),
        BlocProvider<WeatherBloc>(
          create: (context) => WeatherBloc(),
        ),
      ],
      child: BlocBuilder<CounterBloc, CounterState>(
        builder: (context, state) => MaterialApp(
            theme: state.isDarkMode
                ? ThemeData.dark(
                    useMaterial3: true,
                  )
                : ThemeData.light(
                    useMaterial3: true,
                  ),
            debugShowCheckedModeBanner: false,
            home: const HomePage()),
      ),
    );
  }
}

