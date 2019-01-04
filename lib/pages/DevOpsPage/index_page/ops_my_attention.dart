// devops -> 我的审批
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../../common/baseStyle.dart';
import '../../../utils/mock.dart';

import '../../../widgets/pull_push_list/index.dart';
import '../../../widgets/shadow_card/index.dart';
import '../../../widgets/page_route_Builder/index.dart';
import '../../../widgets/triangle/index.dart';

class DevOpsMyAttentionPage extends StatefulWidget {
  DevOpsMyAttentionPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _DevOpsMyAttentionPageState createState() =>
      new _DevOpsMyAttentionPageState();
}

class _DevOpsMyAttentionPageState extends State<DevOpsMyAttentionPage> {
  BuildContext context;
  List<Map<String, dynamic>> attentionList;
  var currentStatus;
  int currentPage = 1;
  int pageSize = 15;

  @override
  void initState() {
    super.initState();
    currentStatus = null;
    attentionList = _getManageList(1, pageSize);
  }

  void _onRefresh(dynamic controller) {
    new Future.delayed(const Duration(milliseconds: 200)).then((val) {
      currentPage = 1;
      setState(() {
        attentionList = _getManageList(currentPage, pageSize);
      });
      controller.sendBack(true, RefreshStatus.completed);
    });
  }

  void _onLoad(dynamic controller) {
    new Future.delayed(const Duration(milliseconds: 200)).then((val) {
      currentPage++;
      setState(() {
        attentionList.addAll(_getManageList(currentPage, pageSize));
      });
      controller.sendBack(false, RefreshStatus.completed);
      controller.sendBack(false, RefreshStatus.idle);
    });
  }

  List<Map<String, dynamic>> _getManageList(int currentPage, int pageSize) {
    List<Map<String, dynamic>> data = new List.generate(pageSize, (i) {
      i++;
      Map<String, dynamic> row = new Map();
      row['name'] =
          '${(i + (currentPage - 1) * pageSize).toString()}这是标题，我来展示，这是标题，我来展示这是标题，我来展示，这是标题，我来展示';
      row['ip'] = Mock.getIP();
      row['status'] = currentStatus == null ? Mock.getStatus() : currentStatus;
      row['protocolName'] = 'SSH';
      row['accountName'] = 'ROOT';
      return row;
    });
    return data;
  }

  Future<bool> _goback() {
    print('_goback');
    Navigator.of(context).pop();
    return new Future.value(false);
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
            '我的关注',
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
              print('搜索');
            },
          );
        }),
      ],
      centerTitle: true, // 消除 android 与 ios 页面title布局差异
      elevation: 0.0, // 去掉appbar下面的阴影
    );
  }

  Widget _body() {
    return PullPushList(
      onLoad: _onLoad,
      onRefresh: _onRefresh,
      child: ListView.builder(
        padding: EdgeInsets.only(top: 10),
        itemBuilder: (BuildContext context, int index) {
          return _listCard(context, attentionList[index], index);
        },
        physics: BouncingScrollPhysics(),
        itemCount: attentionList.length ?? 0,
      ),
    );
  }

  Widget _listCard(BuildContext context, Map<String, dynamic> row, int index) {
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
      margin: EdgeInsets.only(bottom: 10, left: 15, right: 15, top: 0),
      padding: EdgeInsets.only(left: 10, top: 15, right: 10, bottom: 15),
      actions: actions,
      onPressed: () {
        // Navigator.push(
        //   context,
        //   RouteBuilder.iosPage(
        //     MonitorDetalisPage(row: row),
        //   ),
        // );
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
                          child: _getAssetStatusImage(row['status']),
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
                                    child: Text('客户端IP地址', style: flexTextKey),
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
                                    child: Text('协议名', style: flexTextKey),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    row['protocolName'],
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
                                    child: Text('账号名', style: flexTextKey),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                      row['accountName'],
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

  Widget _getAssetStatusImage(int status) {
    double size = 20.0;
    Widget img;
    switch (status) {
      case 0:
        img = Image.asset(
          'assets/icons/assets_status_error.png',
          width: size,
          height: size,
        );
        break;
      case 1:
        img = Image.asset(
          'assets/icons/assets_status_normal.png',
          width: size,
          height: size,
        );
        break;
      case 2:
        img = Image.asset(
          'assets/icons/assets_status_warning.png',
          width: size,
          height: size,
        );
        break;
      default:
        img = null;
    }
    return img;
  }
}
