///
/// [Author] Alex (https://github.com/AlexV525)
/// [Date] 2020/10/8 15:55
///
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class TestTickerPage extends StatefulWidget {
  const TestTickerPage({Key? key}) : super(key: key);

  @override
  _TestTickerPageState createState() => _TestTickerPageState();
}

class _TestTickerPageState extends State<TestTickerPage> {
  final Ticker ticker = Ticker((Duration elapsed) {
    print('Ticker elapsed: $elapsed');
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          TextButton(
            onPressed: ticker.start,
            child: const Text('Ticker start'),
          ),
          TextButton(
            onPressed: ticker.stop,
            child: const Text('Ticker stop'),
          ),
        ],
      ),
    );
  }
}
