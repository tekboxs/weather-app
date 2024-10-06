import 'package:flutter/material.dart';
import 'package:test_project/components/icon_text.dart';
import 'package:test_project/domain/Weather/weather_model.dart';
import 'package:test_project/helpers/utils/date_handler.dart';
import 'package:weather_icons/weather_icons.dart';

class WeatherContent extends StatefulWidget {
  final Current current;
  final Location location;

  const WeatherContent(
      {Key? key, required this.current, required this.location})
      : super(key: key);

  @override
  _WeatherContentState createState() => _WeatherContentState();
}
class _WeatherContentState extends State<WeatherContent> {
  String time = '';
  String weekDay = DateHandler.getWeekDay();
  @override
  initState() {
    super.initState();
    time = getTime();
  }

  String getTime() {
    return widget.location.localtime.split(' ')[1];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${widget.current.tempC}C",
          style: const TextStyle(fontSize: 50, fontWeight: FontWeight.w400),
        ),
        const SizedBox(
          height: 15,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "$weekDay, ",
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
            ),
            Text(
              time,
              style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey),
            )
          ],
        ),
        const Padding(
          padding:
              EdgeInsets.symmetric(vertical: 20), // margem vertical de 8 pixels
          child: Divider(
            thickness: 0.2,
            color: Colors.grey,
          ),
        ),
        const IconText(icon: WeatherIcons.day_sunny, text: "Mostly Claudy"),
        const SizedBox(
          height: 20,
        ),
        const IconText(icon: WeatherIcons.rain_wind, text: "Rain - 30%")
      ],
    );
  }
}
