import 'category.dart';

class Connector {
  Connector(
      {required this.text, required this.fields, required this.category}) {
    anchors = fields.values.toList()..shuffle();
    for (String anchor in anchors) {
      answered[anchor] = 0;
    }
  }

  factory Connector.fromJson(Map<String, dynamic> _json) {
    Category category = Category.math;
    switch (_json['Category']) {
      case "GDSC":
        category = Category.gdsc;
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
    return Connector(
        text: _json["Text"],
        fields: Map<String, String>.from(_json["Answers"]),
        category: category);
  }

  String text;
  Map<String, String> fields;
  Map<String, int> answered = {};
  List<String> anchors = [];
  Category category;
}
