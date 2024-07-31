import 'package:flutter/material.dart';
import 'package:math_genius/contsants/colors.dart';
import 'package:math_genius/contsants/consts.dart';

class MyButton extends StatelessWidget {
  final String child;
  final VoidCallback onTap;
  var buttonColor = Colors.deepPurple[400];
  MyButton({super.key, required this.child, required this.onTap});

  @override
  Widget build(BuildContext context) {
    if (child == 'C') {
      buttonColor = green;
    } else if (child == 'X') {
      buttonColor = redColor;
    } else if (child == '=') {
      buttonColor = deepPurple;
    }
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            color: buttonColor,
          ),
          child: Center(
            child: Text(
              child,
              style: whiteTextStyle,
            ),
          ),
        ),
      ),
    );
  }
}
