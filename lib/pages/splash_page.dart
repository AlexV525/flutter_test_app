///
/// [Author] Alex (https://github.com/AlexVincent525)
/// [Date] 2019-11-26 09:18
///
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:testapp/constants/constants.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Splash Page')),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        itemCount: routeNames.length,
        itemBuilder: (BuildContext _, int index) => Center(
          child: FlatButton(
            onPressed: () => Navigator.of(context).pushNamed(
              routeNames.elementAt(index),
            ),
            child: Text(routeNames.elementAt(index)),
          ),
        ),
      ),
    );
  }
}
