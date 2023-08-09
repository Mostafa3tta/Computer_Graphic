import 'dart:math' as Math;
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class Bresenham extends StatefulWidget {
  @override
  _BresenhamState createState() => _BresenhamState();
}

class _BresenhamState extends State<Bresenham> {
  TextEditingController c1 = TextEditingController();

  TextEditingController c2 = TextEditingController();

  TextEditingController c3 = TextEditingController();

  TextEditingController c4 = TextEditingController();

  dynamic x1 = 0.0, x2 = 0.0, y1 = 0.0, y2 = 0.0;

  bool repaint = false;

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: ListView(
        children: [
          SizedBox(height: 20),
          Center(
            child: Text(
              "Draw Bresenham Line",
              style: TextStyle(
                color: Colors.deepOrange,
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(width: 10),
              Text(
                "Start Point",
                style: TextStyle(
                  color: Colors.deepOrange,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(width: 40),
              Text(
                "X:  ",
                style: TextStyle(color: Colors.deepOrange[100], fontSize: 20),
              ),
              Expanded(
                child: TextField(
                  controller: c1,
                  cursorColor: Colors.deepOrange,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.deepOrange[100],
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 2),
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              SizedBox(width: 40),
              Text(
                "Y:  ",
                style: TextStyle(color: Colors.deepOrange[100], fontSize: 20),
              ),
              Expanded(
                child: TextField(
                  controller: c2,
                  cursorColor: Colors.deepOrange,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.deepOrange[100],
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 2),
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              SizedBox(width: 10),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(width: 10),
              Text(
                "End Point",
                style: TextStyle(
                  color: Colors.deepOrange,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(width: 50),
              Text(
                "X:  ",
                style: TextStyle(color: Colors.deepOrange[100], fontSize: 20),
              ),
              Expanded(
                child: TextField(
                  controller: c3,
                  cursorColor: Colors.deepOrange,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.deepOrange[100],
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 2),
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              SizedBox(width: 40),
              Text(
                "Y:  ",
                style: TextStyle(color: Colors.deepOrange[100], fontSize: 20),
              ),
              Expanded(
                child: TextField(
                  controller: c4,
                  cursorColor: Colors.deepOrange,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.deepOrange[100],
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 2),
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              SizedBox(width: 10),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FloatingActionButton.extended(
                backgroundColor: Colors.deepOrange[100],
                icon: Icon(Icons.delete, color: Colors.deepOrange),
                onPressed: () {
                  setState(() {
                    x1 = 0.0;
                    y1 = 0.0;
                    x2 = 0.0;
                    y2 = 0.0;
                    c1.text = '';
                    c2.text = '';
                    c3.text = '';
                    c4.text = '';
                    repaint = false;
                  });
                },
                label: Text(
                  "Delete",
                  style: TextStyle(
                    color: Colors.deepOrange,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
              ),
              SizedBox(width: 20),
              FloatingActionButton.extended(
                backgroundColor: Colors.deepOrange[100],
                icon: Icon(Icons.graphic_eq_outlined, color: Colors.deepOrange),
                onPressed: () {
                  setState(() {
                    x1 = double.parse(c1.value.text);
                    y1 = double.parse(c2.value.text);
                    x2 = double.parse(c3.value.text);
                    y2 = double.parse(c4.value.text);
                    repaint = true;
                  });
                },
                label: Text(
                  "Draw ",
                  style: TextStyle(
                    color: Colors.deepOrange,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Container(
            color: Colors.deepOrange[100],
            width: double.infinity,
            height: y2 > 400 ? y2 + 50 : 400,
            child: repaint == true
                ? CustomPaint(
                    painter: Point(
                      Offset(x1, y1),
                      Offset(x2, y2),
                    ),
                  )
                : null,
          ),
          SizedBox(height: 50),
          Center(
            child: Text(
              "Table",
              style: TextStyle(
                color: Colors.deepOrange,
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
          ),
          SizedBox(height: 50),
        ],
      ),
    );
  }
}

class Point extends CustomPainter {
  List<Offset> points = [];

  late Offset start;
  late Offset end;

  Point(this.start, this.end);

  final pointMode = ui.PointMode.points;

  @override
  void paint(canvas, size) {
    int dx = (end.dx - start.dx).round();
    int dy = (end.dy - start.dy).round();
    int x = start.dx.round();
    int y = start.dy.round();
    int P0 = (2 * dy) - dx;
    for (int i = 0; i < dx; i++) {
      if (P0 > 0) {
        P0 = P0 + 2 * dy - 2 * dx;
        y++;
      } else {
        P0 = P0 + 2 * dy;
      }
      x++;
      points.add(Offset(x.toDouble(), y.toDouble()));
    }
    final paint = Paint()
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round
      ..color = Colors.deepOrangeAccent;
    canvas.drawPoints(pointMode, points, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }
}
