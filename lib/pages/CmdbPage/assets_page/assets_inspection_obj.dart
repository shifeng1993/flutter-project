// cmdb资产 -> 资产管理
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../../common/baseStyle.dart';
import '../../../utils/mock.dart';

import '../../drawerPage/assets_right_drawer.dart';
import '../../../widgets/shadow_card/index.dart';
import '../../../widgets/page_route_Builder/index.dart';

import './assets_inspection_res.dart';

class CMDBAssetsInspectionObjPage extends StatefulWidget {
  CMDBAssetsInspectionObjPage({Key key, this.title, this.inspectionObjList})
      : super(key: key);

  final String title;
  final List<Map<String, dynamic>> inspectionObjList;
  @override
  _CMDBAssetsInspectionObjPageState createState() =>
      new _CMDBAssetsInspectionObjPageState();
}

class _CMDBAssetsInspectionObjPageState
    extends State<CMDBAssetsInspectionObjPage> {
  BuildContext context;
  int currentPage = 1;
  int pageSize = 15;

  @override
  void initState() {
    super.initState();
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
            '巡检对象',
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
        Builder(builder: (BuildContext context) {
          return IconButton(
            icon: ImageIcon(
              AssetImage("assets/icons/search_w.png"),
              size: iconSize,
            ),
            onPressed: () {
              // Scaffold.of(context).openEndDrawer();
            },
          );
        }),
      ],
      centerTitle: true, // 消除 android 与 ios 页面title布局差异
      elevation: 0.0, // 去掉appbar下面的阴影
    );
  }

  Widget _body() {
    List<Widget> children = (widget.inspectionObjList == null ||
            widget.inspectionObjList.length == 0)
        ? <Widget>[]
        : widget.inspectionObjList.map((row) {
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

    List<Action> actions = [
      Action(
        title: Text('删'),
        backgroundColor: Color(0xffff0000),
        onPressed: () {
          print('删除');
          print(row.toString());
        },
      )
    ];

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
      actions: actions,
      onPressed: () {
        Navigator.push(
            context, RouteBuilder.iosPage(CMDBAssetsInspectionResPage()));
      },
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              child: Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(right: 5),
                          child: Image.asset(
                            'assets/icons/assets_icon.png',
                            width: 20,
                            height: 20,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            row['name'],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: flexTextTitle,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Text(
                            '安全性${row['score']}',
                            style: TextStyle(
                              fontSize: BaseStyle.fontSize[3],
                              color: double.parse(row['score']) < 60
                                  ? BaseStyle.statusColor[0]
                                  : BaseStyle.statusColor[1],
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.clip,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 15),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: flex[0],
                          child: Center(
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(bottom: 5),
                                  child: Center(
                                    child: Text('IP地址', style: flexTextKey),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    row['ip'],
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: flexTextVal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: flex[1],
                          child: Center(
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(bottom: 5),
                                  child: Center(
                                    child: Text('资产类型', style: flexTextKey),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    row['type'],
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: flexTextVal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: flex[2],
                          child: Center(
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(bottom: 5),
                                  child: Center(
                                    child: Text('资产状态', style: flexTextKey),
                                  ),
                                ),
                                Center(
                                  child: Text(row['status'],
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: flexTextVal),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<bool> _goback() {
    print('_goback');
    Navigator.of(context).pop();
    return new Future.value(false);
  }
}
