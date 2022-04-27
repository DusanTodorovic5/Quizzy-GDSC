import 'package:flutter/material.dart';
import 'package:quizzy/classes/question.dart';

class CompletedDialog extends StatefulWidget {
  CompletedDialog({Key? key, required this.questions}) : super(key: key);

  List<Question> questions;

  @override
  State<CompletedDialog> createState() => _CompletedDialogState();
}

class _CompletedDialogState extends State<CompletedDialog> {
  @override
  Widget build(BuildContext context) {
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
                            (widget.questions.indexOf(element) + 1).toString() +
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
                        child: Text(
                          "Question " +
                              (widget.questions.indexOf(element) + 1)
                                  .toString() +
                              " :",
                          textAlign: TextAlign.left,
                        ),
                      ),
                      const Icon(
                        Icons.close,
                        color: Colors.red,
                      ),
                      Flexible(
                        child: Text(
                          "Correct: " + element.correctAnswer,
                          textAlign: TextAlign.right,
                        ),
                      )
                    ],
                  ),
                );
              }
            }).toList(),
          ),
        ),
      ),
    );
  }
}
