///
/// [Author] Alex (https://github.com/AlexVincent525)
/// [Date] 2020-01-07 12:41
///
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class TestTextFieldPage extends StatefulWidget {
  const TestTextFieldPage({Key? key}) : super(key: key);

  @override
  _TestTextFieldPageState createState() => _TestTextFieldPageState();
}

class _TestTextFieldPageState extends State<TestTextFieldPage> {
  final int maxLength = 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          TextField(maxLength: maxLength),
          CupertinoTextField(maxLength: maxLength, maxLengthEnforced: true),
        ],
      ),
    );
  }
}
