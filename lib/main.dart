import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import 'package:testapp/pages/splash_page.dart';
import 'package:testapp/testapp_route_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
    statusBarColor: Colors.transparent,
  ));
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
      navigatorObservers: <NavigatorObserver>[FFNavigatorObserver()],
      onGenerateRoute: onGenerateRouteHelper,
      home: SplashPage(),
    );
  }
}