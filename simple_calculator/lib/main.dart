import 'package:flutter/material.dart';

void main() => runApp(MyApp());
// void main(){
//   runApp(My App());
// }
//Differenc ebetween Stateless and statfull
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  TextEditingController num1Controller = TextEditingController();
  TextEditingController num2Controller = TextEditingController();

  double result = 0;

  void add() {
    setState(() {
      double num1 = double.parse(num1Controller.text);
      double num2 = double.parse(num2Controller.text);
      result = num1 + num2;
    });
  }

  void subtract() {
    setState(() {
      double num1 = double.parse(num1Controller.text);
      double num2 = double.parse(num2Controller.text);
      result = num1 - num2;
    });
  }

  void multiply() {
    setState(() {
      double num1 = double.parse(num1Controller.text);
      double num2 = double.parse(num2Controller.text);
      result = num1 * num2;
    });
  }

  void divide() {
    setState(() {
      double num1 = double.parse(num1Controller.text);
      double num2 = double.parse(num2Controller.text);
      if (num2 != 0) {
        result = num1 / num2;
      } else {
        result = 0; // Handle divide by zero
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Simple Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: num1Controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Enter first number'),
            ),
            TextField(
              controller: num2Controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Enter second number'),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: add,
                  child: Text('Add'),
                ),
                ElevatedButton(
                  onPressed: subtract,
                  child: Text('Subtract'),
                ),
                ElevatedButton(
                  onPressed: multiply,
                  child: Text('Multiply'),
                ),
                ElevatedButton(
                  onPressed: divide,
                  child: Text('Divide'),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Result: $result',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
