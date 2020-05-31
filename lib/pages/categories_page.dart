///
/// [Author] Alex (https://github.com/AlexVincent525)
/// [Date] 2020-01-15 10:39
///
import 'package:flutter/material.dart';

import 'package:testapp/constants/constants.dart';

@FFRoute(name: "/categories-page", routeName: "分类页")
class CategoriesPage extends StatefulWidget {
  @override
  _CategoriesPageState createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  final _menuItemsResponse = <Map<String, dynamic>>[
    {
      "id": "1216641992120414210",
      "pid": "1215566421248524290",
      "name": "商品库查询"
    },
    {"id": "1216641327088349186", "pid": "1215566421248524290", "name": "公告"},
    {"id": "1215566686601166850", "pid": "1215566245175836673", "name": "外场操作"},
    {
      "id": "1217283928581812225",
      "pid": "1215566491717025793",
      "name": "财务统计分析"
    },
    {
      "id": "1216642256281874433",
      "pid": "1215566491717025793",
      "name": "账单信息查询"
    },
    {"id": "1216642125218263042", "pid": "1215566421248524290", "name": "在线咨询"},
    {
      "id": "1216641791364247553",
      "pid": "1215566421248524290",
      "name": "报关信息查询"
    },
    {
      "id": "1215566421248524290",
      "pid": "1215565952358891522",
      "name": "委托信息查询"
    },
    {"id": "1216642382228434945", "pid": "1215566245175836673", "name": "运输操作"},
    {
      "id": "1217283696011849729",
      "pid": "1215566491717025793",
      "name": "发票信息查询"
    },
    {
      "id": "1215566491717025793",
      "pid": "1215565952358891522",
      "name": "财务数据查询"
    },
    {
      "id": "1215566245175836673",
      "pid": "1215565952358891522",
      "name": "外场工作平台"
    },
    {"id": "1215565952358891522", "pid": "0", "name": "移动端"}
  ];
  final _menuItemIcons = <String, String>{
    "外场操作": "inspector",
    "运输操作": "chauffeur",
    "财务统计分析": "statistics",
    "发票信息查询": "invoice",
    "账单信息查询": "bill",
    "在线咨询": "refer",
    "公告": "notice",
    "商品库查询": "wearhouse",
    "报关信息查询": "customs",
  };

  LoginDataUserMenuList topList;
  Map<LoginDataUserMenuList, List<LoginDataUserMenuList>> menuList = {};

  @override
  void initState() {
    /// Pull out the root node.
    topList = LoginDataUserMenuList.fromJson(
      _menuItemsResponse.where((item) => item['pid'] == '0').elementAt(0),
    );
    _menuItemsResponse.removeWhere((item) => item['pid'] == '0');

    /// Pull out the first layer of nodes.
    _menuItemsResponse
        .where((item) => item['pid'] == topList.id)
        .forEach((_item) {
      final item = LoginDataUserMenuList.fromJson(_item);
      if (item.pid == topList.id && !menuList.keys.contains(item)) {
        menuList[item] = <LoginDataUserMenuList>[];
      }
    });
    _menuItemsResponse.removeWhere((item) => item['pid'] == topList.id);

    /// Fill first layer of nodes.
    _menuItemsResponse.forEach((_item) {
      final item = LoginDataUserMenuList.fromJson(_item);
      final key = menuList.keys
          .firstWhere((list) => list.id == item.pid, orElse: () => null);
      if (key != null) menuList[key].add(item);
    });
    super.initState();
  }

  Widget sectionWidget(LoginDataUserMenuList key) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("$key"),
        Wrap(
          children: List<Widget>.generate(
            menuList[key].length,
            (i) => itemWidget(menuList[key].elementAt(i)),
          ),
        ),
      ],
    );
  }

  Widget itemWidget(LoginDataUserMenuList item) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        debugPrint("Pressed: ${item.name}");
      },
      child: SizedBox.fromSize(
        size: Size.square(100.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Image.asset(
                "assets/icons/home/${_menuItemIcons[item.name]}-home.png"),
            Text("${item.name}"),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        itemCount: menuList.keys.length,
        itemBuilder: (context, index) =>
            sectionWidget(menuList.keys.elementAt(index)),
      ),
    );
  }
}

class LoginDataUserMenuList {
  String id;
  String pid;
  String name;

  LoginDataUserMenuList({this.id, this.pid, this.name});

  LoginDataUserMenuList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pid = json['pid'];
    name = json['name'];
  }

  @override
  String toString() {
    return 'LoginDataUserMenuList{id: $id, pid: $pid, name: $name}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LoginDataUserMenuList &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => pid.hashCode;
}
