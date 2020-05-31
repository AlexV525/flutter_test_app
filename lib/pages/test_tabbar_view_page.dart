///
/// [Author] Alex (https://github.com/AlexVincent525)
/// [Date] 2020-02-05 20:33
///
import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'package:testapp/constants/constants.dart';

@FFRoute(name: "/test-stack-tabbarview-page", routeName: "测试TabBarView")
class TestTabBarViewPage extends StatefulWidget {
  @override
  _TestTabBarViewPageState createState() => _TestTabBarViewPageState();
}

class _TestTabBarViewPageState extends State<TestTabBarViewPage>
    with TickerProviderStateMixin {
  StreamController indexController = StreamController<double>.broadcast();
  TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    indexController?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NotificationListener(
        onNotification: (ScrollNotification notification) {
          indexController.add(notification.metrics.pixels /
              notification.metrics.viewportDimension);
          return true;
        },
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: TabBarView(
                controller: tabController,
                children: <Widget>[
                  Container(
                    color: Colors.redAccent,
                    child: SizedBox.expand(),
                  ),
                  Container(
                    color: Colors.yellow,
                    child: SizedBox.expand(),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 0.0,
              left: 0.0,
              right: 0.0,
              child: StreamBuilder(
                initialData: 0.0,
                stream: indexController.stream,
                builder: (_, data) => Container(
                  color: Colors.blue
                      .withOpacity(math.min(1.0, data.data as double) * 1.0),
                  child: TabBar(
                    controller: tabController,
                    indicatorColor: Colors.transparent,
                    tabs: <Widget>[
                      Tab(text: '111'),
                      Tab(text: '222'),
                    ],
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
