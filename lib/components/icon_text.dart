import 'package:flutter/material.dart';

class IconText extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color color;
  const IconText({Key? key, required this.icon, required this.text,  this.color = Colors.black})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon,color: color,),
        SizedBox(width: 15),
        Text(text,style: TextStyle(color: color),),
      ],
    );
  }
}
