import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_with_bloc/models/weather_model.dart';
import 'package:weather_with_bloc/pages/searchPage.dart';
import 'package:weather_with_bloc/weathe_Cubit/weather_cubit.dart';
import 'package:weather_with_bloc/weathe_Cubit/weather_states.dart';

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  WeatherModel? weatherData;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return SearchPage();
              }));
            },
            icon: Icon(Icons.search),
          ),
        ],
        title: Text('Weather App'),
      ),
      body: BlocBuilder<Weather_Cubit, weatherState>(
        builder: (context, state) {
          if (state is weatherLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is weatherSuccess) {
            weatherData = BlocProvider.of<Weather_Cubit>(context).weatherModel;
            return SuccessPage(weatherData: weatherData);
          } else if (state is weatherFailure) {
            return Center(
              child: Text("There is wrong..."),
            );
          } else {
            return Default();
          }
        },
      ),
    );
  }
}

class SuccessPage extends StatelessWidget {
  const SuccessPage({
    super.key,
    required this.weatherData,
  });

  final WeatherModel? weatherData;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
        colors: [
          weatherData!.getThemeColor(),
          weatherData!.getThemeColor()[300]!,
          weatherData!.getThemeColor()[100]!,
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      )),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(
            flex: 3,
          ),
          Text(
            BlocProvider.of<Weather_Cubit>(context).cityName!,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'updated at : ${weatherData!.date.hour.toString()}:${weatherData!.date.minute.toString()}',
            style: TextStyle(
              fontSize: 22,
            ),
          ),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(weatherData!.getImage()),
              Text(
                weatherData!.temp.toInt().toString(),
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Column(
                children: [
                  Text('maxTemp :${weatherData!.maxTemp.toInt()}'),
                  Text('minTemp : ${weatherData!.minTemp.toInt()}'),
                ],
              ),
            ],
          ),
          Spacer(),
          Text(
            weatherData!.weatherStateName,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          Spacer(
            flex: 5,
          ),
        ],
      ),
    );
  }
}

class Default extends StatelessWidget {
  const Default({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'there is no weather 😔 start',
            style: TextStyle(
              fontSize: 25,
            ),
          ),
          Text(
            'searching now 🔍',
            style: TextStyle(
              fontSize: 25,
            ),
          )
        ],
      ),
    );
  }
}
