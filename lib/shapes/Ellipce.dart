import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'dart:math';

class Eilips extends StatefulWidget {
  @override
  _EilipsState createState() => _EilipsState();
}

List<Offset> points = [];
int table_step = 0;

TextEditingController Xc = TextEditingController();

TextEditingController Yc = TextEditingController();

TextEditingController Rx = TextEditingController();

TextEditingController Ry = TextEditingController();

double xc = 0.0, yc = 0.0, rx = 0.0, ry = 0.0;
double x = 0.0, y = 0.0;

class _EilipsState extends State<Eilips> {
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
              "Draw Ellipse",
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
              SizedBox(width: 37),
              Text(
                "Rx:  ",
                style: TextStyle(color: Colors.deepOrange[100], fontSize: 20),
              ),
              Expanded(
                child: TextField(
                  controller: Rx,
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
                "Ry:  ",
                style: TextStyle(color: Colors.deepOrange[100], fontSize: 20),
              ),
              Expanded(
                child: TextField(
                  controller: Ry,
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
              SizedBox(width: 23),
              Text(
                "Xc:  ",
                style: TextStyle(color: Colors.deepOrange[100], fontSize: 20),
              ),
              Expanded(
                child: TextField(
                  controller: Xc,
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
                "Yc:  ",
                style: TextStyle(color: Colors.deepOrange[100], fontSize: 20),
              ),
              Expanded(
                child: TextField(
                  controller: Yc,
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
                    rx = 0.0;
                    ry = 0.0;
                    x = 0.0;
                    y = 0.0;
                    xc = 0.0;
                    yc = 0.0;
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
                    xc = double.parse(Xc.value.text);
                    yc = double.parse(Yc.value.text);
                    rx = double.parse(Rx.value.text);
                    ry = double.parse(Ry.value.text);
                    repaint = true;
                    print(table_step);
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
            height: 1000,
            child: repaint == true
                ? CustomPaint(
                    painter: Point(
                      Offset(rx, ry),
                      Offset(xc, yc),
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
  late Offset R;
  late Offset Points;

  Point(this.R, this.Points);

  final pointMode = ui.PointMode.points;

  @override
  void paint(canvas, size) {
    double Rx2 = rx * rx;
    double Ry2 = ry * ry;

    int twoRx2 = 2 * Rx2.toInt();
    int twoRy2 = 2 * Ry2.toInt();

    double p;
    int x = 0, y = ry.toInt(), dx = twoRy2 * x, dy = twoRx2 * y;

    //regoin 1
    p = pow(ry, 2) - (pow(rx, 2) * ry) + (pow(rx, 2) * 0.25);
    do {
      x++;
      dx = twoRy2 * x;

      if (p < 0)
        p += Ry2 + dx;
      else {
        y--;
        dy = twoRx2 * y;
        p += Ry2 + dx - dy;
      }

      points.add(Offset(xc + x, yc + y));
      points.add(Offset(xc - x, yc + y));
      points.add(Offset(xc - x, yc - y));
      points.add(Offset(xc + x, yc - y));
    } while (dx < dy);

    //regoin 2
    p = ((y - 1) * Rx2 * (y - 1) + Ry2 * (x + .5) * (x + .5) - Rx2 * Ry2)
        .round()
        .toDouble();
    p.toInt();
    while (y > 0) {
      y--;
      dy = twoRx2 * y;
      if (p > 0) {
        p += Rx2 - dy;
      } else {
        x++;
        dx = twoRy2 * x;
        p += Rx2 - dy + dx;
      }

      points.add(Offset(xc + x, yc + y));
      points.add(Offset(xc - x, yc + y));
      points.add(Offset(xc - x, yc - y));
      points.add(Offset(xc + x, yc - y));
    }

    // table_step = steps;
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
