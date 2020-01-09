import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import 'package:testapp/pages/splash_page.dart';
import 'package:testapp/testapp_route.dart';
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
      navigatorObservers: [
        FFNavigatorObserver(showStatusBarChange: (bool showStatusBar) {
          SystemChrome.setEnabledSystemUIOverlays(
            showStatusBar ? SystemUiOverlay.values : [],
          );
        })
      ],
      onGenerateRoute: (RouteSettings settings) {
        final routeResult = getRouteResult(
          name: settings.name,
          arguments: settings.arguments,
        );
        if (routeResult.showStatusBar != null || routeResult.routeName != null) {
          settings = FFRouteSettings(
            name: settings.name,
            isInitialRoute: settings.isInitialRoute,
            routeName: routeResult.routeName,
            arguments: settings.arguments,
            showStatusBar: routeResult.showStatusBar,
          );
        }
        final page = routeResult.widget ?? SplashPage();

        if (settings.arguments != null && settings.arguments is Map<String, dynamic>) {
          final builder = (settings.arguments as Map<String, dynamic>)['routeBuilder'];
          if (builder != null) return builder(page);
        }

        switch (routeResult.pageRouteType) {
          case PageRouteType.material:
            return MaterialPageRoute(
              settings: settings,
              builder: (c) => page,
            );
          case PageRouteType.cupertino:
            return CupertinoPageRoute(
              settings: settings,
              builder: (c) => page,
            );
          case PageRouteType.transparent:
            return FFTransparentPageRoute(
              settings: settings,
              pageBuilder: (_, __, ___) => page,
            );
          default:
            return Platform.isIOS
                ? CupertinoPageRoute(settings: settings, builder: (c) => page)
                : MaterialPageRoute(settings: settings, builder: (c) => page);
        }
      },
      home: SplashPage(),
    );
  }
}
