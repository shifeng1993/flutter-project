// cmdb事件
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:charts_flutter/flutter.dart';
import '../../../common/baseStyle.dart';
import '../../../utils/mock.dart';

import '../../../widgets/pull_list/index.dart';
import '../../../widgets/shadow_card/index.dart';
import '../../../widgets/shadow_card/card_title.dart';
import '../../../widgets/page_route_Builder/index.dart';

// tab页面需要导航的页面

class CMDBEventPage extends StatefulWidget {
  CMDBEventPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _CMDBEventPageState createState() => new _CMDBEventPageState();
}

class _CMDBEventPageState extends State<CMDBEventPage> {
  BuildContext context;
  List<Map<String, dynamic>> flexHeaderList;
  List<Series> _chart1List;
  List<Series> _chart2List;
  List<Series> _chart3List;

  @override
  void initState() {
    super.initState();
    flexHeaderList = [
      {
        'flex': 1,
        'imgPath': 'assets/icons/cmdb_event_monitor.png',
        'title': '监控事件',
        'onPressed': () {
          // Navigator.push(context, RouteBuilder.iosPage(CMDBAssetsManagePage()));
        }
      },
      {
        'flex': 1,
        'imgPath': 'assets/icons/cmdb_event_ope.png',
        'title': '运维事件',
        'onPressed': () {}
      },
      {
        'flex': 1,
        'imgPath': 'assets/icons/cmdb_event_db.png',
        'title': '数据库事件',
        'onPressed': () {}
      },
      {
        'flex': 1,
        'imgPath': 'assets/icons/cmdb_event_business.png',
        'title': '业务事件',
        'onPressed': () {}
      },
      {
        'flex': 1,
        'imgPath': 'assets/icons/cmdb_event_log.png',
        'title': '日志事件',
        'onPressed': () {}
      },
    ];
    _chart1List = _getChart1List();
    _chart2List = _getChart2List();
    _chart3List = _getChart3List();
  }

  void _onRefresh(dynamic refreshController, bool up) {
    new Future.delayed(const Duration(milliseconds: 500)).then((val) {
      setState(() {
        _chart1List = _getChart1List();
        _chart2List = _getChart2List();
        _chart3List = _getChart3List();
      });
      refreshController.sendBack(true, RefreshStatus.completed);
    });
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Container(
      child: PullList(
        onRefresh: _onRefresh,
        child: new ListView(
          physics: BouncingScrollPhysics(),
          children: <Widget>[
            _headerCard(),
            ShadowCardTitle(title: '事件级别统计'),
            _chart1Card(),
            // ShadowCardTitle(title: '告警事件统计'),
            // _chart2Card(),
            ShadowCardTitle(title: '事件走势统计'),
            _chart3Card(),
          ],
        ),
      ),
    );
  }

  Widget _headerCard() {
    List<Widget> children =
        (flexHeaderList == null || flexHeaderList.length == 0)
            ? <Widget>[]
            : flexHeaderList.map((item) {
                return _headerCardItem(item);
              }).toList(); // 列表
    return ShadowCard(
      margin: EdgeInsets.only(left: 15, top: 10, right: 15, bottom: 0),
      padding: EdgeInsets.only(left: 5, right: 5),
      child: Row(children: children),
    );
  }

  Widget _headerCardItem(Map<String, dynamic> item) {
    return Expanded(
      flex: item['flex'],
      child: GestureDetector(
        onTap: item['onPressed'],
        child: Container(
          padding: EdgeInsets.only(top: 20, bottom: 20),
          child: Center(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 5),
                  child: Image.asset(
                    item['imgPath'],
                    width: 34,
                    height: 34,
                  ),
                ),
                Center(
                  child: Text(
                    item['title'],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: BaseStyle.fontSize[4],
                      color: BaseStyle.textColor[1],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Series<ChartItem, String>> _getChart1List() {
    final data = [
      ChartItem('严重', Random().nextInt(100)),
      ChartItem('主要', Random().nextInt(100)),
      ChartItem('次要', Random().nextInt(100)),
      ChartItem('告警', Random().nextInt(100)),
    ];

    return [
      Series<ChartItem, String>(
        id: 'Chart2',
        domainFn: (ChartItem sales, _) => sales.type,
        measureFn: (ChartItem sales, _) => sales.length,
        data: data,
      )
    ];
  }

  // 事件级别统计
  Widget _chart1Card() {
    return ShadowCard(
      margin: EdgeInsets.only(left: 15, right: 15),
      padding: EdgeInsets.only(left: 5, right: 5),
      child: Container(
        width: MediaQuery.of(context).size.width - 20 * 2,
        height: 200,
        child: BarChart(
          _chart1List,
          animate: true,
          vertical: true,
        ),
      ),
    );
  }

  List<Series<ChartItem, String>> _getChart2List() {
    final data = [
      ChartItem('问卷调查', Random().nextInt(100)),
      ChartItem('HA', Random().nextInt(100)),
      ChartItem('日志审计', Random().nextInt(100)),
      ChartItem('用户口令', Random().nextInt(100)),
      ChartItem('稽核', Random().nextInt(100)),
      ChartItem('改密', Random().nextInt(100)),
      ChartItem('业务服务', Random().nextInt(100)),
      ChartItem('磁盘', Random().nextInt(100)),
      ChartItem('运维', Random().nextInt(100)),
      ChartItem('监控', Random().nextInt(100)),
      ChartItem('审计', Random().nextInt(100)),
    ];

    return [
      Series<ChartItem, String>(
        id: 'Chart2',
        domainFn: (ChartItem sales, _) => sales.type,
        measureFn: (ChartItem sales, _) => sales.length,
        data: data,
      )
    ];
  }

  // 告警事件统计
  Widget _chart2Card() {
    return ShadowCard(
      margin: EdgeInsets.only(left: 15, right: 15),
      padding: EdgeInsets.only(left: 5, right: 5),
      child: Container(
        width: MediaQuery.of(context).size.width - 20 * 2,
        height: 500,
        child: BarChart(
          _chart2List,
          animate: true,
          vertical: false,
        ),
      ),
    );
  }

  List<Series<Chart3Item, num>> _getChart3List() {
    final data = [
      Chart3Item(1, Random().nextInt(100)),
      Chart3Item(7, Random().nextInt(100)),
      Chart3Item(15, Random().nextInt(100)),
      Chart3Item(30, Random().nextInt(100)),
    ];

    return [
      Series<Chart3Item, num>(
        id: 'Chart3',
        colorFn: (_, __) => MaterialPalette.blue.shadeDefault,
        domainFn: (Chart3Item sales, _) => sales.type,
        measureFn: (Chart3Item sales, _) => sales.length,
        data: data,
      )
    ];
  }

  // 事件走势
  Widget _chart3Card() {
    return Stack(
      children: <Widget>[
        ShadowCard(
          margin: EdgeInsets.only(left: 15, right: 15),
          padding: EdgeInsets.only(left: 5, right: 5),
          child: Container(
            width: MediaQuery.of(context).size.width - 20 * 2,
            height: 200,
            child: LineChart(
              _chart3List,
              animate: true,
              defaultRenderer: LineRendererConfig(includePoints: true),
            ),
          ),
        ),
      ],
    );
  }
}

class ChartItem {
  final String type;
  final int length;

  ChartItem(this.type, this.length);
}

class Chart3Item {
  final int type;
  final int length;

  Chart3Item(this.type, this.length);
}
