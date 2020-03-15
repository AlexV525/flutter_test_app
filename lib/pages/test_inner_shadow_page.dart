///
/// [Author] Alex (https://github.com/AlexVincent525)
/// [Date] 2020-03-13 21:00
///
import 'package:flutter/material.dart';

import 'package:testapp/constants/constants.dart';

@FFRoute(
  name: "/test-inner-shadow-page",
  routeName: "内部阴影测试页",
)
class TestInnerShadowPage extends StatelessWidget {
  Widget get activeBox => Padding(
        padding: EdgeInsets.all(20.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15.0),
          child: Container(
            width: 300.0,
            height: 80.0,
            decoration: BoxDecoration(
              boxShadow: [
                /// Inner shadow (Lighter)
                BoxShadow(
                  color: Color(0xffffffff),
                  offset: const Offset(5.0, 5.0),
                  spreadRadius: 5.0,
                  blurRadius: 10.0,
                ),

                /// Inner shadow (Darker)
                BoxShadow(
                  color: Color(0xff205cef),
                  offset: const Offset(-5.0, -5.0),
                  spreadRadius: 5.0,
                  blurRadius: 10.0,
                ),

                /// Background
                BoxShadow(
                  color: Color(0xff3a6ae0),
                  blurRadius: 10.0,
                  spreadRadius: -10.0,
                  offset: Offset.zero,
                ),
              ],
            ),
          ),
        ),
      );

  Widget get inActiveBox => Padding(
        padding: EdgeInsets.all(20.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15.0),
          child: Container(
            width: 300.0,
            height: 80.0,
            decoration: BoxDecoration(
              boxShadow: [
                /// Inner shadow (Lighter)
                BoxShadow(
                  color: Color(0xfff6f6f6),
                  offset: const Offset(5.0, 5.0),
                  spreadRadius: 5.0,
                  blurRadius: 10.0,
                ),

                /// Inner shadow (Darker)
                BoxShadow(
                  color: Color(0xffcccccc).withOpacity(0.85),
                  offset: const Offset(-15.0, -15.0),
                  spreadRadius: 5.0,
                  blurRadius: 10.0,
                ),

                /// Background
                BoxShadow(
                  color: Color(0xffeeeeee),
                  blurRadius: 10.0,
                  spreadRadius: -10.0,
                  offset: Offset.zero,
                ),
              ],
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(237, 241, 244, 1.0),
      appBar: AppBar(
        title: Text("Test inner shadow"),
      ),
      body: Column(
        children: <Widget>[activeBox, inActiveBox],
      ),
    );
  }
}
