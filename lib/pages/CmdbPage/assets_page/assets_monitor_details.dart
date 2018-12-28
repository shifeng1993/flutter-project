// cmdb资产/监控 -> 监控 -> 监控详情
import 'dart:math';
import 'dart:async';
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
  Map<String, dynamic> monitorDetalisMap;
  List<String> monitorDetalisMapKeys;

  Duration _duration = Duration(milliseconds: 300);
  Curve _curve = Curves.fastOutSlowIn;

  double _opacity1;
  double _opacity2;
  double _opacity3;

  Timer _timer;
  Timer _timerChild;
  Timer _timerOpacity1;
  Timer _timerOpacity2;
  Timer _timerOpacity3;

  @override
  void initState() {
    super.initState();
    monitorDetalisMap = _getMonitorDetalisMap();
    monitorDetalisMapKeys = monitorDetalisMap.keys.toList();
    _opacity1 = 0.0;
    _opacity2 = 0.0;
    _opacity3 = 0.0;
    this._timer = Timer.periodic(Duration(milliseconds: 1800), (Timer timer) {
      this._opacityTo1();
      this._timerChild = Timer(const Duration(milliseconds: 1000), () {
        this._opacityTo0();
      });
    });
  }

  @override
  dispose() {
    _timer?.cancel();
    _timerChild?.cancel();
    _timerOpacity1?.cancel();
    _timerOpacity2?.cancel();
    _timerOpacity3?.cancel();

    super.dispose();
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

  Map<String, dynamic> _getMonitorDetalisMap() {
    Map<String, dynamic> data = new Map();
    data['基本监控'] = _getListRow('基本监控');
    data['地址'] = _getListRow('地址');
    data['接口'] = _getListRow('接口');
    data['处理器'] = _getListRow('处理器');
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

  void _opacityTo1() {
    _timerOpacity1 = Timer(const Duration(milliseconds: 300), () {
      setState(() {
        _opacity1 = 1.0;
      });
      _timerOpacity2 = Timer(const Duration(milliseconds: 300), () {
        setState(() {
          _opacity2 = 0.7;
        });
        _timerOpacity3 = Timer(const Duration(milliseconds: 300), () {
          setState(() {
            _opacity3 = 0.4;
          });
        });
      });
    });
  }

  void _opacityTo0() async {
    _timerOpacity1 = Timer(const Duration(milliseconds: 200), () {
      setState(() {
        _opacity1 = 0.0;
      });
      _timerOpacity2 = Timer(const Duration(milliseconds: 200), () {
        setState(() {
          _opacity2 = 0.0;
        });
        _timerOpacity3 = Timer(const Duration(milliseconds: 200), () {
          setState(() {
            _opacity3 = 0.0;
          });
        });
      });
    });
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
    children.add(_infoCard());
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
      padding: EdgeInsets.all(15),
      colors: [Color(0xff599FFE), Color(0xff355FE3)],
      child: Container(
        child: Column(
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(5),
                  child: Image.asset('assets/icons/assets_icon_w.png'),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: Text(
                            widget.row['name'],
                            style: TextStyle(
                              color: Color(0xffffffff),
                              fontSize: BaseStyle.fontSize[2],
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 5),
                          child: Text(
                            '(ip：${widget.row['ip']})',
                            style: TextStyle(
                              color: Color.fromRGBO(255, 255, 255, 0.6),
                              fontSize: BaseStyle.fontSize[4],
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(30 / 2)),
                    child: Container(
                      width: 65,
                      height: 30,
                      color: Color(0xffffffff),
                      child: Center(
                        child: Text(
                          Mock.getAssetStatus(widget.row['status']),
                          style: TextStyle(
                              fontSize: BaseStyle.fontSize[3],
                              color: Color(0xff3C6CE8)),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  AnimatedOpacity(
                    duration: _duration,
                    curve: _curve,
                    opacity: _opacity3,
                    child: Container(
                      width: 8,
                      height: 41,
                      child: Transform(
                        child: Image.asset(
                          'assets/images/monitor_details_card_center_3.png',
                          fit: BoxFit.contain,
                        ),
                        alignment: Alignment.center,
                        transform: Matrix4.identity()..rotateZ(0.0 * pi / 180),
                      ),
                    ),
                  ),
                  AnimatedOpacity(
                    duration: _duration,
                    curve: _curve,
                    opacity: _opacity2,
                    child: Container(
                      width: 6,
                      height: 30,
                      margin: EdgeInsets.only(left: 6),
                      child: Transform(
                        child: Image.asset(
                          'assets/images/monitor_details_card_center_2.png',
                          fit: BoxFit.contain,
                        ),
                        alignment: Alignment.center,
                        transform: Matrix4.identity()..rotateZ(0.0 * pi / 180),
                      ),
                    ),
                  ),
                  AnimatedOpacity(
                    duration: _duration,
                    curve: _curve,
                    opacity: _opacity1,
                    child: Container(
                      width: 5,
                      height: 19,
                      margin: EdgeInsets.only(left: 8),
                      child: Transform(
                        child: Image.asset(
                          'assets/images/monitor_details_card_center_1.png',
                          fit: BoxFit.contain,
                        ),
                        alignment: Alignment.center,
                        transform: Matrix4.identity()..rotateZ(0.0 * pi / 180),
                      ),
                    ),
                  ),
                  Container(
                    width: 72,
                    height: 66,
                    margin: EdgeInsets.only(left: 13, right: 13),
                    child: Transform(
                      child: Image.asset(
                        'assets/images/monitor_details_card_center.png',
                        fit: BoxFit.contain,
                      ),
                      alignment: Alignment.center,
                      transform: Matrix4.identity()..rotateZ(0.0 * pi / 180),
                    ),
                  ),
                  AnimatedOpacity(
                    duration: _duration,
                    curve: _curve,
                    opacity: _opacity1,
                    child: Container(
                      width: 5,
                      height: 19,
                      margin: EdgeInsets.only(right: 8),
                      child: Transform(
                        child: Image.asset(
                          'assets/images/monitor_details_card_center_1.png',
                          fit: BoxFit.contain,
                        ),
                        alignment: Alignment.center,
                        transform: Matrix4.identity()
                          ..rotateZ(180.0 * pi / 180),
                      ),
                    ),
                  ),
                  AnimatedOpacity(
                    duration: _duration,
                    curve: _curve,
                    opacity: _opacity2,
                    child: Container(
                      width: 6,
                      height: 30,
                      margin: EdgeInsets.only(right: 6),
                      child: Transform(
                        child: Image.asset(
                          'assets/images/monitor_details_card_center_2.png',
                          fit: BoxFit.contain,
                        ),
                        alignment: Alignment.center,
                        transform: Matrix4.identity()
                          ..rotateZ(180.0 * pi / 180),
                      ),
                    ),
                  ),
                  AnimatedOpacity(
                    duration: _duration,
                    curve: _curve,
                    opacity: _opacity3,
                    child: Container(
                      child: Transform(
                        child: Image.asset(
                          'assets/images/monitor_details_card_center_3.png',
                          fit: BoxFit.contain,
                        ),
                        alignment: Alignment.center,
                        transform: Matrix4.identity()
                          ..rotateZ(180.0 * pi / 180),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(30 / 2)),
                    child: Container(
                      height: 25,
                      padding: EdgeInsets.only(left: 20, right: 20),
                      color: Color.fromRGBO(255, 255, 255, 0.2),
                      child: Center(
                        child: Text(
                          '连续运行 1天12小时25分钟12秒',
                          style: TextStyle(
                            fontSize: BaseStyle.fontSize[3],
                            color: Color(0xffffffff),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Text(
                          'PING检测状态',
                          style: TextStyle(
                            color: Color.fromRGBO(255, 255, 255, 0.6),
                            fontSize: BaseStyle.fontSize[3],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 5),
                          child: Text(
                            'PING正常',
                            style: TextStyle(
                              fontSize: BaseStyle.fontSize[3],
                              color: Color(0xffffffff),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        left: BorderSide(
                          color: Color.fromRGBO(255, 255, 255, 0.2),
                          width: 1.0 / MediaQuery.of(context).devicePixelRatio,
                        ),
                      ),
                    ),
                    child: Column(
                      children: <Widget>[
                        Text(
                          'PING响应时间',
                          style: TextStyle(
                            color: Color.fromRGBO(255, 255, 255, 0.6),
                            fontSize: BaseStyle.fontSize[3],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 5),
                          child: Text(
                            '0.00ms',
                            style: TextStyle(
                              fontSize: BaseStyle.fontSize[3],
                              color: Color(0xffffffff),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        left: BorderSide(
                          color: Color.fromRGBO(255, 255, 255, 0.2),
                          width: 1.0 / MediaQuery.of(context).devicePixelRatio,
                        ),
                      ),
                    ),
                    child: Column(
                      children: <Widget>[
                        Text(
                          '监控频率',
                          style: TextStyle(
                            color: Color.fromRGBO(255, 255, 255, 0.6),
                            fontSize: BaseStyle.fontSize[3],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 5),
                          child: Text(
                            '180ms',
                            style: TextStyle(
                              fontSize: BaseStyle.fontSize[3],
                              color: Color(0xffffffff),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
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
      margin: EdgeInsets.only(bottom: 10, left: 15, right: 15),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(10)),
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
                monitorDetalisMapKeys[index],
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
                                  monitorDetalisMap[
                                          monitorDetalisMapKeys[titleIndex]]
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
                                  monitorDetalisMap[
                                          monitorDetalisMapKeys[titleIndex]]
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
                  monitorDetalisMap[monitorDetalisMapKeys[titleIndex]].length ??
                      0,
            );
          },
          itemHeight: (BuildContext context, int index) {
            int length = monitorDetalisMap[monitorDetalisMapKeys[index]].length;
            return itemHeight * length.toDouble();
          },
          itemCount: monitorDetalisMapKeys.length ?? 0,
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
