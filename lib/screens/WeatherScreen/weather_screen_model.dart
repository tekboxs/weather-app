import 'package:flutter/material.dart';
import 'package:test_project/domain/Weather/weather_model.dart';
import 'package:test_project/screens/WeatherScreen/weather_screen_controller.dart';

class WeatherScreenModel extends ChangeNotifier {
  final _weatherScreenController = WeatherScreenController();
  Future<WeatherModel?>? future;

  handleGetCurrentWeatherData() {
    future = _weatherScreenController.getCurrentWeatherData();
    notifyListeners();
  }

  handleGetWeatherByCity(String city) {
    future = _weatherScreenController.getWeatherByCity(city);
    notifyListeners();
  }

  searchByText(String text) {
    return _weatherScreenController.debouncedSearch(text);
  }
}
