import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const DiceRollApp());
}

class DiceRollApp extends StatelessWidget {
  const DiceRollApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dice Roll Game',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const DiceRollPage(),
    );
  }
}

class DiceRollPage extends StatefulWidget {
  const DiceRollPage({Key? key}) : super(key: key);

  @override
  _DiceRollPageState createState() => _DiceRollPageState();
}

class _DiceRollPageState extends State<DiceRollPage>
    with SingleTickerProviderStateMixin {
  int _userGuess = 1;
  int _diceResult = 1;
  int _score = 0;
  late AnimationController _controller;
  late Animation<double> _animationRotation;
  late Animation<double> _animationScale;
  bool _isRolling = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _animationRotation = Tween<double>(begin: 0, end: 4 * pi)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _animationScale = Tween<double>(begin: 1.0, end: 0.8)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  void _rollDice() {
    setState(() {
      _isRolling = true;
      _controller.forward().then((_) {
        int result = Random().nextInt(6) + 1;
        setState(() {
          _diceResult = result;
        });

        _controller.reverse().then((_) {
          Future.delayed(const Duration(milliseconds: 500), () {
            setState(() {
              if (_userGuess == result) {
                _score++;
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Correct Guess! ')),
                );
              } else {
                _score--;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Wrong! It was $_diceResult ')),
                );
              }
              _isRolling = false;
              _controller.reset();
            });
          });
        });
      });
    });
  }

  void _resetGame() {
    setState(() {
      _userGuess = 1;
      _diceResult = 1;
      _score = 0;
      _controller.reset();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text('Dice Roll Game'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _resetGame,
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Score: $_score',
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              const Text(
                'Select your guess (1-6):',
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(6, (index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: ElevatedButton(
                      onPressed: _isRolling
                          ? null
                          : () {
                              setState(() {
                                _userGuess = index + 1;
                              });
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _userGuess == index + 1
                            ? Colors.deepPurple
                            : Colors.grey,
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(20),
                      ),
                      child: Text(
                        '${index + 1}',
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 40),
              AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _animationScale.value,
                    child: Transform.rotate(
                      angle: _animationRotation.value,
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.deepPurple,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Center(
                          child: Text(
                            '$_diceResult',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: _isRolling ? null : _rollDice,
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'Roll Dice',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
