// cmdb资产 -> 资产管理
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../../common/baseStyle.dart';
import '../../../utils/mock.dart';

import '../../drawerPage/assets_right_drawer.dart';
import '../../../widgets/pull_push_list/index.dart';
import '../../../widgets/shadow_card/index.dart';

class CMDBAssetsInspectionResPage extends StatefulWidget {
  CMDBAssetsInspectionResPage({Key key, this.title}) : super(key: key);

  final String title;
  @override
  _CMDBAssetsInspectionResPageState createState() =>
      new _CMDBAssetsInspectionResPageState();
}

class _CMDBAssetsInspectionResPageState
    extends State<CMDBAssetsInspectionResPage> {
  BuildContext context;
  List<Map<String, dynamic>> scoreList;

  @override
  void initState() {
    super.initState();
    scoreList = _getScoreList();
  }

  List<Map<String, dynamic>> _getScoreList() {
    List<String> nameList = ['访问控制(S3)', '安全审计(G3)', '身份鉴别(S3)'];
    List<Map<String, dynamic>> data = new List.generate(2, (i) {
      i++;
      Map<String, dynamic> row = new Map();
      row['id'] = i;
      row['name'] = nameList[i.toInt()];
      row['score'] = Mock.getScore(); // 权重
      row['weight'] = double.parse(Random().nextDouble().toStringAsFixed(1));
      row['type'] = Mock.getCiType();
      row['status'] = Mock.getStatus();
      return row;
    });
    return data;
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return WillPopScope(
      child: Scaffold(
        appBar: _appbar(),
        body: _body(),
        endDrawer: AssetsRightDrawer(),
      ),
      onWillPop: _goback,
    );
  }

  Widget _appbar() {
    final iconSize = 22.0;
    return AppBar(
      title: Container(
        child: Center(
          child: Text(
            '巡检结果',
            style: TextStyle(fontSize: BaseStyle.fontSize[0]),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      leading: Builder(builder: (BuildContext context) {
        return IconButton(
          icon: ImageIcon(
            AssetImage("assets/icons/back.png"),
            size: iconSize,
          ),
          onPressed: _goback,
        );
      }),
      actions: <Widget>[
        Container(
          width: iconSize + 26, // 加26是为了补齐偏差
          height: iconSize + 26, // 加26是为了补齐偏差
        ),
      ],
      centerTitle: false, // 消除 android 与 ios 页面title布局差异
      elevation: 0.0, // 去掉appbar下面的阴影
    );
  }

  Widget _body() {
    List<Widget> children = (scoreList == null || scoreList.length == 0)
        ? <Widget>[]
        : scoreList.map((row) {
            return _listCard(
              context,
              row,
            );
          }).toList();
    return ListView(
      padding: EdgeInsets.only(top: 10),
      children: children,
      physics: BouncingScrollPhysics(),
    );
  }

  Widget _listCard(BuildContext context, Map<String, dynamic> row) {
    List<int> flex = [1, 1, 1];

    TextStyle flexTextTitle = TextStyle(
        fontSize: BaseStyle.fontSize[1],
        color: BaseStyle.textColor[0],
        fontWeight: FontWeight.w500);

    TextStyle flexTextKey = TextStyle(
        fontSize: BaseStyle.fontSize[3],
        color: BaseStyle.textColor[2],
        fontWeight: FontWeight.w400);

    TextStyle flexTextVal = TextStyle(
        fontSize: BaseStyle.fontSize[3],
        color: BaseStyle.textColor[0],
        fontWeight: FontWeight.w500);

    return ShadowCard(
      margin: EdgeInsets.only(bottom: 10, left: 15, right: 15),
      padding: EdgeInsets.only(left: 10, top: 15, right: 10, bottom: 15),
      onPressed: () {
        cardOnPress(row);
      },
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              child: Column(
                children: <Widget>[
                  
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void cardOnPress(row) {
    print(row.toString());
  }

  Future<bool> _goback() {
    print('_goback');
    Navigator.of(context).pop();
    return new Future.value(false);
  }
}
