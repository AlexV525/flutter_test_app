import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:testapp/pages/splash_page.dart';
import 'package:testapp/testapp_route_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test App Demo',
      theme: ThemeData(
        platform: TargetPlatform.iOS,
        primarySwatch: Colors.blue,
      ),
      navigatorObservers: [FFNavigatorObserver()],
      onGenerateRoute: onGenerateRouteHelper,
      home: SplashPage(),
    );
  }
}
