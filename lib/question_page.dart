import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:quizzy/classes/category_type.dart';
import 'package:quizzy/classes/question.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';

class QuestionPage extends StatefulWidget {
  QuestionPage({Key? key, required this.categories}) : super(key: key) {
    print("Hello");
  }

  List<Question> questions = [
    Question(text: "", answers: [""], category: CategoryType.math),
    Question(text: "", answers: [""], category: CategoryType.math),
    Question(text: "", answers: [""], category: CategoryType.math),
    Question(text: "", answers: [""], category: CategoryType.math),
    Question(text: "", answers: [""], category: CategoryType.math),
  ];
  Map<CategoryType, bool> categories;
  @override
  State<QuestionPage> createState() => _QuestionPageState();

  Future<List<Question>> loadQuestions() async {
    List<Question> allQuestions = [];
    final _json = await rootBundle.loadString('assets/questions.json');

    var parsed = json.decode(_json);

    var list = parsed as List;

    for (var question in list) {
      var q = Question.fromJson(question);
      if (categories[q.category] == true) {
        allQuestions.add(q);
      }
    }

    allQuestions.shuffle();

    questions = allQuestions.take(5).toList();

    return questions;
  }
}

class _QuestionPageState extends State<QuestionPage> {
  double _deviceHeight = 0;
  double _deviceWidth = 0;

  @override
  void initState() {
    super.initState();
    questions = widget.loadQuestions();
  }

  late Future<List<Question>> questions;

