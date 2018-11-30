// cmdb首页
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import '../../../common/baseStyle.dart';

import '../../../widgets/pull_list/index.dart';
import '../../../widgets/shadow_card/index.dart';
import './chart.dart';

class CMDBIndexPage extends StatefulWidget {
  CMDBIndexPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _CMDBIndexPageState createState() => new _CMDBIndexPageState();
}

class _CMDBIndexPageState extends State<CMDBIndexPage> {
  List<Map<String, dynamic>> watchList;

  @override
  void initState() {
    super.initState();
    watchList = _getWatchList();
  }

  List<Map<String, dynamic>> _getWatchList() {
    List<Map<String, dynamic>> data = new List.generate(10, (i) {
      i++;
      Map<String, dynamic> row = new Map();
      row['name'] = i.toString();
      row['ip'] = '111.111.111.${i.toString()}';
      row['type'] = 'linux';
      row['status'] = 1;
      return row;
    });
    return data;
  }

  void _onRefresh(dynamic refreshController, bool up) {
    if (up)
      new Future.delayed(const Duration(milliseconds: 2009)).then((val) {
        setState(() {});
        refreshController.sendBack(true, RefreshStatus.completed);
      });
    else {
      new Future.delayed(const Duration(milliseconds: 2009)).then((val) {
        setState(() {});
        refreshController.sendBack(false, RefreshStatus.idle);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: PullList(
        onRefresh: _onRefresh,
        child: new ListView(
          children: <Widget>[
            _banner(context),
            _notification(context),
            _indexTitle(context, '资产状态'),
            CMDBIndexPageChart(
              normal: 1,
              error: 3,
              warning: 4,
            ),
            _indexTitle(context, '关注的监控资产'),
            _watchList(context, watchList),
          ],
        ),
      ),
    );
  }

  Widget _banner(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width / 2.7,
      padding: EdgeInsets.only(top: 10.0),
      color: const Color(0xffffffff),
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return ShadowCard(
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
        autoplay: true, //自动播放
        duration: 1000, // 自动播放毫秒数
        index: 0, // 初始
        viewportFraction: 0.85,
        scale: 0.9,
      ),
    );
  }

  // 通知栏
  Widget _notification(BuildContext context) {
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
  Widget _indexTitle(BuildContext context, String title) {
    return Container(
      alignment: Alignment.centerLeft,
      padding:
          EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0, bottom: 10.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: BaseStyle.fontSize[1],
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  // 关注列表
  Widget _watchList(
      BuildContext context, List<Map<String, dynamic>> watchList) {
    List<Widget> children = (watchList == null || watchList.length == 0)
        ? <Widget>[]
        : watchList
            .take(5)
            .map((row) => _watchListCard(row))
            .toList(); // 列表使用take限制在5个数量
    return Container(
      margin: EdgeInsets.only(left: 15.0, right: 15.0),
      child: Column(
        children: children,
      ),
    );
  }

  // 关注列表卡片
  Widget _watchListCard(row) {
    return ShadowCard(
      margin: EdgeInsets.only(bottom: 10),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text('123 '),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Center(
                            child: Column(
                              children: <Widget>[
                                Text('IP地址'),
                                Text(row['ip']),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Center(
                            child: Column(
                              children: <Widget>[
                                Text('IP地址'),
                                Text(row['ip']),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Center(
                            child: Column(
                              children: <Widget>[
                                Text('IP地址'),
                                Text(row['ip']),
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
