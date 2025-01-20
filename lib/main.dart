import 'package:flutter/material.dart';
import 'package:my_quiz/page/on_board.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false, home: OnBoardScreen());
  }
}
