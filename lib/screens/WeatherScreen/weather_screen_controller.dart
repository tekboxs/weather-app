import 'package:geolocator/geolocator.dart';
import 'package:test_project/domain/Weather/weather_model.dart';
import 'package:test_project/services/geolocation_service.dart';
import 'package:test_project/domain/Weather/weather_service.dart';

class WeatherScreenController {
  final _weatherService = WeatherService();
  Future<WeatherModel?> getCurrentWeatherData() async {
    try {
      Position position = await GeolocatorService.getCurrentPosition();

      final response = await _weatherService.getWeatherData(
          position.latitude, position.longitude);

      return response;
    } catch (e) {
      print(e);
      return null;
    }
  }

  debouncedSearch(String text) {
    return _weatherService.getCitiesByText(text);
  }

  Future<WeatherModel?> getWeatherByCity(String city) async {
    try {
      final response = await _weatherService.getWeatherByCity(city);
      return response;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
