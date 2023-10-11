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
          home: FutureBuilder(
            future: _determinePosition(),
            builder: (context, snap) {
              if (snap.hasData) {
                return BlocProvider<WeatherBloc>(
                    create: (context) => WeatherBloc()
                      ..add(FetchWeatherEvent(snap.data as Position)),
                    child: const HomePage());
              }
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  return await Geolocator.getCurrentPosition();
}
