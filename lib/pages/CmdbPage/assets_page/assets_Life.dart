// cmdb资产 -> 生命周期
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../../common/baseStyle.dart';
import '../../../utils/mock.dart';

import '../../../widgets/pull_push_list/index.dart';
import '../../../widgets/shadow_card/index.dart';

class CMDBAssetsLifePage extends StatefulWidget {
  CMDBAssetsLifePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _CMDBAssetsLifePageState createState() => new _CMDBAssetsLifePageState();
}

class _CMDBAssetsLifePageState extends State<CMDBAssetsLifePage> {
  BuildContext context;
  List<Map<String, dynamic>> lifeList;
  int currentPage = 1;
  int pageSize = 15;

  @override
  void initState() {
    super.initState();
    lifeList = _getInspectionList(1, pageSize);
  }

  void _onRefresh(dynamic controller) {
    new Future.delayed(const Duration(milliseconds: 200)).then((val) {
      currentPage = 1;
      setState(() {
        lifeList = _getInspectionList(currentPage, pageSize);
      });
      controller.sendBack(true, RefreshStatus.completed);
    });
  }

  void _onLoad(dynamic controller) {
    new Future.delayed(const Duration(milliseconds: 200)).then((val) {
      currentPage++;
      setState(() {
        lifeList.addAll(_getInspectionList(currentPage, pageSize));
      });
      controller.sendBack(false, RefreshStatus.completed);
      controller.sendBack(false, RefreshStatus.idle);
    });
  }

  Future<bool> _goback() {
    print('_goback');
    Navigator.of(context).pop();
    return new Future.value(false);
  }

  List<Map<String, dynamic>> _getInspectionList(int currentPage, int pageSize) {
    List<Map<String, dynamic>> data = new List.generate(pageSize, (i) {
      i++;
      Map<String, dynamic> row = new Map();
      row['name'] =
          '${(i + (currentPage - 1) * pageSize).toString()}这是标题，我来展示，这是标题，我来展示这是标题，我来展示，这是标题，我来展示';
      row['cycle'] = '${new Random().nextInt(5).toString()}天';
      row['createUser'] = '用户${new Random().nextInt(20).toString()}';
      row['createTime'] = Mock.getDateTime();
      row['remark'] = 'dsadjsakfldsjalk;dsjal;fdsa';
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
            '资产生命周期',
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
    return PullPushList(
      onLoad: _onLoad,
      onRefresh: _onRefresh,
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return _listCard(context, lifeList[index], index);
        },
        physics: BouncingScrollPhysics(),
        itemCount: lifeList.length ?? 0,
      ),
    );
  }

  Widget _listCard(BuildContext context, Map<String, dynamic> row, int index) {
    List<int> flex = [3, 3, 5];

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
      margin: EdgeInsets.only(
          bottom: 10, left: 15, right: 15, top: index == 0 ? 10 : 0),
      padding: EdgeInsets.only(left: 10, top: 15, right: 10, bottom: 15),
      actions: actions,
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
                                    child: Text('生命周期', style: flexTextKey),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    row['cycle'],
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
                                    child: Text('操作人', style: flexTextKey),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    row['createUser'],
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
                                    child: Text('更新时间', style: flexTextKey),
                                  ),
                                ),
                                Center(
                                  child: Text(row['createTime'],
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
                  ),
                  row['remark'] != null
                      ? Container(
                          margin: EdgeInsets.only(top: 10),
                          padding: EdgeInsets.only(top: 5),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '备注：${row['remark']}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: BaseStyle.fontSize[4],
                            ),
                          ),
                        )
                      : Container(),
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
}
