///
/// [Author] Alex (https://github.com/AlexVincent525)
/// [Date] 2020/07/04 02:39
///
import 'package:flutter/material.dart';

import 'package:testapp/constants/constants.dart';

class TestListProvider extends ChangeNotifier {
  List<String> list = <String>['a', 'b', 'c'];

  int get length => list.length;

  void addItem() {
    print('Changing list...');
    print('Previous list: $list');
    list.add(String.fromCharCode(list.last.codeUnitAt(0) + 1));
    print('Current  list: $list');
    print('List\'s hashCode: ${list.hashCode}');
    notifyListeners();
  }
}

@FFRoute(
  name: "/test-selector-page",
  routeName: 'Selector测试页',
)
class TestSelectorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TestListProvider(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Test map notify page"),
        ),
        body: Selector<TestListProvider, int>(
          selector: (_, provider) => provider.length,
          shouldRebuild: (int pre, int next) {
            print('Pre  hashCode: ${pre.hashCode}');
            print('Next hashCode: ${next.hashCode}');
            return pre != next;
          },
          builder: (BuildContext insideContext, int length, __) {
            print("selector build.");
            final List<String> list = Provider.of<TestListProvider>(
              insideContext,
              listen: false,
            ).list;
            print('Read list hashCode: ${list.hashCode}');
            return ListView.builder(
              itemCount: list.length,
              itemBuilder: (BuildContext _, int index) {
                return Text(list[index]);
              },
            );
          },
        ),
        floatingActionButton: Consumer<TestListProvider>(
          builder: (_, provider, __) {
            print("consumer build.");
            return FloatingActionButton(
              onPressed: provider.addItem,
              child: Icon(Icons.edit),
            );
          },
        ),
      ),
    );
  }
}
