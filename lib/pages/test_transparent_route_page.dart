///
/// [Author] Alex (https://github.com/AlexV525)
/// [Date] 2022/2/9 12:44
///
import 'package:flutter/material.dart';

class TestTransparentRoute<T> extends PageRoute<T> {
  TestTransparentRoute({required this.builder});

  /// Builds the primary contents of the route.
  final WidgetBuilder builder;

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 300);

  @override
  Color? get barrierColor => null;

  @override
  String? get barrierLabel => null;

  @override
  bool get opaque => false;

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    final PageTransitionsTheme theme = Theme.of(context).pageTransitionsTheme;
    return theme.buildTransitions<T>(this, context, animation, secondaryAnimation, child);
  }

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return Semantics(
      scopesRoute: true,
      explicitChildNodes: true,
      child: builder(context),
    );
  }
}

class TestTransparentRoutePage extends StatefulWidget {
  const TestTransparentRoutePage({Key? key}) : super(key: key);

  @override
  _TestTransparentRoutePageState createState() =>
      _TestTransparentRoutePageState();
}

class _TestTransparentRoutePageState extends State<TestTransparentRoutePage> {
  @override
  Widget build(BuildContext context) {
    return const Material(
      type: MaterialType.transparency,
      child: Center(
        child: Text('Transparent route page'),
      ),
    );
  }
}
