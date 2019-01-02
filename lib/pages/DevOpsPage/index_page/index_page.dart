// devops首页
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import '../../../common/baseStyle.dart';
import '../../../utils/mock.dart';

import '../../../widgets/pull_list/index.dart';
import '../../../widgets/shadow_card/index.dart';
import '../../../widgets/shadow_card/card_title.dart';
import '../../../widgets/page_route_Builder/index.dart';

import '../../CommonPage/message.dart';

class DevOpsIndexPage extends StatefulWidget {
  DevOpsIndexPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _DevOpsIndexPageState createState() => new _DevOpsIndexPageState();
}

class _DevOpsIndexPageState extends State<DevOpsIndexPage> {
  BuildContext context;
  List<Map<String, dynamic>> watchList;
  Map<String, int> chartData;

  @override
  void initState() {
    super.initState();
    watchList = _getNewEventList();
  }

  List<Map<String, dynamic>> _getNewEventList() {
    List<Map<String, dynamic>> data = new List.generate(10, (i) {
      i++;
      Map<String, dynamic> row = new Map();
      row['name'] = '${i.toString()}这是标题，我来展示，这是标题，我来展示这是标题，我来展示，这是标题，我来展示';
      row['ip'] = Mock.getIP();
      row['type'] = Mock.getCiType();
      row['status'] = Mock.getDateTime();
      return row;
    });
    return data;
  }

  void _onRefresh(dynamic refreshController, bool up) {
    new Future.delayed(const Duration(milliseconds: 500)).then((val) {
      setState(() {
        watchList = _getNewEventList();
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
            _header(),
            _notification(),
            _cardTitle('最新事件', false),
            _newEvent(),
            _actionsList(),
          ],
        ),
      ),
    );
  }

