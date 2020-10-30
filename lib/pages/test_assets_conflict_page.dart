///
/// [Author] Alex (https://github.com/AlexV525)
/// [Date] 2020/10/30 17:37
///
import 'package:flutter/material.dart';

class TestAssetsConflictPage extends StatelessWidget {
  const TestAssetsConflictPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> assets = <String>[
      'assets/placeholder.png',
      'assets/something/placeholder.png',
    ];
    return Scaffold(
      appBar: AppBar(),
      body: SizedBox.expand(
        child: Column(
          children: List<Widget>.generate(assets.length, (int index) {
            return Expanded(
              child: SizedBox.expand(
                child: Image.asset(assets[index], fit: BoxFit.cover),
              ),
            );
          }),
        ),
      ),
    );
  }
}
