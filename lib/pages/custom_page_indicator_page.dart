///
/// [Author] Alex (https://github.com/AlexVincent525)
/// [Date] 2020-01-09 12:50
///
import 'package:flutter/material.dart';

class CustomPageViewIndicatorPage extends StatefulWidget {
  const CustomPageViewIndicatorPage({Key? key}) : super(key: key);

  @override
  _CustomPageViewIndicatorPageState createState() =>
      _CustomPageViewIndicatorPageState();
}

class _CustomPageViewIndicatorPageState
    extends State<CustomPageViewIndicatorPage> {
  final PageController pageController = PageController();

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        currentPage = pageController.page ?? 0;
      });
    });
  }

  double currentPage = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Center(
                    child: Text(currentPage.toString()),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: PageView(
                    controller: pageController,
                    children: List<Widget>.generate(
                      3,
                      (int i) => Container(
                        color: Colors.blue,
                        child: Center(child: Text('$i')),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: kBottomNavigationBarHeight,
            child: ClipRect(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(child: Container(color: Colors.redAccent)),
                  Expanded(child: Container(color: Colors.yellow)),
                  Expanded(child: Container(color: Colors.green)),
                ],
              ),
              clipper: CustomIndicatorClipper(page: currentPage),
              clipBehavior: Clip.antiAlias,
            ),
          ),
        ],
      ),
    );
  }
}

class CustomIndicatorClipper extends CustomClipper<Rect> {
  const CustomIndicatorClipper({required this.page});

  final double page;

  @override
  Rect getClip(Size size) {
    final Rect rect = Rect.fromLTRB(
      page * size.width / 3,
      0.0,
      size.width / 3 + page * size.width / 3,
      size.height,
    );
    return rect;
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) => true;
}
