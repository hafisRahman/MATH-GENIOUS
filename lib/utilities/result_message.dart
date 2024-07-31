import 'package:flutter/material.dart';
import 'package:math_genius/contsants/colors.dart';

import '../contsants/consts.dart';

class ResultMessage extends StatelessWidget {
  final String message;
  final VoidCallback onTap;
  final icon;
  const ResultMessage({super.key, required this.message, required this.onTap, this.icon});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: deepPurple,
      content: Container(
        height: 200,
        color: deepPurple,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // The result

            Text(
              message,
              style: whiteTextStyle,
            ),

            // Button to go to the next question

            GestureDetector(
              onTap: onTap,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                    color: Colors.deepPurple[300],
                    borderRadius: BorderRadius.circular(8)),
                child:  Icon(
                  icon,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
