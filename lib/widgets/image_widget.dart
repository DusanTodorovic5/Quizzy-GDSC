import 'package:flutter/material.dart';
import '../classes/category.dart';

class ImageWidget extends StatefulWidget {
  ImageWidget({Key? key, required this.category, required this.text})
      : super(key: key);

  Category category;
  String text;

  @override
  State<ImageWidget> createState() => _ImageWidgetState();
}

class _ImageWidgetState extends State<ImageWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(6),
      padding: const EdgeInsets.all(3),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
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
        children: [
          Flexible(
            child: Image.asset(
              "assets/categories/" + widget.category.name + ".png",
              fit: BoxFit.fitWidth,
              alignment: Alignment.topCenter,
            ),
          ),
          FittedBox(
            fit: BoxFit.fitWidth,
            child: Text(
              widget.text,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
