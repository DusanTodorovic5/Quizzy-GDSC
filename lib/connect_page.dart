import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'classes/category.dart';
import 'classes/connector.dart';
import 'widgets/draggable_widget.dart';
import 'widgets/non_draggable_widget.dart';

class ConnectPage extends StatefulWidget {
  ConnectPage({Key? key, required this.categories}) : super(key: key);

  Map<Category, bool> categories;

  @override
  State<ConnectPage> createState() => _ConnectPageState();
}

class _ConnectPageState extends State<ConnectPage> {
  double _deviceHeight = 0;
  double _deviceWidth = 0;

  late final Future<Connector> futureConnector;
  late Connector connector;

  @override
  void initState() {
    futureConnector = loadConnects();
    super.initState();
  }

  Future<Connector> loadConnects() async {
    final _json = await rootBundle.loadString('assets/draggable.json');

    var parsed = json.decode(_json);

    var list = parsed as List;

    List<Connector> allConnectors = [];

    for (var connector in list) {
      var c = Connector.fromJson(connector);
      if (widget.categories[c.category] == true) {
        allConnectors.add(c);
      }
    }

    allConnectors.shuffle();
    connector = allConnectors.take(1).toList()[0];
    return connector;
  }

  void showAnswers(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context, rootNavigator: true).pop();
            },
            child: AlertDialog(
              title: const Text("Correct Answers"),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: connector.fields.keys.map((element) {
                    return Container(
                      decoration: const BoxDecoration(
                        border: Border(bottom: BorderSide()),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Text(
                              element,
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Flexible(
                            child: Text(
                              connector.fields[element]!,
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          );
        });
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
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            OutlinedButton(
              onPressed: () {
                Future.delayed(Duration.zero, () => showAnswers(context));
              },
              child: const Text(
                "Check answers",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              style: OutlinedButton.styleFrom(
                shape: const StadiumBorder(),
                side: const BorderSide(width: 2.0, color: Colors.white),
              ),
            ),
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
        child: FutureBuilder<Connector>(
          future: futureConnector,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else if (snapshot.hasData) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Text(
                        snapshot.data!.text,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 2),
                    const Text(
                      "Drag left fields to the right",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: connector.fields.keys.map((element) {
                            if (snapshot.data!
                                    .answered[snapshot.data!.fields[element]] !=
                                0) {
                              return NonDraggableWidget(
                                  text: element,
                                  correct: snapshot.data!.answered[
                                          snapshot.data!.fields[element]] ==
                                      1);
                            }
                            return Draggable<String>(
                              data: element,
                              child: DraggableWidget(
                                color: snapshot.data!.answered[
                                            snapshot.data!.fields[element]] ==
                                        1
                                    ? Colors.green
                                    : Colors.white,
                                text: element,
                              ),
                              feedback: DraggableWidget(
                                color: Colors.grey,
                                text: element,
                              ),
                              childWhenDragging: const DraggableWidget(
                                color: Colors.transparent,
                                text: "?",
                              ),
                            );
                          }).toList(),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: connector.anchors
                              .map((element) => _buildDragTarget(element))
                              .toList(),
                        )
                      ],
                    )
                  ],
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildDragTarget(element) {
    return DragTarget<String>(
      builder: (BuildContext context, List<String?> incoming, List rejected) {
        if (connector.answered[element] == 1) {
          return Padding(
            padding: const EdgeInsets.all(3.0),
            child: Container(
              color: Colors.green,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  element,
                  style: const TextStyle(color: Colors.black, fontSize: 20),
                ),
              ),
              height: MediaQuery.of(context).size.height / 12,
              width: MediaQuery.of(context).size.width * 0.4,
            ),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.all(3.0),
            child: Container(
              color: Colors.white,
              height: MediaQuery.of(context).size.height / 12,
              width: MediaQuery.of(context).size.width * 0.4,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  element,
                  style: const TextStyle(color: Colors.black, fontSize: 20),
                ),
              ),
            ),
          );
        }
      },
      onWillAccept: (data) {
        return connector.answered[element] != 1;
      },
      onAccept: (data) {
        setState(() {
          connector.answered.update(connector.fields[data]!,
              (value) => connector.fields[data] == element ? 1 : -1);
        });
      },
      onLeave: (data) {},
    );
  }
}
