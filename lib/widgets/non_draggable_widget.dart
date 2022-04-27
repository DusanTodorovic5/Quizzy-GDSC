import 'package:flutter/material.dart';

class NonDraggableWidget extends StatelessWidget {
  const NonDraggableWidget(
      {Key? key, required this.text, required this.correct})
      : super(key: key);

  final String text;
  final bool correct;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Container(
          alignment: Alignment.center,
          height: MediaQuery.of(context).size.height / 12,
          width: MediaQuery.of(context).size.width * 0.4,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(8),
            ),
            color: correct ? Colors.green : Colors.red,
          ),
          padding: const EdgeInsets.all(10),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
