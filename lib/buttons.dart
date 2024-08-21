import 'package:flutter/material.dart';

// creating Stateless Widget for buttons
class MyButton extends StatelessWidget {
// declaring variables
  final color;
  final textColor;
  final buttonText;
  final buttontapped;

//Constructor
  MyButton({this.color, this.textColor, this.buttonText, this.buttontapped});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: Material(
          color: Colors.black,
          child: InkWell(
            onTap: buttontapped,
            child: Padding(
              padding: const EdgeInsets.all(0.5),
              child: Ink(
                color: color,
                child: Center(
                  child: Text(
                    buttonText,
                    style: TextStyle(
                      color: textColor,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
