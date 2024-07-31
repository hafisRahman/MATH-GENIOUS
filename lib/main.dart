import 'package:flutter/material.dart';
import 'package:math_genius/Screens/SplashScreen.dart';
import 'package:math_genius/Screens/home_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SplashScreen(),
    );
  }
}

/* Game Rules

 1.Player need to get 5 in a row to go to next level

L E V E L S 

 level 0 -> single digit addition
 level 1 -> double digit addition
 level 2 -> single digit substraction (larger number - smaller number)
 level 3 -> double digit substration
 level 4 -> 

 */


