import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:test_project/domain/Weather/weather_model.dart';
import 'package:test_project/services/geolocation_service.dart';
import 'package:test_project/domain/Weather/weather_service.dart';

class WeatherScreenController {
  //podia diexar os metodos do service tudo static pra evitar fica fazendo instancia
  final _weatherService = WeatherService();
  Future<WeatherModel?> getCurrentWeatherData() async {
    try {
      Position position = await GeolocatorService.getCurrentPosition();

      final response = await _weatherService.getWeatherData(
        position.latitude,
        position.longitude,
      );

      return response;
    } catch (e) {
      debugPrint('[]>> $e');

      return null;
    }
  }

  ///tem que ser fora pq se n ele vai criar varias instancias do debounce ai n funciona
  final debouncer = KDebouncer();

  debouncedSearch(String text) {
    return debouncer.run(() {
      return _weatherService.getCitiesByText(text);
    });
  }

  Future<WeatherModel?> getWeatherByCity(String city) async {
    try {
      final response = await _weatherService.getWeatherByCity(city);
      return response;
    } catch (e) {
      debugPrint('[]>> $e');

      return null;
    }
  }
}

class KDebouncer {
  KDebouncer({this.milliseconds}) {
    milliseconds ??= 200;
  }

  int? milliseconds;
  Function()? action;
  Timer? _timer;

  run(Function() action) {
    if (_timer?.isActive ?? false) {
      _timer?.cancel();
    }
    _timer = Timer(
      milliseconds != null
          ? Duration(milliseconds: milliseconds!)
          : const Duration(milliseconds: 200),
      action,
    );
  }
}
