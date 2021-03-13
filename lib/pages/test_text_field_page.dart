///
/// [Author] Alex (https://github.com/AlexVincent525)
/// [Date] 2020-01-07 12:41
///
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class TestTextFieldPage extends StatefulWidget {
  const TestTextFieldPage({Key? key}) : super(key: key);

  @override
  _TestTextFieldPageState createState() => _TestTextFieldPageState();
}

class _TestTextFieldPageState extends State<TestTextFieldPage> {
  final TextEditingController tec = TextEditingController(text: '123456');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          TextField(
            inputFormatters: <TextInputFormatter>[
              RegExpFormatter(RegExp(r'^[*#1]([*#0-9]{0,10})$')),
              // RegExpFormatter(RegExp(r'^[*#0-9]$')),
            ],
          ),
        ],
      ),
    );
  }
}

class RegExpFormatter extends TextInputFormatter {
  RegExpFormatter(this.regExp) : assert(regExp != null);

  final RegExp regExp;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty ||
        !newValue.composing.isCollapsed ||
        !newValue.selection.isCollapsed) {
      return newValue;
    }
    final Iterable<RegExpMatch> matches = regExp.allMatches(newValue.text);
    if (matches.length == 1 &&
        matches.first.group(0).toString() == newValue.text) {
      return newValue;
    }
    return oldValue;
  }
}
