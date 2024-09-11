import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For Age Calculator (to format date)

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MultiCalculatorApp(),
    );
  }
}

class MultiCalculatorApp extends StatefulWidget {
  @override
  _MultiCalculatorAppState createState() => _MultiCalculatorAppState();
}

class _MultiCalculatorAppState extends State<MultiCalculatorApp> {
  String selectedCalculator = '';

  // Controllers for the different calculators
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController billAmountController = TextEditingController();
  TextEditingController tipPercentageController = TextEditingController();
  TextEditingController birthDateController = TextEditingController();

  double result = 0;

  // Functions for each calculator
  void calculateBMI() {
    double weight = double.parse(weightController.text);
    double height = double.parse(heightController.text) / 100; // Convert cm to meters
    setState(() {
      result = weight / (height * height);
    });
  }

  void calculateTip() {
    double billAmount = double.parse(billAmountController.text);
    double tipPercentage = double.parse(tipPercentageController.text);
    setState(() {
      result = billAmount + (billAmount * (tipPercentage / 100));
    });
  }

  void calculateAge() {
    DateTime birthDate = DateFormat("yyyy-MM-dd").parse(birthDateController.text);
    DateTime today = DateTime.now();
    int age = today.year - birthDate.year;
    if (today.month < birthDate.month || (today.month == birthDate.month && today.day < birthDate.day)) {
      age--;
    }
    setState(() {
      result = age.toDouble();
    });
  }

  // UI for selecting and displaying the correct calculator
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Multi Calculator'),
      ),
      body: Column(
        children: <Widget>[
          // Buttons to select calculator
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    selectedCalculator = 'BMI';
                  });
                },
                child: Text('BMI Calculator'),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    selectedCalculator = 'Tip';
                  });
                },
                child: Text('Tip Calculator'),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    selectedCalculator = 'Age';
                  });
                },
                child: Text('Age Calculator'),
              ),
            ],
          ),

          // Display the relevant text fields based on the selected calculator
          if (selectedCalculator == 'BMI') ...[
            TextField(
              controller: weightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Enter your weight (kg)'),
            ),
            TextField(
              controller: heightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Enter your height (cm)'),
            ),
            ElevatedButton(
              onPressed: calculateBMI,
              child: Text('Calculate BMI'),
            ),
          ] else if (selectedCalculator == 'Tip') ...[
            TextField(
              controller: billAmountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Enter Bill Amount'),
            ),
            TextField(
              controller: tipPercentageController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Enter Tip Percentage'),
            ),
            ElevatedButton(
              onPressed: calculateTip,
              child: Text('Calculate Tip'),
            ),
          ] else if (selectedCalculator == 'Age') ...[
            TextField(
              controller: birthDateController,
              keyboardType: TextInputType.datetime,
              decoration: InputDecoration(
                  labelText: 'Enter Birthdate (YYYY-MM-DD)'),
            ),
            ElevatedButton(
              onPressed: calculateAge,
              child: Text('Calculate Age'),
            ),
          ],

          SizedBox(height: 20),

          // Display the result of the calculation
          Text(
            'Result: $result',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
