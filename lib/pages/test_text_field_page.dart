///
/// [Author] Alex (https://github.com/AlexVincent525)
/// [Date] 2020-01-07 12:41
///
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

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
          TextField(
            maxLength: maxLength,
            inputFormatters: <TextInputFormatter>[
              TextInputFormatter.withFunction(
                (TextEditingValue oldValue, TextEditingValue newValue) {
                  return newValue.copyWith(
                    composing: !newValue.composing.isCollapsed &&
                            maxLength > newValue.composing.start
                        ? TextRange(
                            start: newValue.composing.start,
                            end: math.min(newValue.composing.end, maxLength),
                          )
                        : TextRange.empty,
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
