///
/// [Author] Alex (https://github.com/AlexVincent525)
/// [Date] 2019-11-26 09:18
///
import 'package:flutter/material.dart';

import 'custom_page_indicator_page.dart';
import 'test_animated_scalable_grid_view_page.dart';
import 'test_icon_grid_page.dart';
import 'test_scalable_grid_view_page.dart';
import 'test_text_field_page.dart';
import 'test_ticker_page.dart';
import 'test_transparent_route_page.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  List<_RouteItem> get routes {
    return <_RouteItem>[
      const _RouteItem(page: CustomPageViewIndicatorPage()),
      const _RouteItem(page: TestAnimatedScalableGridViewPage()),
      const _RouteItem(page: TestScalableGridViewPage()),
      const _RouteItem(page: TestIconGridPage()),
      const _RouteItem(page: TestTextFieldPage()),
      const _RouteItem(page: TestTickerPage()),
      _RouteItem(
        name: '$TestTransparentRoute',
        routeBuilder: () => TestTransparentRoute<void>(
          builder: (_) => const TestTransparentRoutePage(),
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Splash Page')),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        itemCount: routes.length,
        itemBuilder: (BuildContext _, int index) => Center(
          child: TextButton(
            onPressed: () => Navigator.of(context).push<void>(
              routes[index].routeBuilder?.call() ??
                  MaterialPageRoute<dynamic>(
                    builder: (_) => routes[index].page!,
                  ),
            ),
            child: Text(
              routes[index].name ?? routes[index].page.runtimeType.toString(),
            ),
          ),
        ),
      ),
    );
  }
}

@immutable
class _RouteItem {
  const _RouteItem({
    this.name,
    this.page,
    this.routeBuilder,
  })  : assert(name != null || page != null),
        assert(page != null || routeBuilder != null);

  final String? name;
  final Widget? page;
  final Route<dynamic> Function()? routeBuilder;
}
