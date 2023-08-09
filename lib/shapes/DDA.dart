import 'dart:core';
import 'dart:math' as Math;
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:graphics/shapes/Circle.dart';

class DDA extends StatefulWidget {
  DDA();
  @override
  _DDAState createState() => _DDAState();
}

List<Offset> points = [];
int table_step = 0;


class _DDAState extends State<DDA> {
  TextEditingController c1 = TextEditingController();

  TextEditingController c2 = TextEditingController();

  TextEditingController c3 = TextEditingController();

  TextEditingController c4 = TextEditingController();

  TextEditingController c5 = TextEditingController();

  TextEditingController c6 = TextEditingController();

  TextEditingController c7 = TextEditingController();

  TextEditingController c8 = TextEditingController();

  TextEditingController c9 = TextEditingController();

  dynamic x1 = 0.0, x2 = 0.0, y1 = 0.0, y2 = 0.0;

  bool repaint = false;

  // translate
  bool translate = false;
  bool scale = false;
  bool rotate = false;


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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Draw DDA Line",
                style: TextStyle(
                  color: Colors.deepOrange,
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
              DropdownButton(
                iconSize: 40,
                dropdownColor: Colors.deepOrange[100],
                underline: Container(),
                icon: Icon(
                  Icons.more_vert,
                  color: Colors.deepOrange,
                ),
                items: [
                  DropdownMenuItem(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.transform, color: Colors.deepOrange),
                        SizedBox(width: 8),
                        Text(
                          'Translation',
                          style: TextStyle(fontWeight: FontWeight.bold,color: Colors.deepOrange),
                        ),
                      ],
                    ),
                    value: 'translate',
                  ),
                  DropdownMenuItem(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.linear_scale_rounded, color: Colors.deepOrange),
                        SizedBox(width: 8),
                        Text(
                          'Scaling',
                          style: TextStyle(fontWeight: FontWeight.bold,color: Colors.deepOrange),
                        ),
                      ],
                    ),
                    value: 'scale',
                  ),
                  DropdownMenuItem(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.crop_rotate_rounded, color: Colors.deepOrange),
                        SizedBox(width: 8),
                        Text(
                          'Rotation',
                          style: TextStyle(fontWeight: FontWeight.bold,color: Colors.deepOrange),
                        ),
                      ],
                    ),
                    value: 'rotate',
                  ),
                  DropdownMenuItem(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.cut_rounded, color: Colors.deepOrange),
                        SizedBox(width: 8),
                        Text(
                          'Clipping',
                          style: TextStyle(fontWeight: FontWeight.bold,color: Colors.deepOrange),
                        ),
                      ],
                    ),
                    value: 'clip',
                  ),
                ],
                onChanged: (item) {
                  if (item == 'translate') {
                    setState(() {
                      translate = true;
                      repaint = false;
                      rotate = false;
                      scale = false;
                    });
                  }
                  else if (item == 'scale') {
                    setState(() {
                      scale = true;
                      repaint = false;
                      rotate = false;
                      translate = false;
                    });
                  }
                  if (item == 'rotate') {
                    setState(() {
                      rotate = true;
                      translate = false;
                      repaint = false;
                      scale = false;
                    });
                  }
                },
              ),
            ],
          ),
          SizedBox(height: 20),
          if(!translate && !scale && !rotate)
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
          if(!translate && !scale && !rotate)
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
          if(translate)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: 10),
                Text(
                  "New Position",
                  style: TextStyle(
                    color: Colors.deepOrange,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                SizedBox(width: 25),
                Text(
                  "X:  ",
                  style: TextStyle(color: Colors.deepOrange[100], fontSize: 20),
                ),
                Expanded(
                  child: TextField(
                    controller: c5,
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
                SizedBox(width: 20),
                Text(
                  "Y:  ",
                  style: TextStyle(color: Colors.deepOrange[100], fontSize: 20),
                ),
                Expanded(
                  child: TextField(
                    controller: c6,
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
                SizedBox(width: 27),
              ],
            ),
          if(scale)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: 10),
                Text(
                  "New Position",
                  style: TextStyle(
                    color: Colors.deepOrange,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                SizedBox(width: 25),
                Text(
                  "X:  ",
                  style: TextStyle(color: Colors.deepOrange[100], fontSize: 20),
                ),
                Expanded(
                  child: TextField(
                    controller: c7,
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
                SizedBox(width: 20),
                Text(
                  "Y:  ",
                  style: TextStyle(color: Colors.deepOrange[100], fontSize: 20),
                ),
                Expanded(
                  child: TextField(
                    controller: c8,
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
                SizedBox(width: 25),
              ],
            ),
          if(rotate)
            Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(width: 10),
              Text(
                "Angle",
                style: TextStyle(
                  color: Colors.deepOrange,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(width: 25),
              Expanded(
                child: TextField(
                  controller: c9,
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
              SizedBox(width: 20),
            ],
          ),
          SizedBox(height: 20),
          if(!translate && !scale && !rotate)
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
                      table_step = 0;
                      points = [];
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
          if(translate)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton.extended(
                  backgroundColor: Colors.deepOrange[100],
                  icon: Icon(Icons.arrow_back_ios, color: Colors.deepOrange),
                  onPressed: () {
                    setState(() {
                      translate = false;
                      c5.text = '';
                      c6.text = '';
                    });
                  },
                  label: Text(
                    "Back",
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
                  icon: Icon(Icons.transform, color: Colors.deepOrange),
                  onPressed: () {
                    setState(() {
                      x1 += double.parse(c5.value.text);
                      y1 += double.parse(c6.value.text);
                      x2 += double.parse(c5.value.text);
                      y2 += double.parse(c6.value.text);
                      points = [];
                      repaint = true;
                    });
                  },
                  label: Text(
                    "Translate",
                    style: TextStyle(
                      color: Colors.deepOrange,
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                ),
              ],
            ),
          if(scale)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: 50),
                FloatingActionButton.extended(
                  backgroundColor: Colors.deepOrange[100],
                  icon: Icon(Icons.arrow_back_ios, color: Colors.deepOrange),
                  onPressed: () {
                    setState(() {
                      scale = false;
                      c7.text = '';
                      c8.text = '';
                    });
                  },
                  label: Text(
                    "Back",
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
                  icon: Icon(Icons.linear_scale_rounded, color: Colors.deepOrange),
                  onPressed: () {
                    setState(() {
                      x1 *= double.parse(c7.value.text);
                      y1 *= double.parse(c8.value.text);
                      x2 *= double.parse(c7.value.text);
                      y2 *= double.parse(c8.value.text);
                      points = [];
                      repaint = true;
                    });
                  },
                  label: Text(
                    "Scale",
                    style: TextStyle(
                      color: Colors.deepOrange,
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                ),
              ],
            ),
          if(rotate)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: 50),
                FloatingActionButton.extended(
                  backgroundColor: Colors.deepOrange[100],
                  icon: Icon(Icons.arrow_back_ios, color: Colors.deepOrange),
                  onPressed: () {
                    setState(() {
                      rotate = false;
                      c9.text = '';
                    });
                  },
                  label: Text(
                    "Back",
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
                  icon: Icon(Icons.crop_rotate_rounded, color: Colors.deepOrange),
                  onPressed: () {
                    setState(() {
                      double angle = double.parse(c9.text) * 0.01745;
                      double x4 = (x2 - ((x2 - x1) * Math.cos(angle) - (y2 - y1) * Math.sin(angle))) ;
                      double y4 = (y2 - ((x2 - x1) * Math.sin(angle) + (y2 - y1) * Math.cos(angle))) ;
                      points=[];
                      x2 = x4;
                      y2 = y4;
                      repaint = true;
                    });
                  },
                  label: Text(
                    "Rotate",
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
          if(!translate && repaint && !scale)
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
          if(!translate && repaint && !scale && !rotate)
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
  late Offset start;
  late Offset end;

  Point(this.start, this.end);

  final pointMode = ui.PointMode.points;



  @override
  void paint(canvas, size) {
    int dx = (end.dx - start.dx).round();
    int dy = (end.dy - start.dy).round();
    int steps = (dx.abs() > dy.abs()) ? dx.abs() : dy.abs();
    double step = steps.toDouble();
    double Xinc = dx / step;
    double Yinc = dy / step;
    double x = start.dx, y = start.dy;
    for (int i = 0; i <= steps; i++) {
      points.add(Offset(x, y));
      x += Xinc;
      y += Yinc;
    }
    table_step = steps + 1;
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
