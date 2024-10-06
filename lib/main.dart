import 'package:flutter/cupertino.dart';
import 'package:test_project/screens/WeatherScreen/wheater_screen_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      title: 'Flutter Demo',
      theme: CupertinoThemeData(),
      home: WeatherScreenView(),
    );
  }
}
