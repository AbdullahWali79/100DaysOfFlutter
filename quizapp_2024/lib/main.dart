import 'package:flutter/material.dart';
import 'quiz_brain.dart';

QuizBrain quizBrain = QuizBrain();
void main() => runApp(QuizApp());
class QuizApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: QuizPage(),
    );
  }
}
class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}
class _QuizPageState extends State<QuizPage> {
  List<Icon> scoreKeeper = [];
  int score = 0;
  bool isQuizStarted = false;
  int timer = 5;
  void checkAnswer(bool userPickedAnswer) {
    bool correctAnswer = quizBrain.getAnswer();
    setState(() {
      if (correctAnswer == userPickedAnswer) {
        scoreKeeper.add(Icon(Icons.check, color: Colors.green));
        score++;
      } else {
        scoreKeeper.add(Icon(Icons.close, color: Colors.red));
      }
      if (quizBrain.isFinished()) {
        showResult();
      } else {
        quizBrain.nextQuestion();
        timer = 5;
        startTimer();
      }
    });
  }
  void startQuiz() {
    setState(() {
      isQuizStarted = true;
      startTimer();
    });
  }
  void startTimer() {
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        if (timer > 0) {
          timer--;
          startTimer();
        } else {
          checkAnswer(false); // Timeout, move to next question
        }
      });
    });
  }
  void showResult() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Quiz Completed!"),
          content: Text("Your score is $score/10"),
          actions: [
            TextButton(
              child: Text("Restart"),
              onPressed: () {
                setState(() {
                  quizBrain.reset();
                  scoreKeeper.clear();
                  score = 0;
                  timer = 5;
                  isQuizStarted = false;
                  Navigator.of(context).pop();
                });
              },
            ),
          ],
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: isQuizStarted ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Time Left: $timer seconds',
              style: TextStyle(fontSize: 20.0),
            ),
            Text(
              quizBrain.getQuestion(),
              style: TextStyle(fontSize: 20.0),
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      child: Text('True'),
                      onPressed: () {
                        checkAnswer(true);
                      },
                    ),
                  ),
                  Expanded(
                    child: ElevatedButton(
                      child: Text('False'),
                      onPressed: () {
                        checkAnswer(false);
                      },
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: scoreKeeper,
            ),
          ],
        ) : Center(
          child: ElevatedButton(
            onPressed: startQuiz,
            child: Text('Start Quiz'),
          ),
        ),
      ),
    );
  }
}
