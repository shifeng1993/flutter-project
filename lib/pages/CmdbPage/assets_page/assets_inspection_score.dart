// cmdb资产 -> 资产管理
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../../common/baseStyle.dart';
import '../../../utils/mock.dart';

import '../../drawerPage/assets_right_drawer.dart';
import '../../../widgets/pull_push_list/index.dart';
import '../../../widgets/shadow_card/index.dart';

class CMDBAssetsInspectionScorePage extends StatefulWidget {
  CMDBAssetsInspectionScorePage({Key key, this.title}) : super(key: key);

  final String title;
  @override
  _CMDBAssetsInspectionScorePageState createState() =>
      new _CMDBAssetsInspectionScorePageState();
}

class _CMDBAssetsInspectionScorePageState
    extends State<CMDBAssetsInspectionScorePage> {
  BuildContext context;
  List<Map<String, dynamic>> scoreList;

  @override
  void initState() {
    super.initState();
    scoreList = _getScoreList();
  }

  List<Map<String, dynamic>> _getScoreList() {
    List<Map<String, dynamic>> data = new List.generate(3, (i) {
      Map<String, dynamic> row = new Map();
      String score = Mock.getScore();
      row['id'] = i;
      row['name'] = '测评项${(i + 1).toString()}';
      row['score'] = score;
      row['pass'] = double.parse(score) >= 60.0;
      row['title'] =
          '应通过设定终端接入方式，网络地址范围等条件限制终端登录';
      row['remark'] =
          '应通过设定终端接入方式，网络地址范围等条件限制终端登录';
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
            '得分说明',
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
    return ShadowCard(
      margin: EdgeInsets.only(bottom: 10, left: 15, right: 15),
      padding: EdgeInsets.only(top: 15, bottom: 15),
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
                    padding: EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: BaseStyle.lineColor[0],
                          width: 1.0 / MediaQuery.of(context).devicePixelRatio,
                        ),
                      ),
                    ),
                    child: Row(
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(15),
                              bottomRight: Radius.circular(15)),
                          child: Container(
                            height: 30,
                            padding: EdgeInsets.only(left: 15, right: 15),
                            color: Color(0xff6BC9FF),
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
                        Expanded(
                          flex: 1,
                          child: Container(),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 15),
                          child: Stack(
                            children: <Widget>[
                              row['pass']
                                  ? Image.asset(
                                      'assets/icons/pass.png',
                                      fit: BoxFit.contain,
                                    )
                                  : Image.asset(
                                      'assets/icons/not_pass.png',
                                      fit: BoxFit.contain,
                                    ),
                              Positioned(
                                left: 0,
                                top: 0,
                                bottom: 6,
                                right: 0,
                                child: Center(
                                  child: row['pass']
                                      ? Text(
                                          '满足',
                                          style: TextStyle(
                                            fontSize: BaseStyle.fontSize[4],
                                            color: Color(0xffffffff),
                                          ),
                                        )
                                      : Text(
                                          '不满足',
                                          style: TextStyle(
                                            fontSize: BaseStyle.fontSize[4],
                                            color: Color(0xffffffff),
                                          ),
                                        ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 15),
                          child: Stack(
                            children: <Widget>[
                              Image.asset(
                                'assets/icons/score.png',
                                fit: BoxFit.contain,
                              ),
                              Positioned(
                                left: 0,
                                top: 0,
                                bottom: 5,
                                right: 0,
                                child: Center(
                                  child: Text(
                                    row['score'],
                                    style: TextStyle(
                                      fontSize: BaseStyle.fontSize[3],
                                      color: Color(0xffffffff),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: Text(
                            row['title'],
                            style: TextStyle(
                              color: BaseStyle.textColor[0],
                              fontSize: BaseStyle.fontSize[2],
                            ),
                            maxLines: 5,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          child: Text(
                            '说明：${row['remark']}',
                            style: TextStyle(
                              color: BaseStyle.textColor[2],
                              fontSize: BaseStyle.fontSize[4],
                            ),
                            maxLines: 10,
                            overflow: TextOverflow.ellipsis,
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
