///
/// [Author] Alex (https://github.com/AlexVincent525)
/// [Date] 2020-01-02 09:43
///
import 'package:flutter/material.dart';

import 'package:testapp/constants/constants.dart';

class WillPopScopePage extends StatelessWidget {
  const WillPopScopePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        print('onWillPop');
        return true;
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Test')),
        body: Column(
          children: <Widget>[
            FlatButton(
              child: const Text('Test Pop'),
              onPressed: Navigator.of(context)?.pop,
            ),
          ],
        ),
      ),
    );
  }
}
