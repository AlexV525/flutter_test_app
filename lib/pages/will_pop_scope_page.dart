///
/// [Author] Alex (https://github.com/AlexVincent525)
/// [Date] 2020-01-02 09:43
///
import 'package:flutter/material.dart';

import 'package:testapp/constants/constants.dart';

@FFRoute(
  name: "/will-pop-scope-page",
  routeName: "pop拦截测试页",
)
class WillPopScopePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        print("onWillPop");
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Test"),
        ),
        body: Column(
          children: <Widget>[
            FlatButton(
              child: Text("Test Pop"),
              onPressed: () {
                Navigator.of(context).pushNamed("/test-pop");
              },
            ),
          ],
        ),
      ),
    );
  }
}
