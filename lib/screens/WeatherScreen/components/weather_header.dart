import 'package:flutter/material.dart';
import 'package:test_project/components/icon_text.dart';
import 'package:test_project/components/search_box.dart';
import 'package:test_project/screens/WeatherScreen/components/weather_sunny_animated.dart';
import 'package:weather_icons/weather_icons.dart';

class WeatherHeader extends StatefulWidget {
  final Function(String text) debouncedSearch;
  final Function(String city) getWeatherByCity;
  final Function() getCurrentWeatherData;
  const WeatherHeader({
    super.key,
    required this.debouncedSearch,
    required this.getWeatherByCity,
    required this.getCurrentWeatherData,
  });

  @override
  State<WeatherHeader> createState() => _WeatherHeaderState();
}

class _WeatherHeaderState extends State<WeatherHeader> {
  bool _isFocused = false;
  double _height = 40;
  List<String> _results = [];
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  void onChangeText(String text) {
    setState(() {
      if (text.isNotEmpty) {
        _height = 200;
        _results = widget.debouncedSearch(text);
      } else {
        _height = 40;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: _height,
          decoration: BoxDecoration(
            border: _isFocused
                ? Border.all(color: Colors.grey.shade200, width: 2)
                : null,
            borderRadius: BorderRadius.circular(10),
          ),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SearchBox(
              placeholder: "Search something...",
              focusNode: _focusNode,
              onChangeText: onChangeText,
            ),
            if (_results.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  itemCount: _results.length,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return InkResponse(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        focusColor: Colors.grey,
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          child: IconText(
                              color: Colors.grey.shade500,
                              icon: Icons.location_searching_rounded,
                              text: "Use Current Location."),
                        ),
                        onTap: () {
                          widget.getCurrentWeatherData();
                        },
                      );
                    } else {
                      return InkResponse(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        focusColor: Colors.grey,
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          child: IconText(
                              color: Colors.grey.shade500,
                              icon: WeatherIcons.cloud_down,
                              text: _results[index]),
                        ),
                        onTap: () {
                          if (_results.isNotEmpty &&
                              _results[index].isNotEmpty) {
                            widget.getWeatherByCity(_results[index]);
                          }
                        },
                      );
                    }
                  },
                ),
              ),
          ]),
        ),
        const WeatherSunnyAnimated()
      ],
    );
  }
}
