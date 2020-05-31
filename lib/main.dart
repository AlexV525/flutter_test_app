import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

import 'package:testapp/pages/splash_page.dart';
import 'package:testapp/testapp_route_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final Directory dir = await getApplicationDocumentsDirectory();

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
      navigatorObservers: [FFNavigatorObserver()],
      onGenerateRoute: onGenerateRouteHelper,
//      onGenerateRoute: <T>(RouteSettings settings) {
//          return DatePickerRoute() as Route<T>;
//      },
      home: SplashPage(),
    );
  }
}
class DatePickerRoute extends Route<DateTime> {
}