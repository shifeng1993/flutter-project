// cmdb首页
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import '../../../common/baseStyle.dart';
import '../../../utils/mock.dart';

import '../../../widgets/pull_list/index.dart';
import '../../../widgets/shadow_card/index.dart';
import '../../../widgets/shadow_card/card_title.dart';
import './chart.dart';
import './watch_list_card.dart';

class CMDBIndexPage extends StatefulWidget {
  CMDBIndexPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _CMDBIndexPageState createState() => new _CMDBIndexPageState();
}

class _CMDBIndexPageState extends State<CMDBIndexPage> {
  BuildContext context;
  List<Map<String, dynamic>> watchList;
  Map<String, int> chartData;

  @override
  void initState() {
    super.initState();
    watchList = _getWatchList();
    chartData = _getChartData();
  }

  Map<String, int> _getChartData() {
    Map<String, int> chartData = new Map();
    chartData['normal'] = Random().nextInt(100);
    chartData['error'] = Random().nextInt(100);
    chartData['warning'] = Random().nextInt(100);
    return chartData;
  }

  List<Map<String, dynamic>> _getWatchList() {
    List<Map<String, dynamic>> data = new List.generate(10, (i) {
      i++;
      Map<String, dynamic> row = new Map();
      row['name'] = '${i.toString()}这是标题，我来展示，这是标题，我来展示这是标题，我来展示，这是标题，我来展示';
      row['ip'] = Mock.getIP();
      row['type'] = Mock.getCiType();
      row['status'] = Mock.getStatus();
      return row;
    });
    return data;
  }

  void _onRefresh(dynamic refreshController, bool up) {
    new Future.delayed(const Duration(milliseconds: 500)).then((val) {
      setState(() {
        watchList = _getWatchList();
        chartData = _getChartData();
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
          physics: ClampingScrollPhysics(),
          children: <Widget>[
            _banner(),
            _notification(),
            _cardTitle('资产状态'),
            CMDBIndexPageChart(
              normal: chartData['normal'],
              error: chartData['error'],
              warning: chartData['warning'],
              onPressed: (int status) {
                print(status);
              },
            ),
            _cardTitle('关注的监控资产'),
            _watchList(watchList),
          ],
        ),
      ),
    );
  }

  Widget _banner() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width / 2.7,
      padding: EdgeInsets.only(top: 10.0),
      color: const Color(0xffffffff),
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return ShadowCard(
            padding: EdgeInsets.all(10.0),
            colors: [const Color(0xff43CAFF), const Color(0xff2D4DD5)],
            image: DecorationImage(
              image: AssetImage(
                  'assets/banner/banner_' + (index + 1).toString() + '.png'),
              fit: BoxFit.cover,
            ),
          );
        },
        itemCount: 3,
        pagination: new SwiperPagination(
          alignment: Alignment.bottomCenter,
          margin: const EdgeInsets.all(5.0),
          builder: SwiperPagination.dots,
        ),
        onTap: (int index) {
          print(index);
        },
        duration: 1000, // 动画时长
        index: 0, // 初始
        viewportFraction: 0.85,
        scale: 0.9,
        autoplay: true, //自动播放
        autoplayDelay: 6000, // 自动播放毫秒数
        autoplayDisableOnInteraction: true, // 如果设置为true，autoplay则在使用滑动时禁用。
      ),
    );
  }

  // 通知栏
  Widget _notification() {
    String notificationStr = 'dsadsadas';
    double leftPointSize = 7.0;
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(top: 12.0, bottom: 12.0),
      color: const Color(0xffffffff),
      child: Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10.0),
            child: ClipRRect(
              borderRadius:
                  BorderRadius.all(Radius.circular(leftPointSize / 2)),
              child: Container(
                width: leftPointSize,
                height: leftPointSize,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          Container(
            child: Row(
              children: <Widget>[
                Text(
                  '公告：',
                  style: TextStyle(
                      fontSize: BaseStyle.fontSize[1],
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  notificationStr,
                  style: TextStyle(
                    fontSize: BaseStyle.fontSize[1],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 资产状态卡片头部
  Widget _cardTitle(String title) {
    return ShadowCardTitle(
      title: title,
      onPressed: () {
        print(title);
      },
    );
  }

  // 关注列表
  Widget _watchList(List<Map<String, dynamic>> watchList) {
    List<Widget> children = (watchList == null || watchList.length == 0)
        ? <Widget>[]
        : watchList.take(5).map((row) {
            return WatchListCard(
              row: row,
            );
          }).toList(); // 列表使用take限制在5个数量
    return Container(
      margin: EdgeInsets.only(left: 15.0, right: 15.0),
      child: Column(
        children: children,
      ),
    );
  }
}
