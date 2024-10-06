import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class WeatherSunnyAnimated extends StatefulWidget {
  @override
  _WeatherSunnyAnimatedState createState() => _WeatherSunnyAnimatedState();
}

class _WeatherSunnyAnimatedState extends State<WeatherSunnyAnimated>
    with TickerProviderStateMixin {
  @override
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..repeat(reverse: true);
  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: const Offset(0.0, -0.1),
    end: const Offset(0.0, 0.1),
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.fastEaseInToSlowEaseOut,
  ));

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      transitionBuilder: (child, animation) {
        return SlideTransition(position: _offsetAnimation, child: child);
      },
      child: SvgPicture.asset(
        'assets/images/sunny_icon.svg',
        width: 200,
        height: 200,
      ),
    );
  }
}
