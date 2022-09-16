import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'widgets/answer_button.dart';
import 'widgets/circle_indicators.dart';
import 'widgets/completed_dialog.dart';
import 'widgets/error_dialog.dart';
import 'classes/category.dart';
import 'classes/question.dart';

class QuestionPage extends StatefulWidget {
  QuestionPage({Key? key, required this.categories}) : super(key: key) {
    print("Hello");
  }

  List<Question> questions = [
    Question(text: "", answers: [""], category: Category.math),
    Question(text: "", answers: [""], category: Category.math),
    Question(text: "", answers: [""], category: Category.math),
    Question(text: "", answers: [""], category: Category.math),
    Question(text: "", answers: [""], category: Category.math),
  ];
  Map<Category, bool> categories;
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
          return CompletedDialog(questions: widget.questions);
        });
  }

  void showError(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return ErrorDialog(questions: widget.questions);
        });
  }

  void answerSelected(Question question, int answerIndex) {
    setState(() {
      question.selectedAnswer = answerIndex;
    });
  }

  CarouselController buttonCarouselController = CarouselController();

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
            CircleIndicators(questions: widget.questions),
            FutureBuilder<List<Question>>(
              future: questions,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                } else if (snapshot.hasData) {
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CarouselSlider.builder(
                          carouselController: buttonCarouselController,
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
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 2.0),
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
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(12),
                                      child: Text(
                                        widget.questions[itemIndex].text,
                                        style: const TextStyle(
                                          fontSize: 21,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    AnswerButton(
                                      question: widget.questions[itemIndex],
                                      index: 0,
                                      onChanged: answerSelected,
                                    ),
                                    AnswerButton(
                                      question: widget.questions[itemIndex],
                                      index: 1,
                                      onChanged: answerSelected,
                                    ),
                                    AnswerButton(
                                      question: widget.questions[itemIndex],
                                      index: 2,
                                      onChanged: answerSelected,
                                    ),
                                    AnswerButton(
                                      question: widget.questions[itemIndex],
                                      index: 3,
                                      onChanged: answerSelected,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            OutlinedButton(
                              onPressed: () =>
                                  buttonCarouselController.previousPage(
                                      duration:
                                          const Duration(milliseconds: 300),
                                      curve: Curves.linear),
                              child: const Icon(
                                Icons.arrow_left,
                                color: Colors.white,
                                size: 50,
                              ),
                              style: OutlinedButton.styleFrom(
                                shape: const StadiumBorder(),
                                side: const BorderSide(
                                    width: 2.0, color: Colors.white),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            OutlinedButton(
                              onPressed: () =>
                                  buttonCarouselController.nextPage(
                                      duration:
                                          const Duration(milliseconds: 300),
                                      curve: Curves.linear),
                              child: const Icon(
                                Icons.arrow_right,
                                color: Colors.white,
                                size: 50,
                              ),
                              style: OutlinedButton.styleFrom(
                                shape: const StadiumBorder(),
                                side: const BorderSide(
                                    width: 2.0, color: Colors.white),
                              ),
                            )
                          ],
                        )
                      ],
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
