import 'package:flutter/material.dart';
import 'package:test_project/helpers/widgets/async_builder.dart';
import 'package:test_project/screens/WeatherScreen/components/weather_content.dart';
import 'package:test_project/screens/WeatherScreen/components/weather_header.dart';
import 'package:test_project/screens/WeatherScreen/weather_screen_model.dart';

class WeatherScreenView extends StatefulWidget {
  const WeatherScreenView({super.key});

  @override
  State<WeatherScreenView> createState() => _WeatherScreenViewState();
}

class _WeatherScreenViewState extends State<WeatherScreenView> {
  final WeatherScreenModel _weatherScreenModel = WeatherScreenModel();
  @override
  void initState() {
    super.initState();

    ///evitar error de setState durante o build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _weatherScreenModel.handleGetCurrentWeatherData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // pode fazer isso pelo theme se for usar da msm forma em todos
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            ///evitar numeros magicos
            padding:
                const EdgeInsets.symmetric(horizontal: 20), //defaultMargin,
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
                    return AsyncBuilder(
                      future: _weatherScreenModel.future,
                      builder: (data) => WeatherContent(
                        current: data!.current,
                        location: data.location,
                      ),
                      //isso daki pode ser default
                      errorBuilder: (error) => const Text(
                        'Erro ao carregar dados',
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
