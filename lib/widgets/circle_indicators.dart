import 'package:flutter/material.dart';
import 'package:quizzy/classes/question.dart';

class CircleIndicators extends StatefulWidget {
  CircleIndicators({Key? key, required this.questions}) : super(key: key);

  List<Question> questions;

  @override
  State<CircleIndicators> createState() => _CircleIndicatorsState();
}

class _CircleIndicatorsState extends State<CircleIndicators> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [0, 1, 2, 3, 4].map((e) => getContainer(e)).toList(),
    );
  }

  Widget getContainer(int i) {
    return AnimatedContainer(
      margin: const EdgeInsets.all(10),
      duration: const Duration(milliseconds: 500),
      child: SizedBox(
        width: 30,
        height: 30,
        child: Center(
          child: widget.questions[i].selectedAnswer != -1
              ? const Icon(
                  Icons.check,
                  color: Colors.green,
                )
              : Text(
                  (i + 1).toString(),
                  style: const TextStyle(color: Colors.white, fontSize: 25),
                ),
        ),
      ),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        color: Color.fromARGB(
            widget.questions[i].selectedAnswer != -1 ? 255 : 0, 255, 255, 255),
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
      ),
    );
  }
}
