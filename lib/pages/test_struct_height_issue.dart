///
/// [Author] Alex (https://github.com/AlexV525)
/// [Date] 2020/8/14 10:34
///
import 'package:flutter/material.dart';
import 'package:testapp/constants/constants.dart';

@FFRoute(
  name: "/test-struct-height-issue-page",
  routeName: 'StructStyle issue test',
)
class TestStructHeightIssuePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double fontSize = 50.0;
    return Scaffold(
      appBar: AppBar(
        title: Text(ModalRoute.of(context).settings.name),
      ),
      body: Center(
        child: Text(
          '我带你们打我带你们打我带你们打我带你们打',
          style: TextStyle(
            fontSize: fontSize,
            height: 1.0,
          ),
          overflow: TextOverflow.ellipsis,
          strutStyle: StrutStyle(
            height: fontSize / 12.5,
            forceStrutHeight: true,
          ),
        ),
      ),
    );
  }
}
