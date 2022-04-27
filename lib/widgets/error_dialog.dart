import 'package:flutter/material.dart';
import 'package:quizzy/classes/question.dart';

class ErrorDialog extends StatefulWidget {
  ErrorDialog({Key? key, required this.questions}) : super(key: key);

  List<Question> questions;

  @override
  State<ErrorDialog> createState() => _ErrorDialogState();
}

class _ErrorDialogState extends State<ErrorDialog> {
  @override
  Widget build(BuildContext context) {
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
  }
}
