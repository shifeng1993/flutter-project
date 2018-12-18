// cmdb资产/监控 -> 监控
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:unicorndial/unicorndial.dart';
import '../../../common/baseStyle.dart';
import '../../../utils/mock.dart';

import '../../drawerPage/assets_right_drawer.dart';
import '../../../widgets/pull_push_list/index.dart';
import '../../../widgets/shadow_card/index.dart';

class CMDBAssetsMonitorPage extends StatefulWidget {
  CMDBAssetsMonitorPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _CMDBAssetsMonitorPageState createState() =>
      new _CMDBAssetsMonitorPageState();
}

class _CMDBAssetsMonitorPageState extends State<CMDBAssetsMonitorPage> {
  BuildContext context;
  List<Map<String, dynamic>> monitorList;
  ScrollController _scrollController;
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
          '${(i + (currentPage - 1) * pageSize).toString()}这是标题，我来展示，这是标题，我来展示这是标题，我来展示，这是标题，我来展示';
      row['ip'] = Mock.getIP();
      row['type'] = Mock.getCiType();
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
        margin:
            EdgeInsets.only(left: iconSize + 20), // 给marginleft补齐量，使title在屏幕中央
        child: Center(
          child: Text(
            '资产监控',
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
            AssetImage("assets/icons/search_w.png"),
            size: iconSize,
          ),
          onPressed: () {
            print('搜索');
          },
        ),
        Builder(builder: (BuildContext context) {
          return IconButton(
            icon: ImageIcon(
              AssetImage("assets/icons/filter.png"),
              size: iconSize,
            ),
            onPressed: () {
              Scaffold.of(context).openEndDrawer();
            },
          );
        }),
      ],
      centerTitle: false, // 消除 android 与 ios 页面title布局差异
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
            child: _getAssetStatusImage(0),
            mini: true,
            onPressed: () => _setStatusList(0),
          ),
        ),
        UnicornButton(
          currentButton: FloatingActionButton(
            backgroundColor: BaseStyle.statusColor[1],
            heroTag: 'normal',
            child: _getAssetStatusImage(1),
            mini: true,
            onPressed: () => _setStatusList(1),
          ),
        ),
        UnicornButton(
          currentButton: FloatingActionButton(
            backgroundColor: BaseStyle.statusColor[2],
            heroTag: 'warning',
            child: _getAssetStatusImage(2),
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
        physics: ClampingScrollPhysics(),
        itemCount: monitorList.length ?? 0,
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
                                  child: Text(
                                      Mock.getAssetStatus(row['status']),
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

  void cardOnPress(row) {
    print(row.toString());
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