  void showCompleted(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context, rootNavigator: true).pop();
            },
            child: AlertDialog(
              title: const Text("Results"),
              content: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: widget.questions.map((element) {
                    if (element.checkCorrect()) {
                      return Container(
                        decoration: const BoxDecoration(
                          border: Border(bottom: BorderSide()),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                              child: Text("Question " +
                                  (widget.questions.indexOf(element) + 1)
                                      .toString() +
                                  " :"),
                            ),
                            const Icon(Icons.check, color: Colors.green),
                          ],
                        ),
                      );
                    } else {
                      return Container(
                        decoration: const BoxDecoration(
                          border: Border(bottom: BorderSide()),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                              child: Text("Question " +
                                  (widget.questions.indexOf(element) + 1)
                                      .toString() +
                                  " :"),
                            ),
                            const Icon(
                              Icons.close,
                              color: Colors.red,
                            ),
                            Flexible(
                                child: Text("Correct answer : " +
                                    element.correctAnswer))
                          ],
                        ),
                      );
                    }
                  }).toList(),
                ),
              ),
            ),
          );
        });
  }

  void showError(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context, rootNavigator: true).pop();
            },
            child: AlertDialog(
              title: const Text("Please answer all questions"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Text("Question 1 : "),
                      widget.questions[0].selectedAnswer != -1
                          ? const Icon(Icons.check, color: Colors.blue)
                          : const Icon(
                              Icons.close,
                              color: Colors.yellow,
                            )
                    ],
                  ),
                  Row(
                    children: [
                      Text("Question 2 : "),
                      widget.questions[1].selectedAnswer != -1
                          ? const Icon(Icons.check, color: Colors.blue)
                          : const Icon(
                              Icons.close,
                              color: Colors.yellow,
                            )
                    ],
                  ),
                  Row(
                    children: [
                      Text("Question 3 : "),
                      widget.questions[2].selectedAnswer != -1
                          ? const Icon(Icons.check, color: Colors.blue)
                          : const Icon(
                              Icons.close,
                              color: Colors.yellow,
                            )
                    ],
                  ),
                  Row(
                    children: [
                      Text("Question 4 : "),
                      widget.questions[3].selectedAnswer != -1
                          ? const Icon(Icons.check, color: Colors.blue)
                          : const Icon(
                              Icons.close,
                              color: Colors.yellow,
                            )
                    ],
                  ),
                  Row(
                    children: [
                      Text("Question 5 : "),
                      widget.questions[4].selectedAnswer != -1
                          ? const Icon(Icons.check, color: Colors.blue)
                          : const Icon(
                              Icons.close,
                              color: Colors.yellow,
                            )
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    double navbar = MediaQuery.of(context).padding.bottom;
    double topbar = MediaQuery.of(context).padding.top + 50;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(0, 0, 0, 0),
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            OutlinedButton(
              onPressed: () {
                for (Question q in widget.questions) {
                  if (q.selectedAnswer == -1) {
                    Future.delayed(Duration.zero, () => showError(context));
                    return;
                  }
                }
                Future.delayed(Duration.zero, () => showCompleted(context));
                Navigator.pop(context);
              },
              child: const Text(
                "Submit",
                style: TextStyle(fontSize: 25, color: Colors.white),
              ),
              style: OutlinedButton.styleFrom(
                shape: const StadiumBorder(),
                side: const BorderSide(width: 2.0, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(bottom: navbar, top: topbar),
        width: _deviceWidth,
        height: _deviceHeight,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 139, 0, 255),
              Color.fromARGB(255, 0, 4, 255),
            ],
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedContainer(
                  margin: const EdgeInsets.all(10),
                  duration: const Duration(milliseconds: 500),
                  child: SizedBox(
                    width: 30,
                    height: 30,
                    child: Center(
                      child: widget.questions[0].selectedAnswer != -1
                          ? const Icon(
                              Icons.check,
                              color: Colors.green,
                            )
                          : const Text(
                              "1",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 25),
                            ),
                    ),
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    color: Color.fromARGB(
                        widget.questions[0].selectedAnswer != -1 ? 255 : 0,
                        255,
                        255,
                        255),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                ),
                AnimatedContainer(
                  margin: const EdgeInsets.all(10),
                  duration: const Duration(milliseconds: 500),
                  child: SizedBox(
                    width: 30,
                    height: 30,
                    child: Center(
                      child: widget.questions[1].selectedAnswer != -1
                          ? const Icon(
                              Icons.check,
                              color: Colors.green,
                            )
                          : const Text(
                              "2",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 25),
                            ),
                    ),
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    color: Color.fromARGB(
                        widget.questions[1].selectedAnswer != -1 ? 255 : 0,
                        255,
                        255,
                        255),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                ),
                AnimatedContainer(
                  margin: const EdgeInsets.all(10),
                  duration: const Duration(milliseconds: 500),
                  child: SizedBox(
                    width: 30,
                    height: 30,
                    child: Center(
                      child: widget.questions[2].selectedAnswer != -1
                          ? const Icon(
                              Icons.check,
                              color: Colors.green,
                            )
                          : const Text(
                              "3",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 25),
                            ),
                    ),
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    color: Color.fromARGB(
                        widget.questions[2].selectedAnswer != -1 ? 255 : 0,
                        255,
                        255,
                        255),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                ),
                AnimatedContainer(
                  margin: const EdgeInsets.all(10),
                  duration: const Duration(milliseconds: 500),
                  child: SizedBox(
                    width: 30,
                    height: 30,
                    child: Center(
                      child: widget.questions[3].selectedAnswer != -1
                          ? const Icon(
                              Icons.check,
                              color: Colors.green,
                            )
                          : const Text(
                              "4",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 25),
                            ),
                    ),
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    color: Color.fromARGB(
                        widget.questions[3].selectedAnswer != -1 ? 255 : 0,
                        255,
                        255,
                        255),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                ),
                AnimatedContainer(
                  margin: const EdgeInsets.all(10),
                  duration: const Duration(milliseconds: 500),
                  child: SizedBox(
                    width: 30,
                    height: 30,
                    child: Center(
                      child: widget.questions[4].selectedAnswer != -1
                          ? const Icon(
                              Icons.check,
                              color: Colors.green,
                            )
                          : const Text(
                              "5",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 25),
                            ),
                    ),
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    color: Color.fromARGB(
                        widget.questions[4].selectedAnswer != -1 ? 255 : 0,
                        255,
                        255,
                        255),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                ),
              ],
            ),
            FutureBuilder<List<Question>>(
              future: questions,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                } else if (snapshot.hasData) {
                  return Center(
                    child: CarouselSlider.builder(
                      options: CarouselOptions(
                        height: MediaQuery.of(context).size.height * 0.70,
                        enlargeCenterPage: true,
                        enableInfiniteScroll: false,
                        autoPlay: false,
                      ),
                      itemCount: 5,
                      itemBuilder: (BuildContext context, int itemIndex,
                          int pageViewIndex) {
                        return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.symmetric(horizontal: 2.0),
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30))),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, top: 10),
                                    child: Text(
                                      (itemIndex + 1).toString() + ".",
                                      style: const TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Text(
                                      widget.questions[itemIndex].text,
                                      style: const TextStyle(
                                          fontSize: 21,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                    // 0
                                    padding: const EdgeInsets.all(3.0),
                                    child: OutlinedButton(
                                      onPressed: () {
                                        setState(() {
                                          widget.questions[itemIndex]
                                              .selectedAnswer = 0;
                                        });
                                      },
                                      child: Text(
                                        "A. " +
                                            widget.questions[itemIndex]
                                                .answers[0],
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 21,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      style: OutlinedButton.styleFrom(
                                        backgroundColor: widget
                                                    .questions[itemIndex]
                                                    .selectedAnswer ==
                                                0
                                            ? Color.fromARGB(255, 235, 119, 255)
                                            : Colors.transparent,
                                        shape: const StadiumBorder(),
                                        side: const BorderSide(
                                            width: 1.5, color: Colors.black),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    // 1
                                    padding: const EdgeInsets.all(3.0),
                                    child: OutlinedButton(
                                      onPressed: () {
                                        setState(() {
                                          widget.questions[itemIndex]
                                              .selectedAnswer = 1;
                                        });
                                      },
                                      child: Text(
                                        "B. " +
                                            widget.questions[itemIndex]
                                                .answers[1],
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 21,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      style: OutlinedButton.styleFrom(
                                        backgroundColor: widget
                                                    .questions[itemIndex]
                                                    .selectedAnswer ==
                                                1
                                            ? Color.fromARGB(255, 235, 119, 255)
                                            : Colors.transparent,
                                        shape: const StadiumBorder(),
                                        side: const BorderSide(
                                            width: 1.5, color: Colors.black),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: OutlinedButton(
                                      onPressed: () {
                                        setState(() {
                                          widget.questions[itemIndex]
                                              .selectedAnswer = 2;
                                        });
                                      },
                                      child: Text(
                                        "C. " +
                                            widget.questions[itemIndex]
                                                .answers[2],
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 21,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      style: OutlinedButton.styleFrom(
                                        backgroundColor: widget
                                                    .questions[itemIndex]
                                                    .selectedAnswer ==
                                                2
                                            ? Color.fromARGB(255, 235, 119, 255)
                                            : Colors.transparent,
                                        shape: const StadiumBorder(),
                                        side: const BorderSide(
                                            width: 1.5, color: Colors.black),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: OutlinedButton(
                                      onPressed: () {
                                        setState(() {
                                          widget.questions[itemIndex]
                                              .selectedAnswer = 3;
                                        });
                                      },
                                      child: Text(
                                        "D. " +
                                            widget.questions[itemIndex]
                                                .answers[3],
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 21,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      style: OutlinedButton.styleFrom(
                                        backgroundColor: widget
                                                    .questions[itemIndex]
                                                    .selectedAnswer ==
                                                3
                                            ? Color.fromARGB(255, 235, 119, 255)
                                            : Colors.transparent,
                                        shape: const StadiumBorder(),
                                        side: const BorderSide(
                                            width: 1.5, color: Colors.black),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ));
                      },
                    ),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
