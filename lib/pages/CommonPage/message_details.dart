// 系统公告通知列表
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:unicorndial/unicorndial.dart';
import '../../common/baseStyle.dart';
import '../../utils/mock.dart';

import '../../widgets/pull_push_list/index.dart';
import '../../widgets/shadow_card/index.dart';

class MessageDetalisPage extends StatefulWidget {
  MessageDetalisPage({Key key, this.title, this.dateTime, this.desc})
      : super(key: key);

  final String title;
  final String dateTime;
  final String desc;

  @override
  _MessageDetalisPageState createState() => new _MessageDetalisPageState();
}

class _MessageDetalisPageState extends State<MessageDetalisPage> {
  BuildContext context;
  List<Map<String, dynamic>> messageList;
  var currentStatus;
  int currentPage = 1;
  int pageSize = 15;

  @override
  void initState() {
    super.initState();
    currentStatus = null;
    messageList = _getManageList(1, pageSize);
  }

  void _onRefresh(dynamic controller) {
    new Future.delayed(const Duration(milliseconds: 200)).then((val) {
      currentPage = 1;
      setState(() {
        messageList = _getManageList(currentPage, pageSize);
      });
      controller.sendBack(true, RefreshStatus.completed);
    });
  }

  void _onLoad(dynamic controller) {
    new Future.delayed(const Duration(milliseconds: 200)).then((val) {
      currentPage++;
      setState(() {
        messageList.addAll(_getManageList(currentPage, pageSize));
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

  List<Map<String, dynamic>> _getManageList(int currentPage, int pageSize) {
    List<Map<String, dynamic>> data = new List.generate(pageSize, (i) {
      i++;
      Map<String, dynamic> row = new Map();
      row['title'] =
          '${(i + (currentPage - 1) * pageSize).toString()}这是标题，我来展示，这是标题，我来展示这是标题，我来展示，这是标题，我来展示';
      row['desc'] =
          '${(i + (currentPage - 1) * pageSize).toString()}这是描述，我来展示这是描述，我来展示这是描述，我来展示这是描述，我来展示这是描述，我来展示这是描述，我来展示这是描述，我来展示这是描述，我来展示这是描述，我来展示这是描述，我来展示这是描述，我来展示这是描述，我来展示这是描述，我来展示这是描述，我来展示这是描述，我来展示这是描述，我来展示这是描述，我来展示这是描述，我来展示这是描述，我来展示这是描述，我来展示这是描述，我来展示这是描述，我来展示这是描述，我来展示这是描述，我来展示这是描述，我来展示这是描述，我来展示这是描述，我来展示这是描述，我来展示这是描述，我来展示这是描述，我来展示这是描述，我来展示这是描述，我来展示这是描述，我来展示这是描述，我来展示这是描述，我来展示这是描述，我来展示这是描述，我来展示这是描述，我来展示这是描述，我来展示这是描述，我来展示这是描述，我来展示这是描述，我来展示这是描述，我来展示这是描述，我来展示这是描述，我来展示这是描述，我来展示这是描述，我来展示这是描述，我来展示这是描述，我来展示这是描述，我来展示这是描述，我来展示这是描述，我来展示这是描述，我来展示这是描述，我来展示这是描述，我来展示这是描述，我来展示';
      row['dateTime'] = Mock.getDateTime();
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
            '消息详情',
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
      centerTitle: true, // 消除 android 与 ios 页面title布局差异
      elevation: 0.0, // 去掉appbar下面的阴影
    );
  }

  TextStyle flexTextTitle = TextStyle(
      fontSize: BaseStyle.fontSize[1],
      color: BaseStyle.textColor[0],
      fontWeight: FontWeight.w500);

  TextStyle flexTextDateTime = TextStyle(
      fontSize: BaseStyle.fontSize[4],
      color: BaseStyle.textColor[2],
      fontWeight: FontWeight.w400);

  TextStyle flexTextDesc = TextStyle(
      fontSize: BaseStyle.fontSize[1],
      color: BaseStyle.textColor[0],
      fontWeight: FontWeight.w400);

  Widget _body() {
    return ListView(
      padding: EdgeInsets.only(top: 10),
      physics: BouncingScrollPhysics(),
      children: <Widget>[
        ShadowCard(
          margin: EdgeInsets.only(bottom: 10, left: 15, right: 15, top: 0),
          padding: EdgeInsets.only(left: 10, top: 15, right: 10, bottom: 15),
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(bottom: 10),
                        child: Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(right: 5),
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(7 / 2)),
                                child: Container(
                                  width: 7,
                                  height: 7,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                widget.title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: flexTextTitle,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(bottom: 10),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: Text(
                                widget.dateTime,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: flexTextDateTime,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(bottom: 10),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: Text(
                                widget.desc,
                                style: flexTextDesc,
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
        )
      ],
    );
  }

  void cardOnPress(row) {
    print(row.toString());
  }
}
