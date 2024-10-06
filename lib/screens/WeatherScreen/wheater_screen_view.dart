import 'package:flutter/material.dart';
import 'package:test_project/helpers/widgets/async_builder.dart';
import 'package:test_project/screens/WeatherScreen/components/weather_content.dart';
import 'package:test_project/screens/WeatherScreen/components/weather_header.dart';
import 'package:test_project/screens/WeatherScreen/weather_screen_controller.dart';
import 'package:test_project/screens/WeatherScreen/weather_screen_model.dart';

class WeatherScreenView extends StatefulWidget {
  const WeatherScreenView({Key? key}) : super(key: key);

  @override
  _WeatherScreenViewState createState() => _WeatherScreenViewState();
}

class _WeatherScreenViewState extends State<WeatherScreenView> {
  final WeatherScreenModel _weatherScreenModel = WeatherScreenModel();
  @override
  void initState() {
    super.initState();
    _weatherScreenModel.handleGetCurrentWeatherData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              WeatherHeader(
                debouncedSearch: _weatherScreenModel.searchByText,
                getWeatherByCity: _weatherScreenModel.handleGetWeatherByCity,
                getCurrentWeatherData:
                    _weatherScreenModel.handleGetCurrentWeatherData,
              ),
              ListenableBuilder(
                  listenable: _weatherScreenModel,
                  builder: (context, child) {
                    return (AsyncBuilder(
                      future: _weatherScreenModel.future,
                      builder: (data) => WeatherContent(
                          current: data!.current, location: data.location),
                      errorBuilder: (error) =>
                          const Text('Erro ao carregar dados'),
                    ));
                  }),
            ],
          ),
        )),
      ),
    );
  }
}
