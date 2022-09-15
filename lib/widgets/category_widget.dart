import 'package:flutter/material.dart';
import '../classes/category.dart';
import 'image_widget.dart';

class CategoryWidget extends StatefulWidget {
  CategoryWidget({Key? key, required this.category, required this.text})
      : super(key: key);

  Category category;
  String text;

  bool selected = false;
  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  @override
  Widget build(BuildContext context) {
    const ColorFilter greyscale = ColorFilter.matrix(<double>[
      0.2126,
      0.7152,
      0.0722,
      0,
      0,
      0.2126,
      0.7152,
      0.0722,
      0,
      0,
      0.2126,
      0.7152,
      0.0722,
      0,
      0,
      0,
      0,
      0,
      1,
      0,
    ]);
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        setState(() {
          widget.selected = !widget.selected;
        });
      },
      child: widget.selected
          ? ImageWidget(
              category: widget.category,
              text: widget.text,
            )
          : ColorFiltered(
              colorFilter: greyscale,
              child: ImageWidget(
                category: widget.category,
                text: widget.text,
              ),
            ),
    );
  }
}
