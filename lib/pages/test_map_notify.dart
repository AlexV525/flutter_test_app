///
/// [Author] Alex (https://github.com/AlexVincent525)
/// [Date] 2020-01-16 17:15
///
import 'package:flutter/material.dart';

import 'package:testapp/constants/constants.dart';

class TestProvider extends ChangeNotifier {
  Map<String, dynamic> person = {"name": "Alex", "age": 22};
  void changeName(String value) {
    person['name'] = value;
    print("change person name to: $value");
    notifyListeners();
  }
}

@FFRoute(
  name: "/test-map-notify-page",
  routeName: "Map notify测试页",
)
class TestMapNotifyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TestProvider(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Test map notify page"),
        ),
        body: Selector<TestProvider, Map>(
          selector: (_, provider) => provider.person,
          builder: (_, person, __) {
            print("selector build.");
            return Center(
              child: Text("${person['name']}"),
            );
          },
        ),
        floatingActionButton: Consumer<TestProvider>(
          builder: (_, provider, __) {
            print("consumer build.");
            return FloatingActionButton(
              onPressed: () {
                provider.changeName("AlexVincent");
              },
              child: Icon(Icons.edit),
            );
          },
        ),
      ),
    );
  }
}
