// ITIL待办
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../common/baseStyle.dart';
import '../../utils/mock.dart';

import '../../widgets/pull_push_list/index.dart';
import '../../widgets/shadow_card/index.dart';
import '../../widgets/page_route_Builder/index.dart';
import '../../widgets/triangle/index.dart';

class ITILGTasksPage extends StatefulWidget {
  ITILGTasksPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ITILGTasksPageState createState() => new _ITILGTasksPageState();
}

class _ITILGTasksPageState extends State<ITILGTasksPage> {
  BuildContext context;
  List<Map<String, dynamic>> gtaskList;
  int currentPage = 1;
  int pageSize = 15;

  @override
  void initState() {
    super.initState();
    gtaskList = _getGtaskList(1, pageSize);
  }

  void _onRefresh(dynamic controller) {
    new Future.delayed(const Duration(milliseconds: 200)).then((val) {
      currentPage = 1;
      setState(() {
        gtaskList = _getGtaskList(currentPage, pageSize);
      });
      controller.sendBack(true, RefreshStatus.completed);
    });
  }

  void _onLoad(dynamic controller) {
    new Future.delayed(const Duration(milliseconds: 200)).then((val) {
      currentPage++;
      setState(() {
        gtaskList.addAll(_getGtaskList(currentPage, pageSize));
      });
      controller.sendBack(false, RefreshStatus.completed);
      controller.sendBack(false, RefreshStatus.idle);
    });
  }

  List<Map<String, dynamic>> _getGtaskList(int currentPage, int pageSize) {
    List<Map<String, dynamic>> data = new List.generate(pageSize, (i) {
      i++;
      Map<String, dynamic> row = new Map();
      row['name'] =
          '${(i + (currentPage - 1) * pageSize).toString()}这是变更单，纯展示用，这是变更单，纯展示用';
      row['editTime'] = Mock.getDateTime();
      row['desc'] = '这是简要描述，不超过两行，这是简要描述，不超过两行，这是简要描述，不超过两行，这是简要描述，不超过两行';
      row['status'] = '已指派';
      row['attention'] = Random().nextInt(2);
      return row;
    });
    return data;
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return _body();
  }

  Widget _body() {
    return PullPushList(
      onLoad: _onLoad,
      onRefresh: _onRefresh,
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return _listCard(context, gtaskList[index], index);
        },
        physics: BouncingScrollPhysics(),
        itemCount: gtaskList.length ?? 0,
      ),
    );
  }

  Widget _listCard(BuildContext context, Map<String, dynamic> row, int index) {
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

    return ShadowCard(
      margin: EdgeInsets.only(
          bottom: 10, left: 15, right: 15, top: index == 0 ? 10 : 0),
      padding: EdgeInsets.only(left: 10, top: 15, bottom: 15, right: 10),
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
                        Expanded(
                          flex: 1,
                          child: Text(
                            row['name'],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: flexTextTitle,
                          ),
                        ),
                        row['attention'] != 0
                            ? Container(
                                margin: EdgeInsets.only(left: 5),
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
                                    '已关注',
                                    style: TextStyle(
                                      fontSize: BaseStyle.fontSize[4],
                                      color: BaseStyle.statusColor[1],
                                    ),
                                  ),
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 15),
                    child: Text(
                      row['desc'],
                      style: TextStyle(
                          fontSize: BaseStyle.fontSize[3],
                          color: BaseStyle.textColor[1]),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 15),
                    child: Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: 5),
                          decoration: BoxDecoration(
                            color: Color(0xffFCF6ED),
                            border: Border.all(
                              width:
                                  1.0 / MediaQuery.of(context).devicePixelRatio,
                              color: Color(0xffF8EAD5),
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(3)),
                          ),
                          padding: EdgeInsets.only(
                              left: 10, right: 10, top: 1, bottom: 1),
                          child: Center(
                            child: Text(
                              row['status'],
                              style: TextStyle(
                                fontSize: BaseStyle.fontSize[4],
                                color: BaseStyle.statusColor[1],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            color: Color(0x00000000),
                            alignment: Alignment.centerRight,
                            child: Text(
                              row['editTime'],
                              style: TextStyle(
                                  fontSize: BaseStyle.fontSize[3],
                                  color: BaseStyle.textColor[2]),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
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
}
