import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(DiceApp());

class DiceApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dice Roller',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DiceScreen(),
    );
  }
}

class DiceScreen extends StatefulWidget {
  @override
  _DiceScreenState createState() => _DiceScreenState();
}

class _DiceScreenState extends State<DiceScreen> {
  int _diceNumber = 1; // Initial dice number

  // Function to roll the dice
  void _rollDice() {
    setState(() {
      _diceNumber = Random().nextInt(6) + 1; // Random dice number from 1 to 6
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dice Roller'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Roll the Dice!',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          // Dice image
          Image.asset(
            'images/dice-$_diceNumber.png',
            height: 150,
          ),
          SizedBox(height: 20),
          // Button to roll the dice
          ElevatedButton(
            onPressed: _rollDice,
            child: Text('Roll Dice'),
          ),
        ],
      ),
    );
  }
}
