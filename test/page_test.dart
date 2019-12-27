///
/// [Author] Alex (https://github.com/AlexVincent525)
/// [Date] 2019-11-27 10:25
///
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('test PageRoute canTransitionFrom', (WidgetTester tester) async {
    // Regression test for https://github.com/flutter/flutter/issues/44864

    final GlobalKey homeScaffoldKey = GlobalKey();

    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(platform: TargetPlatform.iOS),
        home: Scaffold(
          key: homeScaffoldKey,
          appBar: AppBar(title: const Text('Home')),
        ),
      ),
    );

    Navigator.push<void>(
      homeScaffoldKey.currentContext,
      CupertinoPageRoute<void>(
        builder: (BuildContext context) {
          return const Scaffold();
        },
      ),
    );

    await tester.pumpAndSettle();
    final Offset titlePosition = tester.getCenter(find.text('Home'));
    expect(titlePosition, lessThan(Offset.zero));
  });
}
