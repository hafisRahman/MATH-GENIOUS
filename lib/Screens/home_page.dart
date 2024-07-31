import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:math_genius/Screens/drawingPage.dart';
import 'package:math_genius/contsants/colors.dart';
import 'package:math_genius/contsants/consts.dart';
import 'package:math_genius/utilities/gameLevels.dart';
import 'package:math_genius/utilities/my_Button.dart';
import 'package:math_genius/utilities/result_message.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Game Levels

  List<GameLevel> levels = [
    GameLevel(operation: 'addition', maxNumber: 9, correctAnswersRequired: 5),
    GameLevel(operation: 'addition', maxNumber: 19, correctAnswersRequired: 5),
    GameLevel(
        operation: 'subtraction', maxNumber: 9, correctAnswersRequired: 5),
    GameLevel(
        operation: 'subtraction', maxNumber: 19, correctAnswersRequired: 5),
    GameLevel(operation: 'addition', maxNumber: 29, correctAnswersRequired: 5),
    GameLevel(
        operation: 'subtraction', maxNumber: 29, correctAnswersRequired: 5),
    GameLevel(operation: 'addition', maxNumber: 39, correctAnswersRequired: 5),
  ];

  int currentLevelIndex = 0; // Index of the current level
  int correctAnswersInARow = 0; // Track correct answers in a row

  GameLevel get currentLevel => levels[currentLevelIndex];
// number pad list
  List<String> numberPad = [
    '7',
    '8',
    '9',
    'C',
    '4',
    '5',
    '6',
    'X',
    '1',
    '2',
    '3',
    '=',
    '0',
    
  ];
  // user answer
  String userAnswer = '';

  // number A , nuber B
  int numberA = 1;
  int numberB = 2;

// user Tapped butten

  void buttonTaped(String button) {
    setState(() {
      if (button == '=') {
        // check if answer is correct

        checkResult();
      } else if (button == 'C') {
        // clear the input
        userAnswer = '';
      } else if (button == 'X') {
        // delete the last number
        if (userAnswer.isNotEmpty) {
          userAnswer = userAnswer.substring(0, userAnswer.length - 1);
        }
      } else if (userAnswer.length < 5) {
        // maximum of 5 numbers can be inserted
        userAnswer += button;
      }
    });
  }

  // check if the user is correct
  void checkResult() {
    int correctAnswer = 0;
    if (currentLevel.operation == 'addition') {
      correctAnswer = numberA + numberB;
    } else if (currentLevel.operation == 'subtraction') {
      correctAnswer = numberA - numberB;
    }

    if (correctAnswer == int.parse(userAnswer)) {
      correctAnswersInARow++;
      if (correctAnswersInARow >= currentLevel.correctAnswersRequired) {
        if (currentLevelIndex < levels.length - 1) {
          setState(() {
            currentLevelIndex++;
            correctAnswersInARow = 0;
          });
          showDialog(
            context: context,
            builder: (context) {
              return ResultMessage(
                message: "Level Up!",
                onTap: goToNextQuestion,
                icon: Icons.trending_up,
              );
            },
          );
        } else {
          showDialog(
            context: context,
            builder: (context) {
              return ResultMessage(
                message: "You've completed all levels!",
                onTap: restartGame, // Add a new method to restart the game
                icon: Icons.replay,
              );
            },
          );
        }
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return ResultMessage(
              message: "Correct!",
              onTap: goToNextQuestion,
              icon: Icons.forward,
            );
          },
        );
      }
    } else {
      correctAnswersInARow = 0;
      showDialog(
        context: context,
        builder: (context) {
          return ResultMessage(
            message: "Sorry, Try Again",
            onTap: goBackToQuestion,
            icon: Icons.rotate_left,
          );
        },
      );
    }
  }

  // void checkResult() {
  //   if (numberA + numberB == int.parse(userAnswer)) {
  //     showDialog(
  //         context: context,
  //         builder: (context) {
  //           return ResultMessage(
  //               message: "Correct!",
  //               onTap: goToNextQuestion,
  //               icon: Icons.forward);
  //         });
  //   } else {
  //     showDialog(
  //         context: context,
  //         builder: (context) {
  //           return ResultMessage(
  //             message: "Sorry Try Again",
  //             onTap: goBackToQuestion,
  //             icon: Icons.rotate_left,
  //           );
  //         });
  //   }
  // }

  // create random numbers

  var randomNumber = Random();

  void goToNextQuestion() {
    Navigator.of(context).pop();

    // reset values
    setState(() {
      userAnswer = '';
      if (currentLevel.operation == 'addition') {
        numberA = randomNumber.nextInt(currentLevel.maxNumber + 1);
        numberB = randomNumber.nextInt(currentLevel.maxNumber + 1);
      } else if (currentLevel.operation == 'subtraction') {
        numberB = randomNumber.nextInt(currentLevel.maxNumber + 1);
        numberA = randomNumber.nextInt(currentLevel.maxNumber + 1);
        if (numberA < numberB) {
          // Ensure A is larger than B for valid subtraction
          int temp = numberA;
          numberA = numberB;
          numberB = temp;
        }
      }
    });
  }
  // setState(() {
  //   userAnswer = '';
  // });

  // create new questions

  //   numberA = randomNumber.nextInt(currentLevel.maxNumber);
  //   numberB = randomNumber.nextInt(currentLevel.maxNumber);
  // }

// Go back to question
  void goBackToQuestion() {
    Navigator.of(context).pop();
  }

  void restartGame() {
    Navigator.of(context).pop(); // Close the dialog

    setState(() {
      // Reset game state
      currentLevelIndex = 0;
      correctAnswersInARow = 0;
      userAnswer = '';
      numberA = randomNumber.nextInt(levels[currentLevelIndex].maxNumber + 1);
      numberB = randomNumber.nextInt(levels[currentLevelIndex].maxNumber + 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: [
          // HomePage
          Scaffold(
            backgroundColor: primaryColor,
            body: Column(
              children: [
                // level progress, player need S correct answer in a row to proceed to next level

                Container(
                  height: 200,
                  color: deepPurple,
                  child: Center(
                    child: Text(
                      'Level ${currentLevelIndex + 1} - Correct Answers: $correctAnswersInARow/${currentLevel.correctAnswersRequired}',
                      style: whiteTextStyle.copyWith(fontSize: 18),
                    ),
                  ),
                ),

                // question
                Expanded(
                    child: Container(
                  child: Center(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // calculation

                      // Text('$numberA+$numberB = ', style: whiteTextStyle),
                      Text(
                          '$numberA ${currentLevel.operation == 'addition' ? '+' : '-'} $numberB = ',
                          style: whiteTextStyle),

                      // answer box
                      Container(
                        height: 50,
                        width: 100,
                        decoration: BoxDecoration(
                            color: Colors.deepPurple[400],
                            borderRadius: BorderRadius.circular(4)),
                        child: Center(
                          child: Text(
                            userAnswer,
                            style: whiteTextStyle,
                          ),
                        ),
                      )
                    ],
                  )),
                )),

                // number pad

                Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: GridView.builder(
                        itemCount: numberPad.length,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                        ),
                        itemBuilder: (context, index) {
                          return MyButton(
                            child: numberPad[index],
                            onTap: () => buttonTaped(numberPad[index]),
                          );
                        },
                      ),
                    )),
              ],
            ),
          ),
          // Drawing Page
          const DrawingPage(),
        ],
      ),
    );
  }
}
