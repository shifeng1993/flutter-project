// cmdb首页
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import "package:pull_to_refresh/pull_to_refresh.dart";
import '../../../common/baseStyle.dart';

import './chart.dart';

class CMDBIndexPage extends StatefulWidget {
  CMDBIndexPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _CMDBIndexPageState createState() => new _CMDBIndexPageState();
}

class _CMDBIndexPageState extends State<CMDBIndexPage> {
  RefreshController _refreshController; // 下拉刷新的控制器

  @override
  void initState() {
    super.initState();
    _refreshController = new RefreshController();
  }

  void enterRefresh() {
    _refreshController.requestRefresh(true);
  }

  void _onOffsetCallback(bool isUp, double offset) {
    // if you want change some widgets state ,you should rewrite the callback
  }

  void _onRefresh(bool up) {
    if (up)
      new Future.delayed(const Duration(milliseconds: 2009)).then((val) {
        _refreshController.sendBack(true, RefreshStatus.idle);
        setState(() {});
//                refresher.sendStatus(RefreshStatus.completed);
      });
    else {
      new Future.delayed(const Duration(milliseconds: 2009)).then((val) {
        setState(() {});
        _refreshController.sendBack(false, RefreshStatus.idle);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SmartRefresher(
        enablePullDown: true, // 打开下拉
        // enablePullUp: true,
        onRefresh: _onRefresh,
        onOffsetChange: _onOffsetCallback,
        child: new ListView(
          children: <Widget>[
            _banner(context),
            _notification(context),
            _indexTitle(context, '资产状态'),
            CMDBIndexPageChart(),
            _indexTitle(context, '关注的监控资产'),
            _watchList(context),
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
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [const Color(0xff43CAFF), const Color(0xff2D4DD5)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              image: DecorationImage(
                image: AssetImage(
                    'assets/banner/banner_' + (index + 1).toString() + '.png'),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
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
  Widget _watchList(BuildContext context) {
    final Map<String, dynamic> data = {};
    return Container(
      margin: EdgeInsets.only(left: 15.0, right: 15.0),
      // child: ListView(
      //   key: _listViewKey,
      //   shrinkWrap: true,
      //   children: <Widget>[
      //     const Text('I\'m dedicating every day to you'),
      //     const Text('Domestic life was never quite my style'),
      //     const Text('When you smile, you knock me out, I fall apart'),
      //     const Text('And I thought I was so smart'),
      //   ],
      // ),
    );
  }

  @override
  void dispose() {
    print("销毁");
    super.dispose();
  }
}
