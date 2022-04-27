import 'package:flutter/material.dart';
import 'package:quizzy/classes/category.dart';

class CategoryWidget extends StatefulWidget {
  CategoryWidget({Key? key, required this.myCategory, required this.text})
      : super(key: key);

  Category myCategory;
  String text;

  bool selected = false;
  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        setState(() {
          widget.selected = !widget.selected;
        });
      },
      child: widget.selected == true
          ? Container(
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
                      child: widget.selected == true
                          ? Image.asset(
                              "assets/categories/" +
                                  widget.myCategory.name +
                                  ".png",
                              fit: BoxFit.fitWidth,
                              alignment: Alignment.topCenter,
                            )
                          : Image.asset(
                              "assets/categories/" +
                                  widget.myCategory.name +
                                  ".png",
                              fit: BoxFit.fitWidth,
                              alignment: Alignment.topCenter,
                            )),
                  FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text(
                      widget.text,
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                ],
              ),
            )
          : ColorFiltered(
              colorFilter: const ColorFilter.mode(
                Colors.white,
                BlendMode.saturation,
              ),
              child: Container(
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
                        child: widget.selected == true
                            ? Image.asset(
                                "assets/categories/" +
                                    widget.myCategory.name +
                                    ".png",
                                fit: BoxFit.fitWidth,
                                alignment: Alignment.topCenter,
                              )
                            : Image.asset(
                                "assets/categories/" +
                                    widget.myCategory.name +
                                    ".png",
                                fit: BoxFit.fitWidth,
                                alignment: Alignment.topCenter,
                              )),
                    FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text(
                        widget.text,
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
