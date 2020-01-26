///
/// [Author] Alex (https://github.com/AlexVincent525)
/// [Date] 2020-01-26 10:35
///
import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:testapp/constants/constants.dart';

@FFRoute(name: "/test-multi-image-picker-page", routeName: "测试多选图片页")
class TestMultiImagePickerPage extends StatefulWidget {
  @override
  _TestMultiImagePickerPageState createState() => _TestMultiImagePickerPageState();
}

class _TestMultiImagePickerPageState extends State<TestMultiImagePickerPage> {
  final assets = <Asset>[];
  int imagesLength = 0, maxImagesLength = 9;

  Future<Null> loadAssets() async {
    List<Asset> resultList = List<Asset>();
    final permissions = await PermissionHandler().requestPermissions([
      PermissionGroup.camera,
      PermissionGroup.storage,
    ]);
    if (permissions[PermissionGroup.camera] == PermissionStatus.granted &&
        permissions[PermissionGroup.storage] == PermissionStatus.granted) {
      try {
        final results = await MultiImagePicker.pickImages(
          maxImages: 9,
          selectedAssets: assets,
          cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
          materialOptions: MaterialOptions(
            actionBarColor: "#abcdef",
            actionBarTitle: "Example App",
            allViewTitle: "All Photos",
            useDetailsView: false,
            selectCircleStrokeColor: "#000000",
          ),
        ).catchError((e) {
          debugPrint(e.toString());
        });
        if (results != null) resultList = results;
      } on Exception catch (e) {
        debugPrint('Open multi image picker failed: $e');
      }
    } else {
      return;
    }

    if (resultList != null) {
      assets
        ..clear()
        ..addAll(resultList);
      imagesLength = assets.length;
    }
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Test multi_image_picker page"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Picked images count'),
            Text(
              '$imagesLength',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: loadAssets,
        child: Icon(Icons.image),
      ),
    );
  }
}
