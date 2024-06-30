// [Author] Alex (https://github.com/AlexVincent525)
// [Date] 2019-11-26 09:18

import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  List<_RouteItem> get routes {
    return <_RouteItem>[
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
