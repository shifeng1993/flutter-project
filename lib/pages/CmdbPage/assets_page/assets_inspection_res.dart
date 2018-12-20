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
    scoreList = _getScoreList(10);
  }

  List<Map<String, dynamic>> _getScoreList(int length) {
    List<String> nameList = ['访问控制(S3)', '安全审计(G3)', '身份鉴别(S3)'];
    List<int> weightList = Mock.getWeightList(length: length);
    List<Map<String, dynamic>> data = new List.generate(length, (i) {
      Map<String, dynamic> row = new Map();
      row['id'] = i;
      row['name'] = nameList[(i).toInt() % 3];
      row['score'] = Mock.getScore(); // 权重
      row['weight'] = weightList[i].toDouble() / 100;
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
    List<Color> colors;
    switch (row['id'] % 3) {
      case 0:
        colors = [Color(0xff56C7CA), Color(0xff41AA4C)];
        break;
      case 1:
        colors = [Color(0xffFFC820), Color(0xffFF9E13)];
        break;
      case 2:
        colors = [Color(0xffE8A051), Color(0xffEA534B)];
        break;
      default:
    }
    return ShadowCard(
      margin: EdgeInsets.only(bottom: 10, left: 15, right: 15),
      padding: EdgeInsets.all(15),
      colors: colors,
      image: DecorationImage(
        alignment: Alignment.centerRight,
        image: AssetImage('assets/images/assets_inspection_res.png'),
        fit: BoxFit.contain,
      ),
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
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: Row(
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          child: Container(
                            height: 30,
                            padding: EdgeInsets.only(left: 10, right: 10),
                            color: Color.fromRGBO(255, 255, 255, 0.3),
                            child: Center(
                              child: Text(
                                row['name'],
                                style: TextStyle(
                                  fontSize: BaseStyle.fontSize[2],
                                  color: Color(0xffffffff),
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.clip,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            padding: EdgeInsets.only(left: 5),
                            child: Column(
                              children: <Widget>[
                                Text(
                                  (row['weight'] * double.parse(row['score']))
                                      .toStringAsFixed(1),
                                  style: TextStyle(
                                    fontSize: 48,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xffffffff),
                                  ),
                                ),
                                Text(
                                  '最终得分',
                                  style: TextStyle(
                                    fontSize: BaseStyle.fontSize[2],
                                    color: Color.fromRGBO(255, 255, 255, 0.6),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(), // 这里给一个空容器是利用flex特性把两侧的元素挤到两边
                        ),
                        Container(
                          child: Column(
                            children: <Widget>[
                              Container(
                                alignment: Alignment.centerLeft,
                                margin: EdgeInsets.only(bottom: 10),
                                child: Text(
                                  row['score'],
                                  style: TextStyle(
                                    fontSize: BaseStyle.fontSize[2],
                                    color: Color(0xffffffff),
                                  ),
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  '当前得分',
                                  style: TextStyle(
                                    fontSize: BaseStyle.fontSize[2],
                                    color: Color.fromRGBO(255, 255, 255, 0.6),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            children: <Widget>[
                              Container(
                                alignment: Alignment.center,
                                child: Text(
                                  'X',
                                  style: TextStyle(
                                    fontSize: BaseStyle.fontSize[2],
                                    color: Color.fromRGBO(255, 255, 255, 0.6),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          child: Column(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(bottom: 10),
                                alignment: Alignment.centerRight,
                                child: Text(
                                  row['weight'].toString(),
                                  style: TextStyle(
                                    fontSize: BaseStyle.fontSize[2],
                                    color: Color(0xffffffff),
                                  ),
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  '权重',
                                  style: TextStyle(
                                    fontSize: BaseStyle.fontSize[2],
                                    color: Color.fromRGBO(255, 255, 255, 0.6),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
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
