// ITIL首页
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import '../../../common/baseStyle.dart';
import '../../../utils/mock.dart';

import '../../../widgets/pull_list/index.dart';
import '../../../widgets/shadow_card/index.dart';
import '../../../widgets/page_route_Builder/index.dart';

import '../../CommonPage/message.dart';

class ITILIndexPage extends StatefulWidget {
  ITILIndexPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ITILIndexPageState createState() => new _ITILIndexPageState();
}

class _ITILIndexPageState extends State<ITILIndexPage> {
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
          physics: BouncingScrollPhysics(),
          children: <Widget>[
            _banner(),
            _notification(),
            _actionsCard(),
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
        pagination: SwiperCustomPagination(
          builder: (BuildContext context, SwiperPluginConfig config) {
            List<Widget> list = [];

            int itemCount = config.itemCount;
            int activeIndex = config.activeIndex;

            for (int i = 0; i < itemCount; ++i) {
              bool active = i == activeIndex;
              list.add(
                Container(
                  key: Key("pagination_$i"),
                  margin: EdgeInsets.only(left: 2, right: 2, bottom: 5),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(3)),
                    child: Container(
                      width: active ? 15 : 6,
                      height: 6,
                      color: active ? Color(0xffFFBC63) : Color(0xffD6D7D9),
                    ),
                  ),
                ),
              );
            }

            return Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: list,
              ),
            );
          },
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
    return GestureDetector(
      onTap: () {
        Navigator.push(context, RouteBuilder.iosPage(MessagePage()));
      },
      child: Container(
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
      ),
    );
  }

  List<List<Map<String, dynamic>>> actionsCardList = [
    [
      {
        'title': '我的报单',
        'iconPath': 'assets/icons/wdbd.png',
        'onPressed': () {
          print('我的报单');
        }
      },
      {
        'title': '我的待办',
        'iconPath': 'assets/icons/wddb.png',
        'onPressed': () {
          print('我的待办');
        }
      },
      {
        'title': '我的审批',
        'iconPath': 'assets/icons/myshenpi.png',
        'onPressed': () {
          print('我的审批');
        }
      },
    ],
    [
      {
        'title': '报表中心',
        'iconPath': 'assets/icons/bbzx.png',
        'onPressed': () {
          print('我的报单');
        }
      },
      {
        'title': '我的关注',
        'iconPath': 'assets/icons/myfocus.png',
        'onPressed': () {
          print('我的关注');
        }
      },
      {
        'title': '服务台',
        'iconPath': 'assets/icons/fwt.png',
        'onPressed': () {
          print('服务台');
        }
      },
    ]
  ];

  // 首页快捷按钮卡片
  Widget _actionsCard() {
    TextStyle titleStyle = TextStyle(
      fontSize: BaseStyle.fontSize[3],
      color: BaseStyle.textColor[0],
    );

    List<Widget> children = [];

    // 矩阵两层循环
    List<Widget> list = List.generate(actionsCardList.length, (i) {
      List<Widget> rowItem = List.generate(actionsCardList[i].length, (j) {
        Widget item;
        item = Expanded(
          flex: 1,
          child: GestureDetector(
            onTap: actionsCardList[i][j]['onPressed'],
            child: Container(
              color: Color(0x00000000),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: 5),
                    child: Image.asset(actionsCardList[i][j]['iconPath']),
                  ),
                  Text(actionsCardList[i][j]['title'], style: titleStyle),
                ],
              ),
            ),
          ),
        );
        return item;
      });

      Widget row = Container(
        margin: EdgeInsets.only(top: i == 0 ? 20 : 0, bottom: 20),
        child: Row(
          children: rowItem,
        ),
      );
      return row;
    });

    // 竖向搜索框
    children.add(Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  width: 1 / MediaQuery.of(context).devicePixelRatio,
                  color: BaseStyle.lineColor[0]))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 5),
            child: Text(
              '输入搜索工单',
              style: TextStyle(
                  fontSize: BaseStyle.fontSize[4],
                  color: BaseStyle.textColor[2]),
            ),
          ),
          Image.asset('assets/icons/search_b.png'),
        ],
      ),
    ));

    // 添加快捷按钮
    children.addAll(list);

    return ShadowCard(
      margin: EdgeInsets.all(15),
      onPressed: () {
        print(123);
      },
      child: Container(
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                child: Column(children: children),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
