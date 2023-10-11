import 'package:flutter/material.dart';

class ActionButtons extends StatelessWidget {
  final void Function()? onWeatherPressed;
  final void Function()? onThemeChanged;
  final void Function()? onIncrementPressed;
  final void Function()? onDecrementPressed;
 final bool isMaxValue;
 final bool isMinValue;
const  ActionButtons({
    Key? key,
    this.onWeatherPressed,
    this.onThemeChanged,
    this.onIncrementPressed,
    this.onDecrementPressed,
    this.isMaxValue = false,
    this.isMinValue = false,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            FloatingActionButton(
              shape: const CircleBorder(),
              onPressed: onWeatherPressed,
              //    context.read<WeatherBloc>().add(FetchWeatherEvent(determinePosition() as Position));

              child: const Icon(Icons.cloud),
            ),
            const SizedBox(height: 16.0),
            FloatingActionButton(
              shape: const CircleBorder(),
              onPressed: onThemeChanged,
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
                onPressed: onIncrementPressed,
                child: const Icon(Icons.add),
              ),
            ),
            const SizedBox(height: 16.0),
            Visibility(
              replacement: const SizedBox(height: 52),
              visible: !isMinValue,
              child: FloatingActionButton(
                shape: const CircleBorder(),
                onPressed: onDecrementPressed,
                child: const Icon(Icons.remove),
              ),
            ),
          ],
        )
      ],
    );
  }
}
