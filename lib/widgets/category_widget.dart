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
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        setState(() {
          widget.selected = !widget.selected;
        });
      },
      child: widget.selected == true
          ? ImageWidget(
              category: widget.category,
              text: widget.text,
            )
          : ColorFiltered(
              colorFilter: const ColorFilter.mode(
                Colors.white,
                BlendMode.saturation,
              ),
              child: ImageWidget(
                category: widget.category,
                text: widget.text,
              ),
            ),
    );
  }
}
