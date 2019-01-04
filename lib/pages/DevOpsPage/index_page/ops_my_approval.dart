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

class DevOpsMyApprovalPage extends StatefulWidget {
  DevOpsMyApprovalPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _DevOpsMyApprovalPageState createState() =>
      new _DevOpsMyApprovalPageState();
}

class _DevOpsMyApprovalPageState extends State<DevOpsMyApprovalPage> {
  BuildContext context;
  List<Map<String, dynamic>> applicationList;
  int currentPage = 1;
  int pageSize = 15;

  @override
  void initState() {
    super.initState();
    applicationList = _getApplicationList(1, pageSize);
  }

  void _onRefresh(dynamic controller) {
    new Future.delayed(const Duration(milliseconds: 200)).then((val) {
      currentPage = 1;
      setState(() {
        applicationList = _getApplicationList(currentPage, pageSize);
      });
      controller.sendBack(true, RefreshStatus.completed);
    });
  }

  void _onLoad(dynamic controller) {
    new Future.delayed(const Duration(milliseconds: 200)).then((val) {
      currentPage++;
      setState(() {
        applicationList.addAll(_getApplicationList(currentPage, pageSize));
      });
      controller.sendBack(false, RefreshStatus.completed);
      controller.sendBack(false, RefreshStatus.idle);
    });
  }

  List<Map<String, dynamic>> _getApplicationList(
      int currentPage, int pageSize) {
    List<String> typeList = ['系统变更', '密码更改', '稽核', '改密'];
    List<Map<String, dynamic>> data = new List.generate(pageSize, (i) {
      i++;
      Map<String, dynamic> row = new Map();
      row['name'] =
          '${(i + (currentPage - 1) * pageSize).toString()}这是运维申请，纯展示用，这是运维申请，纯展示用';
      row['opsNumber'] =
          '2018062600${(i + (currentPage - 1) * pageSize).toString()}';
      row['type'] = typeList[Random().nextInt(4)];
      row['status'] = Random().nextInt(2);
      row['startTime'] = Mock.getDateTime();
      row['endTime'] = Mock.getDateTime();
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
            '我的审批',
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
        itemBuilder: (BuildContext context, int index) {
          return _listCard(context, applicationList[index], index);
        },
        physics: BouncingScrollPhysics(),
        itemCount: applicationList.length ?? 0,
      ),
    );
  }

  Widget _listCard(BuildContext context, Map<String, dynamic> row, int index) {
    List<int> flex = [1, 1];

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
      padding: EdgeInsets.only(left: 10, top: 15, bottom: 15),
      actions: actions,
      onPressed: () {
        // Navigator.push(context, RouteBuilder.iosPage(CMDBAssetsDetalisPage()));
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
                            'assets/icons/ops_my_application.png',
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
                        row['status'] == 0
                            ? Container(
                                margin: EdgeInsets.only(left: 5, right: 10),
                                decoration: BoxDecoration(
                                  color: Color(0xffFCF6ED),
                                  border: Border.all(
                                    width: 1.0 /
                                        MediaQuery.of(context).devicePixelRatio,
                                    color: Color(0xffF8EAD5),
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(3)),
                                ),
                                padding: EdgeInsets.only(
                                    left: 10, right: 10, top: 1, bottom: 1),
                                child: Center(
                                  child: Text(
                                    '审批中',
                                    style: TextStyle(
                                      fontSize: BaseStyle.fontSize[4],
                                      color: Color(0xffE7A647),
                                    ),
                                  ),
                                ),
                              )
                            : Container(
                                margin: EdgeInsets.only(left: 5, right: 10),
                                decoration: BoxDecoration(
                                  color: Color(0xffFCF6ED),
                                  border: Border.all(
                                    width: 1.0 /
                                        MediaQuery.of(context).devicePixelRatio,
                                    color: Color(0xffF8EAD5),
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(3)),
                                ),
                                padding: EdgeInsets.only(
                                    left: 10, right: 10, top: 1, bottom: 1),
                                child: Center(
                                  child: Text(
                                    '通过',
                                    style: TextStyle(
                                      fontSize: BaseStyle.fontSize[4],
                                      color: BaseStyle.statusColor[1],
                                    ),
                                  ),
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
                                    child: Text('运维类型', style: flexTextKey),
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
                          flex: flex[1],
                          child: Center(
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(bottom: 5),
                                  child: Center(
                                    child: Text('运维号', style: flexTextKey),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    row['opsNumber'],
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: flexTextVal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 15),
                          padding: EdgeInsets.only(
                              top: 3, bottom: 3, left: 20, right: 17),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(30),
                              topLeft: Radius.circular(30),
                            ),
                            color: Color(0xffF4F4F4),
                          ),
                          child: Container(
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(bottom: 5),
                                  child: Center(
                                    child: Text(
                                      '开始 ${row['startTime']}',
                                      style: TextStyle(
                                          fontSize: BaseStyle.fontSize[4],
                                          color: BaseStyle.textColor[0]),
                                    ),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    '结束 ${row['endTime']}',
                                    style: TextStyle(
                                        fontSize: BaseStyle.fontSize[4],
                                        color: BaseStyle.textColor[0]),
                                  ),
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
}
