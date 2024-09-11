import 'package:flutter/material.dart'; // Library

void main() {
  int a, b;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("First App"),
          centerTitle: true,
        ),
        body: Center(child: Text("Muhammad Abdullah"),),
      ),
    );
  }
}

// MaterialApp(
// debugShowCheckedModeBanner: false,
// home: Scaffold(
// appBar: AppBar(
// title: Text('Hello World App'),
// ),
// body: Center(
// child: Text(
// 'Hello World!',
// style: TextStyle(fontSize: 24),
// ),
// ),
// ),
// )
