import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class WeatherSunnyAnimated extends StatefulWidget {
  const WeatherSunnyAnimated({super.key});

  @override
  State<WeatherSunnyAnimated> createState() => _WeatherSunnyAnimatedState();
}

class _WeatherSunnyAnimatedState extends State<WeatherSunnyAnimated>
    with TickerProviderStateMixin {
  // @override -> override só pra coisas do pai aqui é local do widget
  //os late devem ser iniciado no initState
  //late AnimationController _controller;
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..repeat(reverse: true);

//aqui sim teria override
  @override
  void initState() {
    //inicia o controller
    //   _controller = AnimationController(
    //   duration: const Duration(seconds: 2),
    //   vsync: this,
    // )..repeat(reverse: true)

    super.initState();
  }

  // msm coisa aqui para evitar problema com acessar membro da classe no initialize
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
      ///criar duration default e usar extension
      // duration: const Duration(milliseconds: 200),
      duration: 200.milliseconds,
      transitionBuilder: (child, animation) {
        return SlideTransition(position: _offsetAnimation, child: child);
      },

      /// isso daki se pode usar uma pckage [flutter_gen] vai gerar umas classes pra vc n precisar
      /// ficar decorando o caminho dos assets
      child: SvgPicture.asset(
        'assets/images/sunny_icon.svg',
        width: 200,
        height: 200,
      ),
    );
  }
}

extension TimerNumber on int {
  Duration get seconds => Duration(seconds: this);
  Duration get milliseconds => Duration(milliseconds: this);
}
