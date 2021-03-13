import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';

///
/// [Author] Alex (https://github.com/AlexV525)
/// [Date] 2020-11-12 22:21
///
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class TestWebViewInSingleScrollViewPage extends StatefulWidget {
  const TestWebViewInSingleScrollViewPage({Key? key}) : super(key: key);

  @override
  _TestWebViewInSingleScrollViewPageState createState() =>
      _TestWebViewInSingleScrollViewPageState();
}

class _TestWebViewInSingleScrollViewPageState
    extends State<TestWebViewInSingleScrollViewPage> {
  double slideValue = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 200,
              child: InAppWebView(
                gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
                  Factory<VerticalDragGestureRecognizer>(
                    () => VerticalDragGestureRecognizer(),
                  ),
                },
                initialOptions: InAppWebViewGroupOptions(
                  android: AndroidInAppWebViewOptions(
                    builtInZoomControls: true,
                    displayZoomControls: true,
                  ),
                  crossPlatform: InAppWebViewOptions(
                    supportZoom: true,
                  ),
                ),
                initialUrlRequest: URLRequest(
                  url: Uri.parse(
                    'https://i0.hdslb.com/bfs/vc/8e084d67aa18ed9c42dce043e06e16b79cbb50ef.png',
                  ),
                ),
              ),
            ),
            ...List<Widget>.generate(
              200,
              (int i) => Center(child: Text('$i$i$i$i$i')),
            ),
          ],
        ),
      ),
    );
  }
}
