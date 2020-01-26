///
/// [Author] Alex (https://github.com/AlexVincent525)
/// [Date] 2020-01-09 16:24
///
import 'package:flutter/material.dart';
import 'package:ff_annotation_route/ff_annotation_route.dart';

@FFRoute(
  name: "/test-scaffold-resize-page",
  routeName: "Scaffold大小变化测试页",
)
class TestScaffoldResizePage extends StatefulWidget {
  final String message;
  final String baseUrl;

  TestScaffoldResizePage({Key key, this.message, this.baseUrl = ''}) : super(key: key);

  @override
  _TestScaffoldResizePageState createState() => _TestScaffoldResizePageState();
}

// {'baseUrl': xxx}
class _TestScaffoldResizePageState extends State<TestScaffoldResizePage> {
  TextEditingController _extranetController;

  String _currentBaseUrl = '';

  String _httpStr = 'http://';

  @override
  void initState() {
    super.initState();
    _currentBaseUrl = widget.baseUrl.isNotEmpty ? widget.baseUrl : _httpStr;
    _extranetController = TextEditingController.fromValue(
      TextEditingValue(
        text: widget.baseUrl.isNotEmpty ? widget.baseUrl : _httpStr,
        selection: TextSelection.fromPosition(
          TextPosition(
            affinity: TextAffinity.downstream,
            offset: widget.baseUrl.isNotEmpty ? widget.baseUrl.length : _httpStr.length,
          ),
        ),
      ),
    );
    if (widget.message != null) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('设置基础路径'),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(70, 188, 173, 1.0),
      ),
      body: Center(
        child: Container(
          height: 160,
          width: 300,
          child: Column(
            children: <Widget>[
              TextField(
                keyboardType: TextInputType.text,
                controller: _extranetController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: '基础路径',
                  prefixIcon: Icon(Icons.http),
                ),
                onChanged: (v) {
                  this._currentBaseUrl = v.trim();
                },
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      height: 40,
                      margin: EdgeInsets.fromLTRB(0, 20.0, 0, 0),
                      child: RaisedButton(
                        child: Text('确定', style: TextStyle(fontSize: 15.5)),
                        textColor: Colors.white,
                        color: Color.fromRGBO(70, 188, 173, 1.0),
                        onPressed: () async {},
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 5.0),
              Row(
                children: <Widget>[
                  Text('温馨提示：请以\"http://\"开头，并且不能以\"/\"结尾。', style: TextStyle(fontSize: 10.0))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
