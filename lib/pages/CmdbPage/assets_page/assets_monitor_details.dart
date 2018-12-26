// cmdb资产/监控 -> 监控 -> 监控详情
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../../common/baseStyle.dart';
import '../../../utils/mock.dart';

import '../../../widgets/shadow_card/index.dart';
import '../../../widgets/pull_list/index.dart';
import '../../../widgets/accordion/accordion_list.dart';
import '../../../widgets/accordion/accordion_list_item.dart';

class CMDBAssetsMonitorDetalisPage extends StatefulWidget {
  CMDBAssetsMonitorDetalisPage({Key key, this.row}) : super(key: key);

  final Map<String, dynamic> row;
  @override
  _CMDBAssetsMonitorDetalisPageState createState() =>
      new _CMDBAssetsMonitorDetalisPageState();
}

class _CMDBAssetsMonitorDetalisPageState
    extends State<CMDBAssetsMonitorDetalisPage> {
  BuildContext context;
  Map<String, dynamic> assetsDetalisMap;
  List<String> assetsDetalisMapKeys;

  @override
  void initState() {
    super.initState();
    assetsDetalisMap = _getAssetsDetalisMap();
    assetsDetalisMapKeys = assetsDetalisMap.keys.toList();
  }

  List<Map<String, dynamic>> _getListRow(String typeStr) {
    int length = Random().nextInt(10);
    List<Map<String, dynamic>> list = List.generate(length, (i) {
      Map<String, dynamic> row = new Map();
      row['key'] = '${typeStr.toString()}${(i + 1).toString()}';
      row['val'] = '${typeStr.toString()}的值';
      return row;
    });
    return list;
  }

  Map<String, dynamic> _getAssetsDetalisMap() {
    Map<String, dynamic> data = new Map();
    data['通用属性'] = _getListRow('通用属性');
    data['特殊属性'] = _getListRow('特殊属性');
    data['资产账户'] = _getListRow('资产账户');
    data['协议设置'] = _getListRow('协议设置');
    data['文档'] = _getListRow('文档');
    data['生命周期'] = _getListRow('生命周期');
    return data;
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return WillPopScope(
      child: Scaffold(
        appBar: _appbar(),
        body: _body(),
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
            '监控详情',
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

  void _onRefresh(dynamic controller, bool up) {
    new Future.delayed(const Duration(milliseconds: 200)).then((val) {
      setState(() {
        // monitorList = _getManageList(currentPage, pageSize);
      });
      controller.sendBack(true, RefreshStatus.completed);
    });
  }

  Widget _body() {
    List<Widget> children = new List<Widget>();
    children.add(_headerCard());
    // children.add(_infoCard());
    return PullList(
      onRefresh: _onRefresh,
      child: ListView(
        padding: EdgeInsets.only(top: 10),
        physics: BouncingScrollPhysics(),
        children: children,
      ),
    );
  }

  // 头部卡片
  Widget _headerCard() {
    return ShadowCard(
      margin: EdgeInsets.only(bottom: 10, left: 15, right: 15),
      padding: EdgeInsets.only(left: 10, top: 15, right: 10, bottom: 15),
      colors: [Color(0xff599FFE), Color(0xff355FE3)],
      child: Container(
        child: Column(
          children: <Widget>[
            Text('上'),
            Text('中'),
            Text('下'),
          ],
        ),
      ),
    );
  }

  // 信息卡片
  Widget _infoCard() {
    double itemHeight = 50.0;
    BorderSide itemBorderWidth = BorderSide(
      color: BaseStyle.lineColor[0],
      width: 1.0 / MediaQuery.of(context).devicePixelRatio,
    );
    return ShadowCard(
      colors: [Color(0xff599FFE), Color(0xff355FE3)],
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            top: itemBorderWidth,
          ),
        ),
        child: AccordionList(
          listTitlePadding: EdgeInsets.only(left: 15, right: 10),
          rightIconColor: Color(0xff000000),
          rightIconSize: 20.0,
          listTitleDecoration: BoxDecoration(
            color: Color(0xffffffff),
            border: Border(
              bottom: itemBorderWidth,
            ),
          ),
          listTitle: (BuildContext context, int index) {
            return Container(
              height: 50.0,
              color: Color(0x00000000), // 占满宽度
              alignment: Alignment.centerLeft,
              child: Text(
                assetsDetalisMapKeys[index],
                style: TextStyle(
                    fontSize: BaseStyle.fontSize[1],
                    color: BaseStyle.textColor[0]),
                overflow: TextOverflow.ellipsis,
              ),
            );
          },
          listMenu: (BuildContext context, int titleIndex) {
            return ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int menuIndex) {
                return Container(
                  decoration: BoxDecoration(
                    color: Color(0xffF5F7FA),
                    border: Border(
                      bottom: itemBorderWidth,
                    ),
                  ),
                  height: itemHeight,
                  child: Material(
                    child: InkWell(
                      highlightColor: Color.fromRGBO(0, 0, 0, 0.04),
                      splashColor: Color.fromRGBO(0, 0, 0, 0.02),
                      onTap: () {
                        print(123);
                      },
                      child: Container(
                        padding: EdgeInsets.only(left: 15, right: 15),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  assetsDetalisMap[
                                          assetsDetalisMapKeys[titleIndex]]
                                      [menuIndex]['key'],
                                  style: TextStyle(
                                    fontSize: BaseStyle.fontSize[2],
                                    color: BaseStyle.textColor[2],
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  assetsDetalisMap[
                                          assetsDetalisMapKeys[titleIndex]]
                                      [menuIndex]['val'],
                                  style: TextStyle(
                                    fontSize: BaseStyle.fontSize[2],
                                    color: BaseStyle.textColor[2],
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
              itemCount:
                  assetsDetalisMap[assetsDetalisMapKeys[titleIndex]].length ??
                      0,
            );
          },
          itemHeight: (BuildContext context, int index) {
            int length = assetsDetalisMap[assetsDetalisMapKeys[index]].length;
            return itemHeight * length.toDouble();
          },
          itemCount: assetsDetalisMapKeys.length ?? 0,
          // controller: new AnimationController(),
        ),
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
