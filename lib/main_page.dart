import 'package:flutter/material.dart';
import 'package:quizzy/classes/category_type.dart';
import 'package:quizzy/connect_page.dart';
import 'package:quizzy/question_page.dart';
import 'package:quizzy/widgets/category.dart';

class Menu extends StatefulWidget {
  Menu({Key? key}) : super(key: key);

  List<Category> categories = [
    Category(
      myCategory: CategoryType.math,
      text: "Math",
    ),
    Category(
      myCategory: CategoryType.geography,
      text: "Geography",
    ),
    Category(
      myCategory: CategoryType.history,
      text: "History",
    ),
    Category(
      myCategory: CategoryType.movies,
      text: "Movies",
    ),
    Category(
      myCategory: CategoryType.programming,
      text: "Programming",
    ),
    Category(
      myCategory: CategoryType.cars,
      text: "Cars",
    ),
  ];

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  double _deviceHeight = 0;
  double _deviceWidth = 0;

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
          leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {},
          )),
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
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text(
                  "Quizzy!",
                  style: TextStyle(
                    fontSize: 80,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text(
                  "Test your knowledge",
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Press on category to disable it!",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  GridView.count(
                    padding: EdgeInsets.zero,
                    crossAxisCount: 3,
                    shrinkWrap: true,
                    children: widget.categories,
                  ),
                  Container(
                    padding: const EdgeInsets.only(bottom: 3),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: 150,
                          decoration: const ShapeDecoration(
                            shape: StadiumBorder(),
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color.fromARGB(255, 139, 0, 255),
                                Color.fromARGB(255, 0, 4, 255),
                              ],
                            ),
                          ),
                          child: MaterialButton(
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            shape: const StadiumBorder(),
                            child: const Text(
                              "Play Quiz",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            onPressed: () {
                              bool hasCategory = false;
                              for (var v in widget.categories) {
                                hasCategory = v.selected;
                                if (hasCategory) break;
                              }
                              if (!hasCategory) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content:
                                      Text("Please select at least 1 category"),
                                ));
                                return;
                              }
                              Map<CategoryType, bool> map = {
                                for (var v in widget.categories)
                                  v.myCategory: v.selected
                              };
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => QuestionPage(
                                    categories: map,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        Container(
                          width: 150,
                          decoration: const ShapeDecoration(
                            shape: StadiumBorder(),
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color.fromARGB(255, 139, 0, 255),
                                Color.fromARGB(255, 0, 4, 255),
                              ],
                            ),
                          ),
                          child: MaterialButton(
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            shape: const StadiumBorder(),
                            child: const Text(
                              "Play Connect",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            onPressed: () {
                              bool hasCategory = false;
                              for (var v in widget.categories) {
                                hasCategory = v.selected;
                                if (hasCategory) break;
                              }
                              if (!hasCategory) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content:
                                      Text("Please select at least 1 category"),
                                ));
                                return;
                              }
                              Map<CategoryType, bool> map = {
                                for (var v in widget.categories)
                                  v.myCategory: v.selected
                              };
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ConnectPage(
                                    categories: map,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
