import 'package:flutter/material.dart';
import 'package:math_genius/contsants/colors.dart';
import 'package:math_genius/contsants/consts.dart';

class DrawingPage extends StatefulWidget {
  const DrawingPage({super.key});

  @override
  _DrawingPageState createState() => _DrawingPageState();
}

class _DrawingPageState extends State<DrawingPage> {
  List<List<Offset?>> allPoints = [];
  List<Offset?> currentPoints = [];
  Color penColor = Colors.black;
  double penWidth = 5.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      appBar: AppBar(
        title: const Text(
          'Calculation Page',
          style: TextStyle(color: whiteColor),
        ),
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.undo,
              color: whiteColor,
            ),
            onPressed: () {
              setState(() {
                if (allPoints.isNotEmpty) {
                  allPoints.removeLast();
                }
              });
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.clear,
              color: whiteColor,
            ),
            onPressed: () {
              setState(() {
                allPoints.clear();
                currentPoints.clear();
              });
            },
          ),
          PopupMenuButton<Color>(
            icon: const Icon(
              Icons.color_lens,
              color: whiteColor,
            ),
            onSelected: (color) {
              setState(() {
                penColor = color;
              });
            },
            itemBuilder: (context) => <Color>[
              Colors.black,
              Colors.red,
              Colors.blue,
              Colors.green,
              Colors.yellow,
            ].map((color) {
              return PopupMenuItem<Color>(
                value: color,
                child: Container(
                  color: color,
                  width: 20,
                  height: 20,
                ),
              );
            }).toList(),
          ),
          PopupMenuButton<double>(
            icon: const Icon(
              Icons.brush,
              color: whiteColor,
            ),
            onSelected: (width) {
              setState(() {
                penWidth = width;
              });
            },
            itemBuilder: (context) => [5.0, 10.0, 15.0, 20.0].map((width) {
              return PopupMenuItem<double>(
                value: width,
                child: Text('Width: $width'),
              );
            }).toList(),
          ),
        ],
      ),
      body: GestureDetector(
        onPanUpdate: (details) {
          setState(() {
            currentPoints.add(details.localPosition);
          });
        },
        onPanEnd: (details) {
          setState(() {
            allPoints.add(List.from(currentPoints));
            currentPoints.clear();
          });
        },
        child: CustomPaint(
          painter: DrawingPainter(allPoints, currentPoints, penColor, penWidth),
          size: Size.infinite,
        ),
      ),
    );
  }
}


class DrawingPainter extends CustomPainter {
  final List<List<Offset?>> allPoints;
  final List<Offset?> currentPoints;
  final Color penColor;
  final double penWidth;

  DrawingPainter(this.allPoints, this.currentPoints, this.penColor, this.penWidth);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = penColor
      ..strokeCap = StrokeCap.round
      ..strokeWidth = penWidth;

    // Draw all stored points
    for (var points in allPoints) {
      for (int i = 0; i < points.length - 1; i++) {
        if (points[i] != null && points[i + 1] != null) {
          canvas.drawLine(points[i]!, points[i + 1]!, paint);
        }
      }
    }

    // Draw the current stroke
    for (int i = 0; i < currentPoints.length - 1; i++) {
      if (currentPoints[i] != null && currentPoints[i + 1] != null) {
        canvas.drawLine(currentPoints[i]!, currentPoints[i + 1]!, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true; // Repaint on every frame
  }
}
