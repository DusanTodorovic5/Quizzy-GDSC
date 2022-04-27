import 'package:quizzy/classes/category.dart';

class Question {
  Question(
      {required this.text, required this.answers, required this.category}) {
    correctAnswer = answers[0];
    answers.shuffle();
  }

  factory Question.fromJson(Map<String, dynamic> _json) {
    Category category = Category.math;
    switch (_json['Category']) {
      case "Cars":
        category = Category.cars;
        break;
      case "Math":
        category = Category.math;
        break;
      case "Geography":
        category = Category.geography;
        break;
      case "History":
        category = Category.history;
        break;
      case "Movies":
        category = Category.movies;
        break;
      case "Programming":
        category = Category.programming;
        break;
    }

    return Question(
        text: _json["Text"],
        answers: List<String>.from(_json["Answers"]),
        category: category);
  }

  bool checkCorrect() {
    return answers[selectedAnswer] == correctAnswer;
  }

  String text;
  List<String> answers;
  String correctAnswer = "";
  Category category;
  int selectedAnswer = -1;
}
