// cmdb首页
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';
import 'dart:math' as Math;
import './color_paltte.dart';

class CMDBIndexPage extends StatefulWidget {
  CMDBIndexPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _CMDBIndexPageState createState() => new _CMDBIndexPageState();
}

class _CMDBIndexPageState extends State<CMDBIndexPage> {
  final GlobalKey<AnimatedCircularChartState> _chartKey =
      new GlobalKey<AnimatedCircularChartState>();

  final _chartSize = const Size(300.0, 300.0);
  final Math.Random random = new Math.Random();
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
      padding: EdgeInsets.only(top: 10.0),
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

  List<CircularStackEntry> _generateRandomData() {
    List<CircularStackEntry> data = new List.generate(3, (i) {
      int segCount = random.nextInt(3);
      List<CircularSegmentEntry> segments = new List.generate(segCount, (j) {
        Color randomColor = ColorPalette.primary.random(random);
        return new CircularSegmentEntry(random.nextDouble(), randomColor);
      });
      return new CircularStackEntry(segments);
    });

    return data;
  }

  Widget _chart(BuildContext contxt) {
    return new AnimatedCircularChart(
      key: _chartKey,
      size: _chartSize,
      initialChartData: data,
      chartType: CircularChartType.Radial,
    );
  }
}
