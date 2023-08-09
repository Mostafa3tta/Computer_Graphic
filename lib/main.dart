import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphics/shapes/Bresenham.dart';
import 'package:graphics/shapes/Circle.dart';
import 'package:graphics/shapes/DDA.dart';
import 'package:graphics/shapes/Ellipce.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Graphics",
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.topLeft,
                colors: [
                  Colors.orangeAccent.shade200,
                  Colors.amberAccent.shade200,
                ],
              ),
            ),
          ),
          title: Center(
            child: Text(
              "Computer Graphics",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
          ),
          bottom: TabBar(
            indicatorColor: Colors.deepOrange,
            tabs: <Widget>[
              Tab(
                  icon: Icon(Icons.stacked_line_chart,
                      color: Colors.teal[300], size: 35)),
              Tab(icon: Image.asset("assets/images/bresenham.png")),
              Tab(icon: Icon(Icons.circle, color: Colors.teal[300], size: 35)),
              Tab(icon: Image.asset("assets/images/ellipse.png")),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            DDA(),
            Bresenham(),
            Circle(),
            Eilips(),
          ],
        ),
      ),
    );
  }
}

//backgroundColor: Colors.transparent,
