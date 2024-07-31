class GameLevel {
  final String operation; // Addition or subtraction
  final int maxNumber; // The highest number to use in questions
  final int
      correctAnswersRequired; // Number of correct answers needed to advance to the next level

  GameLevel({
    required this.operation,
    required this.maxNumber,
    required this.correctAnswersRequired,
  });
}
