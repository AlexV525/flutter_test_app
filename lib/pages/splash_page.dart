///
/// [Author] Alex (https://github.com/AlexVincent525)
/// [Date] 2019-11-26 09:18
///
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:extended_text/extended_text.dart';
import 'package:dartx/dartx.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 1, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Splash Page",
          style: Theme.of(context).textTheme.title,
        ),
      ),
      body: ListView(
        children: <Widget>[
          TabBar(
            controller: tabController,
            tabs: <Widget>[
              SizedBox(height: 64.0),
            ],
          ),
          Tooltip(
            waitDuration: 1.milliseconds,
            message: "Test tooltip",
            child: Text("Test tooltip"),
          ),
        ],
      ),
    );
  }
}
