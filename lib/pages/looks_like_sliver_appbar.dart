///
/// [Author] Alex (https://github.com/AlexVincent525)
/// [Date] 2020-01-03 21:59
///
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:ff_annotation_route/ff_annotation_route.dart';

@FFRoute(
  name: "/looks-like-sliver-appbar-page",
  routeName: "SliverAppBar测试页",
)
class LooksLikeSliverAppBarPage extends StatefulWidget {
  @override
  _LooksLikeSliverAppBarPageState createState() => _LooksLikeSliverAppBarPageState();
}

class _LooksLikeSliverAppBarPageState extends State<LooksLikeSliverAppBarPage> {
  final _scrollController = ScrollController();

  double expandPhysics = 100;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NotificationListener(
        onNotification: (ScrollUpdateNotification notification) {
          final _ = 84 - math.min(50.0, notification.metrics.pixels);
          print(_);
          if (_ != expandPhysics)
            setState(() {
              expandPhysics = _;
            });
          return true;
        },
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              width: MediaQuery.of(context).size.width,
              color: Colors.cyan,
              child: SizedBox(
                height: expandPhysics,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Primary title"),
                    Text("secondary title"),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                controller: _scrollController,
                children: List<Widget>.generate(
                  20,
                  (i) => Container(
                    margin: EdgeInsets.all(20.0),
                    width: 50.0,
                    height: 50.0,
                    color: Colors.redAccent,
                    child: Center(child: Text("$i")),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
