import 'package:flutter/material.dart';

class IconText extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color color;
  const IconText({
    super.key,
    required this.icon,
    required this.text,
    this.color = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: color,
        ),
        const SizedBox(width: 15),
        Text(
          text,
          style: TextStyle(color: color),
        ),
      ],
    );
  }
}
