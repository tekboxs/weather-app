import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:test_project/domain/Weather/weather_constants.dart';
import 'package:test_project/domain/Weather/weather_model.dart';

class WeatherService {
  final _uk = '60c30f8b0fb341f2996143051240510';
  Future<WeatherModel?> getWeatherData(
      double latitude, double longitude) async {
    final url =
        "http://api.weatherapi.com/v1/current.json?key=$_uk&q=$latitude, $longitude&aqi=no";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);

      final value = WeatherModel.fromJson(jsonData);
      return value;
    } else {
      return null;
    }
  }

  Future<WeatherModel?> getWeatherByCity(String city) async {
    final url =
        "http://api.weatherapi.com/v1/current.json?key=$_uk&q=$city&aqi=no";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);

      final value = WeatherModel.fromJson(jsonData);
      return value;
    } else {
      return null;
    }
  }

  List<String> getCitiesByText(String text) {
    return cities.where((city) => city.contains(text)).toList();
  }
}
