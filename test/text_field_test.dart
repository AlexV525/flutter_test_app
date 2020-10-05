///
/// [Author] Alex (https://github.com/AlexVincent525)
/// [Date] 2019-11-27 10:25
///
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('test empty space when the buildCounter returns null',
      (WidgetTester tester) async {
    // Regression test for https://github.com/flutter/flutter/issues/44909

    final GlobalKey textField1State = GlobalKey();
    final GlobalKey textField2State = GlobalKey();

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Column(
            children: <Widget>[
              TextField(key: textField1State),
              TextField(
                key: textField2State,
                maxLength: 1,
                buildCounter: (
                  BuildContext context, {
                  int currentLength,
                  bool isFocused,
                  int maxLength,
                }) =>
                    null,
              ),
            ],
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();
    final Size textFieldSize1 = tester.getSize(find.byKey(textField1State));
    final Size textFieldSize2 = tester.getSize(find.byKey(textField2State));

    expect(textFieldSize1, equals(textFieldSize2));
  });
}
