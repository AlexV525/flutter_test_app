import 'package:TestApp/pages/splash_page.dart';
import 'package:flutter/material.dart';

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
        primarySwatch: Colors.blue,
      ),
//      routes: {"/splash": (_) => SplashPage()},
      home: SplashPage(),
    );
  }
}
