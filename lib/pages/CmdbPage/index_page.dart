// cmdb首页
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import '../../common/BaseStyle.dart';
import '../../widgets/circular_charts/circular_charts.dart';

class CMDBIndexPage extends StatefulWidget {
  CMDBIndexPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _CMDBIndexPageState createState() => new _CMDBIndexPageState();
}

class _CMDBIndexPageState extends State<CMDBIndexPage> {
  final GlobalKey<AnimatedCircularChartState> _chartKey =
      new GlobalKey<AnimatedCircularChartState>();
  final GlobalKey _listViewKey = new GlobalKey();

  List<CircularStackEntry> data;

  @override
  void initState() {
    super.initState();
    data = _generateRandomData();
  }

  double value = 50.0;

  void _randomize() {
    setState(() {
      data = _generateRandomData();
      _chartKey.currentState.updateData(data);
    });
  }

  int normal = 21;
  int warning = 8;
  int error = 182;

  List<CircularStackEntry> _generateRandomData() {
    int total = normal + warning + error;
    List<CircularStackEntry> data = [
      CircularStackEntry([
        CircularSegmentEntry(double.parse((normal / total * 100).toString()),
            BaseStyle.statusColor[1]),
        CircularSegmentEntry(
            double.parse(((total - normal) / total * 100).toString()),
            BaseStyle.statusColor[3]),
      ]),
      CircularStackEntry([
        CircularSegmentEntry(double.parse((warning / total * 100).toString()),
            BaseStyle.statusColor[2]),
        CircularSegmentEntry(
            double.parse(((total - warning) / total * 100).toString()),
            BaseStyle.statusColor[3]),
      ]),
      CircularStackEntry([
        CircularSegmentEntry(double.parse((error / total * 100).toString()),
            BaseStyle.statusColor[0]),
        CircularSegmentEntry(
            double.parse(((total - error) / total * 100).toString()),
            BaseStyle.statusColor[3]),
      ])
    ];

    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          _banner(context),
          _notification(context),
          _indexTitle(context, '资产状态'),
          _chart(context),
          _indexTitle(context, '关注的监控资产'),
          _watchList(context),
        ],
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

  // 资产状态卡片
  Widget _chart(BuildContext contxt) {
    int total = normal + warning + error;
    double cardStatusSize = 32.0;
    return Container(
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.only(left: 15.0, right: 15.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        color: Color(0xffffffff),
        boxShadow: <BoxShadow>[
          new BoxShadow(
            color: const Color.fromRGBO(0, 0, 0, 0.04),
            offset: new Offset(0.0, 0.0),
            blurRadius: 3.0,
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          // 左侧图表
          Expanded(
            flex: 1,
            child: new AnimatedCircularChart(
              key: _chartKey,
              size: Size(MediaQuery.of(context).size.width / 2.5,
                  MediaQuery.of(context).size.width / 2.5),
              initialChartData: data,
              chartType: CircularChartType.Radial,
              edgeStyle: SegmentEdgeStyle.round,
              percentageValues: true,
              holeLabel: (normal + warning + error).toString() + "台",
              labelStyle: TextStyle(
                  fontSize: BaseStyle.fontSize[2], color: Color(0xff000000)),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.all(
                              Radius.circular(cardStatusSize / 2)),
                          child: Container(
                            width: cardStatusSize,
                            height: cardStatusSize,
                            color: BaseStyle.statusColor[0],
                            child: Center(
                              child: Text(
                                '${error.toString()}',
                                style: TextStyle(
                                    fontSize: BaseStyle.fontSize[2],
                                    color: Color(0xffffffff)),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            '宕机${(error / total * 100).toStringAsFixed(1)}%',
                            style: TextStyle(fontSize: BaseStyle.fontSize[1]),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.all(
                              Radius.circular(cardStatusSize / 2)),
                          child: Container(
                            width: cardStatusSize,
                            height: cardStatusSize,
                            color: BaseStyle.statusColor[1],
                            child: Center(
                              child: Text(
                                '${normal.toString()}',
                                style: TextStyle(
                                    fontSize: BaseStyle.fontSize[2],
                                    color: Color(0xffffffff)),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            '正常${(normal / total * 100).toStringAsFixed(1)}%',
                            style: TextStyle(fontSize: BaseStyle.fontSize[1]),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.all(
                              Radius.circular(cardStatusSize / 2)),
                          child: Container(
                            width: cardStatusSize,
                            height: cardStatusSize,
                            color: BaseStyle.statusColor[2],
                            child: Center(
                              child: Text(
                                '${warning.toString()}',
                                style: TextStyle(
                                    fontSize: BaseStyle.fontSize[2],
                                    color: Color(0xffffffff)),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            '告警${(warning / total * 100).toStringAsFixed(1)}%',
                            style: TextStyle(fontSize: BaseStyle.fontSize[1]),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 关注列表
  Widget _watchList(BuildContext context) {
    final Map<String, dynamic> data = {

    };
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
}
