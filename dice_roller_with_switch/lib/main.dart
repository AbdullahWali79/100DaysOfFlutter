import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(DiceApp());

class DiceApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dice Roller',
      theme: ThemeData(
        primarySwatch: Colors.green,
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
  int _diceNumber = 0; // Initial dice number

  // Function to roll the dice
  void _rollDice() {
      setState(() {///0 to 5
        _diceNumber = Random().nextInt(6) + 1;
      });// Random dice number from 1 to 6
    //print(_diceNumber);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dice Roller'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Rolling Number: $_diceNumber',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            // Dice image
            Image.asset(
              'images/dice-$_diceNumber.png',
              height: 250,
            ),
            SizedBox(height: 20),
            // Button to roll the dice
            ElevatedButton(
              // onPressed: (){
              //   _rollDice();
              // },
              onPressed: _rollDice,
              child: Text(' Roll the Dice  '),
            ),
          ],
        ),
      ),
    );
  }
}
