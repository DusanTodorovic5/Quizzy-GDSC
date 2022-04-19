import 'package:quizzy/classes/category_type.dart';

class Question{
  Question({required this.text, required this.answers, required this.category}){
    correctAnswer = answers[0];
    answers.shuffle();
  }

  factory Question.fromJson(Map<String, dynamic> _json){
    CategoryType category = CategoryType.math;
    switch (_json['Category']){
      case "Cars" : category = CategoryType.cars; break;
      case "Math" : category = CategoryType.math; break;
      case "Geography" : category = CategoryType.geography; break;
      case "History" : category = CategoryType.history; break;
      case "Movies" : category = CategoryType.movies; break;
      case "Programming" : category = CategoryType.programming; break; 
    }

    return Question(text: _json["Text"], answers: List<String>.from(_json["Answers"]), category: category);
  }

  bool checkCorrect(){
    return answers[selectedAnswer] == correctAnswer;
  }

  String text;
  List<String> answers;
  String correctAnswer = "";
  CategoryType category;
  int selectedAnswer = -1;
}