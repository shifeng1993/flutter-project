// itil首页 -> 我的报单
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:unicorndial/unicorndial.dart';
import '../../../common/baseStyle.dart';
import '../../../utils/mock.dart';

import '../../drawerPage/assets_right_drawer.dart';
import '../../../widgets/pull_push_list/index.dart';
import '../../../widgets/shadow_card/index.dart';
import '../../../widgets/page_route_Builder/index.dart';

import '../../CommonPage/monitor_details.dart';

class ITILMyWorkorderPage extends StatefulWidget {
  ITILMyWorkorderPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ITILMyWorkorderPageState createState() => new _ITILMyWorkorderPageState();
}

class _ITILMyWorkorderPageState extends State<ITILMyWorkorderPage> {
  BuildContext context;
  List<Map<String, dynamic>> monitorList;
  ScrollController _scrollController;
  List<String> statusList = ['待审', '完成', '处理中'];
  var currentStatus;
  int currentPage = 1;
  int pageSize = 15;

  @override
  void initState() {
    super.initState();
    currentStatus = null;
    monitorList = _getManageList(1, pageSize);
  }

  void _onRefresh(dynamic controller) {
    new Future.delayed(const Duration(milliseconds: 200)).then((val) {
      currentPage = 1;
      setState(() {
        monitorList = _getManageList(currentPage, pageSize);
      });
      controller.sendBack(true, RefreshStatus.completed);
    });
  }

  void _onLoad(dynamic controller) {
    new Future.delayed(const Duration(milliseconds: 200)).then((val) {
      currentPage++;
      setState(() {
        monitorList.addAll(_getManageList(currentPage, pageSize));
      });
      controller.sendBack(false, RefreshStatus.completed);
      controller.sendBack(false, RefreshStatus.idle);
    });
  }

  void _onController(dynamic controller) {
    this._scrollController = controller.scrollController;
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
      row['name'] =
          '${(i + (currentPage - 1) * pageSize).toString()}这是变更单，纯展示用，这是变更单，纯展示用';
      row['editTime'] = Mock.getDateTime();
      row['desc'] = '这是简要描述，不超过两行，这是简要描述，不超过两行，这是简要描述，不超过两行，这是简要描述，不超过两行';
      row['attention'] = Random().nextInt(2);
      row['status'] = currentStatus == null ? Mock.getStatus() : currentStatus;
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
          floatingActionButton: _floatActionButton() //,
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
            '我的报单',
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
        IconButton(
          icon: ImageIcon(
            AssetImage("assets/icons/add.png"),
            size: iconSize,
          ),
          onPressed: () {
            print('新增');
          },
        ),
      ],
      centerTitle: true, // 消除 android 与 ios 页面title布局差异
      elevation: 0.0, // 去掉appbar下面的阴影
    );
  }

  _setStatusList(int status) {
    if (_scrollController.hasClients) {
      _scrollController
          .animateTo(
        0.0,
        curve: Curves.easeOut,
        duration: const Duration(milliseconds: 1000),
      )
          .then((val) {
        currentPage = 1;
        setState(() {
          currentStatus = status;
          monitorList = _getManageList(currentPage, pageSize);
        });
      });
    } else {
      print(_scrollController.hasClients.toString());
    }
  }

  Widget _floatActionButton() {
    return UnicornDialer(
      orientation: UnicornOrientation.VERTICAL,
      backgroundColor: Theme.of(context).accentColor,
      parentButton: Icon(Icons.add),
      hasBackground: false, // mask
      childButtons: <UnicornButton>[
        UnicornButton(
          currentButton: FloatingActionButton(
            backgroundColor: BaseStyle.statusColor[0],
            heroTag: 'error',
            child: Text(
              '待审',
              style: TextStyle(
                  fontSize: BaseStyle.fontSize[4],
                  color: BaseStyle.textColor[0]),
            ),
            mini: true,
            onPressed: () => _setStatusList(0),
          ),
        ),
        UnicornButton(
          currentButton: FloatingActionButton(
            backgroundColor: BaseStyle.statusColor[1],
            heroTag: 'normal',
            child: Text(
              '完成',
              style: TextStyle(
                  fontSize: BaseStyle.fontSize[4],
                  color: BaseStyle.textColor[0]),
            ),
            mini: true,
            onPressed: () => _setStatusList(1),
          ),
        ),
        UnicornButton(
          currentButton: FloatingActionButton(
            backgroundColor: BaseStyle.statusColor[2],
            heroTag: 'warning',
            child: Text(
              '处理中',
              style: TextStyle(
                  fontSize: BaseStyle.fontSize[4],
                  color: BaseStyle.textColor[0]),
            ),
            mini: true,
            onPressed: () => _setStatusList(2),
          ),
        ),
        UnicornButton(
          currentButton: FloatingActionButton(
            backgroundColor: Color(0xffffffff),
            heroTag: 'all',
            child: Text(
              '全部',
              style: TextStyle(
                  fontSize: BaseStyle.fontSize[4],
                  color: BaseStyle.textColor[0]),
            ),
            mini: true,
            onPressed: () => _setStatusList(null),
          ),
        ),
      ],
    );
  }

  Widget _body() {
    return PullPushList(
      onLoad: _onLoad,
      onRefresh: _onRefresh,
      onController: _onController,
      child: ListView.builder(
        padding: EdgeInsets.only(top: 10),
        itemBuilder: (BuildContext context, int index) {
          return _listCard(context, monitorList[index], index);
        },
        physics: BouncingScrollPhysics(),
        itemCount: monitorList.length ?? 0,
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
                              statusList[row['status']],
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
