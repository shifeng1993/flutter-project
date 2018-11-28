// cmdb首页图表
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../../common/baseStyle.dart';
import '../../../widgets/circular_charts/circular_charts.dart';

class CMDBIndexPageChart extends StatefulWidget {
  CMDBIndexPageChart({
    Key key,
    this.normal,
    this.warning,
    this.error,
  }) : super(key: key);

  final int normal;
  final int warning;
  final int error;

  @override
  _CMDBIndexPageChartState createState() => new _CMDBIndexPageChartState();
}

class _CMDBIndexPageChartState extends State<CMDBIndexPageChart> {
  final GlobalKey<AnimatedCircularChartState> _chartKey =
      new GlobalKey<AnimatedCircularChartState>(); // 图表的globalkey

  List<CircularStackEntry> data; // 图表的data

  int total;
  double cardStatusSize = 32.0;

  List<CircularStackEntry> _generateRandomData() {
    List<CircularStackEntry> data = [
      CircularStackEntry([
        CircularSegmentEntry(
            double.parse((widget.normal / total * 100).toString()),
            BaseStyle.statusColor[1]),
        CircularSegmentEntry(
            double.parse(((total - widget.normal) / total * 100).toString()),
            BaseStyle.statusColor[3]),
      ]),
      CircularStackEntry([
        CircularSegmentEntry(double.parse((widget.warning / total * 100).toString()),
            BaseStyle.statusColor[2]),
        CircularSegmentEntry(
            double.parse(((total - widget.warning) / total * 100).toString()),
            BaseStyle.statusColor[3]),
      ]),
      CircularStackEntry([
        CircularSegmentEntry(double.parse((widget.error / total * 100).toString()),
            BaseStyle.statusColor[0]),
        CircularSegmentEntry(
            double.parse(((total - widget.error) / total * 100).toString()),
            BaseStyle.statusColor[3]),
      ])
    ];

    return data;
  }

  @override
  void initState() {
    super.initState();
    total = widget.normal + widget.warning + widget.error;
    data = _generateRandomData();
  }

  @override
  Widget build(BuildContext context) {
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
          // 左侧图���
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
              holeLabel: (widget.normal + widget.warning + widget.error).toString() + "台",
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
                                '${widget.error.toString()}',
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
                            '宕机${(widget.error / total * 100).toStringAsFixed(1)}%',
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
                                '${widget.normal.toString()}',
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
                            '正常${(widget.normal / total * 100).toStringAsFixed(1)}%',
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
                                '${widget.warning.toString()}',
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
                            '告警${(widget.warning / total * 100).toStringAsFixed(1)}%',
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
}
