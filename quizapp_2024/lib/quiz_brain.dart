import 'quiz.dart';

class QuizBrain {
  List<Quiz> _questionBank = [
    Quiz(questionText: 'Flutter is a framework?', answer: true),
    Quiz(questionText: 'Flutter uses Dart language?', answer: true),
  ];
  int _questionIndex = 0;
  String getQuestion() {
    return _questionBank[_questionIndex].questionText;
  }
  bool getAnswer() {
    return _questionBank[_questionIndex].answer;
  }
  void nextQuestion() {
    if (_questionIndex < _questionBank.length - 1) {
      _questionIndex++;
    }
  }
  bool isFinished() {
    return _questionIndex >= _questionBank.length - 1;
  }
  void reset() {
    _questionIndex = 0;
  }
}