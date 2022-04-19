import 'package:quizzy/classes/category_type.dart';

class Connector{
  Connector({required this.text, required this.fields, required this.category}){
    anchors = fields.values.toList()..shuffle();
    for (String anchor in anchors){
      answered[anchor] = 0;
    }
  }

  factory Connector.fromJson(Map<String, dynamic> _json){
    CategoryType category = CategoryType.math;
    switch (_json['Category']){
      case "Cars" : category = CategoryType.cars; break;
      case "Math" : category = CategoryType.math; break;
      case "Geography" : category = CategoryType.geography; break;
      case "History" : category = CategoryType.history; break;
      case "Movies" : category = CategoryType.movies; break;
      case "Programming" : category = CategoryType.programming; break; 
    }
    return Connector(text: _json["Text"], fields: Map<String, String>.from(_json["Answers"]), category: category);
  }

  String text;
  Map<String, String> fields;
  Map<String, int> answered = {};
  List<String> anchors = [];
  CategoryType category;
}