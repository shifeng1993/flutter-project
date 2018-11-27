// cmdb首页
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
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

  List<CircularStackEntry> data;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          _banner(context),
          _chart(context),
        ],
      ),
    );
  }

  Widget _banner(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width / 2.7,
      padding: EdgeInsets.only(top: 10.0,bottom: 10.0),
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
        CircularSegmentEntry(
            double.parse((normal / total * 100).toString()), Color(0xffe63434)),
        CircularSegmentEntry(
            double.parse(((total - normal) / total * 100).toString()),
            Color(0xffF0F2F5)),
      ]),
      CircularStackEntry([
        CircularSegmentEntry(double.parse((warning / total * 100).toString()),
            Color(0xfff3a52e)),
        CircularSegmentEntry(
            double.parse(((total - warning) / total * 100).toString()),
            Color(0xffF0F2F5)),
      ]),
      CircularStackEntry([
        CircularSegmentEntry(
            double.parse((error / total * 100).toString()), Color(0xff25bf4d)),
        CircularSegmentEntry(
            double.parse(((total - error) / total * 100).toString()),
            Color(0xffF0F2F5)),
      ])
    ];

    return data;
  }

  Widget _chart(BuildContext contxt) {
    return Container(
      padding: EdgeInsets.all(15.0),
      child: Column(
        children: <Widget>[
          Container(
            child: Text(
              '资产状态',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            alignment: Alignment.centerLeft,
          ),
          Row(
            children: <Widget>[
              new AnimatedCircularChart(
                key: _chartKey,
                size: const Size(180.0, 180.0),
                initialChartData: data,
                chartType: CircularChartType.Radial,
                edgeStyle: SegmentEdgeStyle.round,
                percentageValues: true,
                holeLabel: (normal + warning + error).toString() + "台",
                labelStyle: TextStyle(fontSize: 18.0, color: Color(0xff000000)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
