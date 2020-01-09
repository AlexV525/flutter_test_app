///
/// [Author] Alex (https://github.com/AlexVincent525)
/// [Date] 2020-01-07 12:41
///
import 'package:flutter/material.dart';
import 'package:ff_annotation_route/ff_annotation_route.dart';

@FFRoute(
  name: "/text-field-in-floating-action-button-page",
  routeName: "TextField与FAB测试页",
)
class TextFieldInFloatingActionButtonPage extends StatefulWidget {
  @override
  _TextFieldInFloatingActionButtonPageState createState() =>
      _TextFieldInFloatingActionButtonPageState();
}

class _TextFieldInFloatingActionButtonPageState extends State<TextFieldInFloatingActionButtonPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        child: TextField(),
      ),
    );
  }
}
