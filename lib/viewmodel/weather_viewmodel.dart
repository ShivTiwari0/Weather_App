import 'package:flutter/material.dart';
import 'package:weather_app/model/weather_model.dart';
import 'package:weather_app/repositories/weather_repo.dart';

class WeatherViewModel with ChangeNotifier {
  final WeatherRepository _weatherRepository = WeatherRepository();

  WeatherModel? _weatherData;
  bool _loading = false;

  WeatherModel? get weatherData => _weatherData;
  bool get loading => _loading;

  Future<void> fetchWeather(double lat, double lon) async {
    _loading = true;
    notifyListeners();

    try {
      print('vm1');
      _weatherData = await _weatherRepository.fetchWeather(lat, lon);
      print('vm2');
      print(weatherData!.humidity);
    } catch (e) {
      _weatherData = null;
      print(e);
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
}