  Widget _header() {
    List headList = [
      {
        'title': '新建申请',
        'iconPath': 'assets/icons/ops_new.png',
        'onPressed': () {
          // Navigator.push(context, RouteBuilder.iosPage());
        }
      },
      {
        'title': '我的申请',
        'iconPath': 'assets/icons/ops_myshenqing.png',
        'onPressed': () {
          // Navigator.push(context, RouteBuilder.iosPage());
        }
      },
      {
        'title': '我的审批',
        'iconPath': 'assets/icons/ops_myshenpi.png',
        'onPressed': () {
          // Navigator.push(context, RouteBuilder.iosPage());
        }
      },
      {
        'title': '我的关注',
        'iconPath': 'assets/icons/ops_myfocus.png',
        'onPressed': () {
          // Navigator.push(context, RouteBuilder.iosPage());
        }
      }
    ];

    List<Widget> children = (headList == null || headList.length == 0)
        ? <Widget>[]
        : headList.take(4).map((row) {
            return Expanded(
              flex: 1,
              child: GestureDetector(
                onTap: () {
                  row['onPressed']();
                },
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Image.asset(
                        row['iconPath'],
                        fit: BoxFit.contain,
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5.0),
                        child: Text(
                          row['title'],
                          style: TextStyle(
                            fontSize: BaseStyle.fontSize[3],
                            color: BaseStyle.textColor[0],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(); // 列表使用take限制在5个数量
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(
        top: 25.0,
        left: 5.0,
        right: 5.0,
        bottom: 8.0,
      ),
      color: const Color(0xffffffff),
      child: Row(
        children: children,
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

  // 资产状态卡片头部
  Widget _cardTitle(String title, [bool rightButton = true]) {
    return ShadowCardTitle(
      title: title,
      onPressed: rightButton
          ? () {
              print(title);
            }
          : null,
    );
  }

  Widget _newEvent() {
    TextStyle keyStyle = TextStyle(
        fontSize: BaseStyle.fontSize[4],
        color: Color.fromRGBO(255, 255, 255, 0.6));
    TextStyle valStyle = TextStyle(
        fontSize: BaseStyle.fontSize[4],
        color: Color.fromRGBO(255, 255, 255, 1.0));
    return Container(
        height: 125.0,
        padding: EdgeInsets.only(top: 10.0),
        child: Center(
          child: Swiper(
            itemBuilder: (BuildContext context, int index) {
              Color color;
              List<Color> colors;
              switch (index) {
                case 0:
                  color = Color(0xff2D4DD5);
                  colors = [const Color(0xff43CAFF), const Color(0xff2D4DD5)];
                  break;
                case 1:
                  color = Color(0xff41AA4C);
                  colors = [const Color(0xff56C7CA), const Color(0xff41AA4C)];
                  break;
                case 2:
                  color = Color(0xff4C5572);
                  colors = [const Color(0xff74859D), const Color(0xff4C5572)];
                  break;
                default:
              }
              return ShadowCard(
                margin: EdgeInsets.only(bottom: 16),
                padding: EdgeInsets.all(10.0),
                colors: colors,
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(bottom: 15),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 4,
                              child: Container(
                                child: Text(
                                  '申请人：clairelee',
                                  style: TextStyle(
                                      fontSize: BaseStyle.fontSize[1],
                                      color: Color(0xffffffff),
                                      fontWeight: FontWeight.w500),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                  top: 2, bottom: 2, left: 8, right: 8),
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                color: Color(0xffffffff),
                              ),
                              child: Text(
                                '命令复核',
                                style: TextStyle(
                                    fontSize: BaseStyle.fontSize[4],
                                    color: color),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 3,
                              child: Container(
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      '运维号',
                                      style: keyStyle,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 5),
                                      child: Text(
                                        '1232143211342fdsafdsafsad13',
                                        style: valStyle,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Container(
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      '运维类型',
                                      style: keyStyle,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 5),
                                      child: Text(
                                        '故障处理',
                                        style: valStyle,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 5,
                              child: Container(
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      '时间',
                                      style: keyStyle,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 5),
                                      child: Text(
                                        '2018-12-19 12:31:11',
                                        style: valStyle,
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
                      ),
                    ],
                  ),
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
                      margin: EdgeInsets.only(left: 2, right: 2),
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
            viewportFraction: 0.9, // 视口宽度
            scale: 0.92, // 缩放
            autoplay: true, //自动播放
            autoplayDelay: 6000, // 自动播放毫秒数
            autoplayDisableOnInteraction: true, // 如果设置为true，autoplay则在使用滑动时禁用。
          ),
        ));
  }

  // 首页下方快捷动作
  Widget _actionsList() {
    List actionsList1 = [
      {
        'title': '特殊运维',
        'iconPath': 'assets/icons/ops_teshuyunwei.png',
        'onPressed': () {
          print(1);
          // Navigator.push(context, RouteBuilder.iosPage());
        }
      },
      {
        'title': '命令复核',
        'iconPath': 'assets/icons/ops_cmd.png',
        'onPressed': () {
          print(2);
          // Navigator.push(context, RouteBuilder.iosPage());
        }
      },
      {
        'title': '密码会同',
        'iconPath': 'assets/icons/ops_pwd.png',
        'onPressed': () {
          print(3);
          // Navigator.push(context, RouteBuilder.iosPage());
        }
      },
    ];
    List actionsList2 = [
      {
        'title': '报表统计',
        'iconPath': 'assets/icons/ops_baobiao.png',
        'onPressed': () {
          // Navigator.push(context, RouteBuilder.iosPage());
        }
      },
      {
        'title': '运维日志',
        'iconPath': 'assets/icons/ops_opelog.png',
        'onPressed': () {
          // Navigator.push(context, RouteBuilder.iosPage());
        }
      },
      {'title': '', 'iconPath': null, 'onPressed': null}
    ];

    List<Widget> children1 = (actionsList1 == null || actionsList1.length == 0)
        ? <Widget>[]
        : actionsList1.take(3).map((row) {
            return _actionItem(row);
          }).toList(); // 列表使用take限制在3个数量
    List<Widget> children2 = (actionsList2 == null || actionsList2.length == 0)
        ? <Widget>[]
        : actionsList2.take(3).map((row) {
            return _actionItem(row);
          }).toList(); // 列表使用take限制在3个数量

    return ShadowCard(
      margin: EdgeInsets.only(left: 15.0, right: 15.0, top: 20.0, bottom: 20.0),
      padding: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Container(
            child: Row(children: children1),
          ),
          Container(
            child: Row(children: children2),
          ),
        ],
      ),
    );
  }

  Widget _actionItem(row) {
    return Expanded(
      flex: 1,
      child: GestureDetector(
        onTap: () {
          if (row['onPressed'] != null) {
            row['onPressed']();
          }
        },
        child: Container(
          padding: EdgeInsets.all(10),
          color: Color(0x00000000),
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 5),
                child: row['iconPath'] != null
                    ? (Image.asset(row['iconPath'], fit: BoxFit.contain))
                    : Text(''),
              ),
              Text(
                row['title'],
                style: TextStyle(
                  fontSize: BaseStyle.fontSize[4],
                  color: BaseStyle.textColor[2],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
