///
/// [Author] Alex (https://github.com/AlexVincent525)
/// [Date] 2020-01-07 12:41
///
import 'package:flutter/material.dart';

class TextFieldInFloatingActionButtonPage extends StatefulWidget {
  const TextFieldInFloatingActionButtonPage({Key? key}) : super(key: key);

  @override
  _TextFieldInFloatingActionButtonPageState createState() =>
      _TextFieldInFloatingActionButtonPageState();
}

class _TextFieldInFloatingActionButtonPageState
    extends State<TextFieldInFloatingActionButtonPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        child: TextField(),
      ),
    );
  }
}
