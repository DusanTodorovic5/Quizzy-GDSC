import 'package:flutter/material.dart';
import 'main_page.dart';
import 'package:flutter_web_frame/flutter_web_frame.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlutterWebFrame(
      builder: (context) {
        return MaterialApp(
          title: 'GDSC Demo Quiz',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: Menu(),
        );
      },
      maximumSize: const Size(475.0, 812.0),
      backgroundColor: Colors.white,
    );
  }
}
