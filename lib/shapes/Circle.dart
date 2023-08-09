import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'dart:math';

class Circle extends StatefulWidget {
  @override
  _CircleState createState() => _CircleState();
}

List<Offset> points = [];
int table_step = 0;

double x = 0.0, y = 0.0, radius = 0;
double x0 = 0.0, y0 = 0.0;

TextEditingController R = TextEditingController();

TextEditingController X0 = TextEditingController();

TextEditingController Y0 = TextEditingController();

class _CircleState extends State<Circle> {
  bool repaint = false;

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: ListView(
        children: [
          SizedBox(height: 20),
          Center(
            child: Text(
              "Draw Circle",
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
                "Radius",
                style: TextStyle(
                  color: Colors.deepOrange,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(width: 90),
              Expanded(
                child: TextField(
                  controller: R,
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
                "Position",
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
                  controller: X0,
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
                  controller: Y0,
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
                    x = 0.0;
                    y = 0.0;
                    x0 = 0;
                    y0 = 0;
                    radius = 0;
                    points.clear();
                    repaint = false;
                    table_step = 0;
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
                    x0 = double.parse(X0.value.text);
                    y0 = double.parse(Y0.value.text);
                    radius = double.parse(R.value.text);
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
            height: 400,
            child: repaint == true
                ? CustomPaint(
                    painter: Point(
                      radius,
                      Offset(x0, y0),
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
          Table(
            border: TableBorder.all(color: Colors.deepOrange.shade100),
            children: [
              TableRow(
                children: [
                  Center(
                      child: Text(
                    "X",
                    style: TextStyle(
                        color: Colors.deepOrange,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  )),
                  Center(
                      child: Text("Y",
                          style: TextStyle(
                              color: Colors.deepOrange,
                              fontWeight: FontWeight.bold,
                              fontSize: 20))),
                  Center(
                      child: Text(
                    "X Plotted",
                    style: TextStyle(
                        color: Colors.deepOrange,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  )),
                  Center(
                      child: Text("Y Plotted",
                          style: TextStyle(
                              color: Colors.deepOrange,
                              fontWeight: FontWeight.bold,
                              fontSize: 20))),
                ],
              ),
              for (int i = 0; i < table_step; i++)
                TableRow(
                  children: [
                    Center(
                        child: Text(
                      "${points.elementAt(i).dx}",
                      style: TextStyle(
                          color: Colors.deepOrange,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    )),
                    Center(
                        child: Text("${points.elementAt(i).dy}",
                            style: TextStyle(
                                color: Colors.deepOrange,
                                fontWeight: FontWeight.bold,
                                fontSize: 20))),
                    Center(
                        child: Text(
                      "${points.elementAt(i).dx.round()}",
                      style: TextStyle(
                          color: Colors.deepOrange,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    )),
                    Center(
                        child: Text("${points.elementAt(i).dy.round()}",
                            style: TextStyle(
                                color: Colors.deepOrange,
                                fontWeight: FontWeight.bold,
                                fontSize: 20))),
                  ],
                ),
            ],
          ),
          SizedBox(height: 50),
        ],
      ),
    );
  }
}

class Point extends CustomPainter {
  double R;
  late Offset Points;

  Point(this.R, this.Points);

  final pointMode = ui.PointMode.points;

  @override
  void paint(canvas, size) {
    int x = 0;
    int y = radius.toInt();
    int p = 1 - radius.toInt();
    points.add(Offset(x0, y0 + radius));
    points.add(Offset(x0, y0 - radius));
    points.add(Offset(x0 + radius, y0));
    points.add(Offset(x0 - radius, y0));
    while (x < y) {
      x++;
      if (p < 0) {
        p += 2 * x + 1;
      } else {
        y--;
        p += 2 * (x - y) + 1;
      }
      points.add(Offset(x0 + x, y0 + y));
      points.add(Offset(x0 - x, y0 + y));
      points.add(Offset(x0 + x, y0 - y));
      points.add(Offset(x0 - x, y0 - y));
      points.add(Offset(x0 + y, y0 + x));
      points.add(Offset(x0 - y, y0 + x));
      points.add(Offset(x0 + y, y0 - x));
      points.add(Offset(x0 - y, y0 - x));
    }
    final paint = Paint()
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round
      ..color = Colors.deepOrangeAccent;
    canvas.drawPoints(pointMode, points, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
