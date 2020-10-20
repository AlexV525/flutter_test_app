///
/// [Author] Alex (https://github.com/AlexVincent525)
/// [Date] 2019-11-26 09:18
///
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:testapp/pages/looks_like_sliver_appbar.dart';
import 'package:testapp/pages/test_ticker_page.dart';
import 'package:testapp/pages/test_text_field_page.dart';
import 'package:testapp/pages/will_pop_scope_page.dart';

import 'custom_page_indicator_page.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  List<_RouteItem> get routes {
    return const <_RouteItem>[
      _RouteItem(
        name: 'custom-page-indicator-page',
        page: CustomPageViewIndicatorPage(),
      ),
      _RouteItem(
        name: 'looks-like-sliver-appbar-page',
        page: LooksLikeSliverAppBarPage(),
      ),
      _RouteItem(
        name: 'test-ticker-page',
        page: TestTickerPage(),
      ),
      _RouteItem(
        name: 'textfield-as-fab-page',
        page: TestTextFieldPage(),
      ),
      _RouteItem(
        name: 'will-pop-scope-page',
        page: WillPopScopePage(),
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
          child: FlatButton(
            onPressed: () {
              Navigator.of(context)?.push<void>(
                MaterialPageRoute<dynamic>(builder: (_) => routes[index].page),
              );
            },
            child: Text(routes[index].name),
          ),
        ),
      ),
    );
  }
}

@immutable
class _RouteItem {
  const _RouteItem({
    required this.name,
    required this.page,
  });

  final String name;
  final Widget page;
}
