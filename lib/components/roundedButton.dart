
import 'package:flutter/material.dart';
class CircleButton extends StatelessWidget {
  CircleButton({this.color, this.text, this.pressed});
  final Color color;
  final String text;
  final Function pressed;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5,
        color: color,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: pressed,
          minWidth: 200.0,
          height: 42.0,
          child: Text(text),
        ),
      ),
    );
  }
}