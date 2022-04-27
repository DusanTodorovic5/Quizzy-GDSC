import 'package:flutter/material.dart';
import '../classes/question.dart';

class AnswerButton extends StatefulWidget {
  AnswerButton(
      {Key? key,
      required this.question,
      required this.index,
      required this.onChanged})
      : super(key: key);

  Question question;
  int index;
  Function onChanged;

  @override
  State<AnswerButton> createState() => _AnswerButtonState();
}

class _AnswerButtonState extends State<AnswerButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: OutlinedButton(
        onPressed: () {
          widget.onChanged(widget.question, widget.index);
        },
        child: Text(
          String.fromCharCode(65 + widget.index) +
              ". " +
              widget.question.answers[widget.index],
          style: const TextStyle(
            color: Colors.black,
            fontSize: 21,
            fontWeight: FontWeight.bold,
          ),
        ),
        style: OutlinedButton.styleFrom(
          backgroundColor: widget.question.selectedAnswer == widget.index
              ? const Color.fromARGB(255, 235, 119, 255)
              : Colors.transparent,
          shape: const StadiumBorder(),
          side: const BorderSide(width: 1.5, color: Colors.black),
        ),
      ),
    );
  }
}
