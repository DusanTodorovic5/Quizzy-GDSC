import 'package:flutter/material.dart';
import 'widgets/link_tile.dart';
import 'classes/category.dart';
import 'connect_page.dart';
import 'question_page.dart';
import 'widgets/category_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class Menu extends StatefulWidget {
  Menu({Key? key}) : super(key: key);

  List<CategoryWidget> categories = [
    CategoryWidget(
      category: Category.math,
      text: "Math",
    ),
    CategoryWidget(
      category: Category.geography,
      text: "Geography",
    ),
    CategoryWidget(
      category: Category.history,
      text: "History",
    ),
    CategoryWidget(
      category: Category.movies,
      text: "Movies",
    ),
    CategoryWidget(
      category: Category.programming,
      text: "Programming",
    ),
    CategoryWidget(
      category: Category.gdsc,
      text: "GDSC",
    ),
  ];

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  double _deviceHeight = 0;
  double _deviceWidth = 0;

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

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
      ),
      drawer: Drawer(
        child: ListView(
          children: const [
            LinkTile(
                text: "Check out source code!",
                link: "https://github.com/DusanTodorovic5/Quizzy-GDSC",
                icon: Icons.source),
            LinkTile(
                text: "Check flutter documentation",
                link: "https://docs.flutter.dev/",
                icon: Icons.flutter_dash),
            LinkTile(
                text: "Review privacy policy",
                link:
                    "https://dukestudioswp.wordpress.com/privacy-policy-for-quizzy-application/",
                icon: Icons.privacy_tip),
          ],
        ),
      ),
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
                      "Select quiz topics you wish!",
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
                              Map<Category, bool> map = {
                                for (var v in widget.categories)
                                  v.category: v.selected
                              };
                              openPage(
                                QuestionPage(
                                  categories: map,
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
                              Map<Category, bool> map = {
                                for (var v in widget.categories)
                                  v.category: v.selected
                              };
                              openPage(
                                ConnectPage(
                                  categories: map,
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

  void openPage(Widget nextPage) {
    bool hasCategory = false;
    for (var v in widget.categories) {
      hasCategory = v.selected;
      if (hasCategory) break;
    }
    if (!hasCategory) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please select at least 1 category"),
        ),
      );
      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => nextPage,
      ),
    );
  }
}
