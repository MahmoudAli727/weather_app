import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_with_bloc/pages/homePage.dart';
import 'package:weather_with_bloc/services/weather_service.dart';
import 'package:weather_with_bloc/weathe_Cubit/weather_cubit.dart';

void main() {
  runApp(BlocProvider(
      create: (context) {
        return Weather_Cubit(WeatherService());
      },
      child: WeatherApp()));
}

class WeatherApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch:
            BlocProvider.of<Weather_Cubit>(context).weatherModel == null
                ? Colors.blue
                : BlocProvider.of<Weather_Cubit>(context)
                    .weatherModel!
                    .getThemeColor(),
      ),
      home: HomePage(),
    );
  }
}
