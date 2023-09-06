import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_with_bloc/models/weather_model.dart';
import 'package:weather_with_bloc/services/weather_service.dart';
import 'package:weather_with_bloc/weathe_Cubit/weather_states.dart';

class Weather_Cubit extends Cubit<weatherState> {
  Weather_Cubit(this.weather_service) : super(weatherInitial());
  WeatherService weather_service;
  String? cityName;
  WeatherModel? weatherModel;
  void getWeather({required String cityName}) async {
    emit(weatherLoading());
    try {
      weatherModel = await weather_service.getWeather(cityName: cityName);
      emit(weatherSuccess());
    } catch (e) {
      emit(weatherFailure());
    }
  }
}
