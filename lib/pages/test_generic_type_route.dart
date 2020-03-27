///
/// [Author] Alex (https://github.com/AlexVincent525)
/// [Date] 2020/3/26 18:29
///
import 'package:flutter/material.dart';

import 'package:testapp/constants/constants.dart';

@FFRoute(name: '/test-generic-type-route-page', routeName: '测试泛型路由页')
class TestGenericTypeRoutePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test generic type route page'),
      ),
      body: Center(
        child: RaisedButton(
          child: Text('push'),
          onPressed: () async {
            final bool result = await Navigator.pushNamed<bool>(
              context,
              Routes.TEST_GENERIC_TYPE_ROUTE_PAGE_2,
            );
            print(result);
          },
        ),
      ),
    );
  }
}

@FFRoute(name: '/test-generic-type-route-page-2', routeName: '测试泛型路由页2')
class TestGenericTypeRoutePage2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            Navigator.maybePop(context, true);
          },
        ),
        title: Text('Test generic type route page'),
      ),
      body: Center(
        child: Text('2'),
      ),
    );
  }
}
