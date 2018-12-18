// cmdb资产/监控
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../../common/baseStyle.dart';
import '../../../utils/mock.dart';

import '../../../widgets/pull_list/index.dart';
import '../../../widgets/shadow_card/index.dart';
import '../../../widgets/shadow_card/card_title.dart';
import '../../../widgets/page_route_Builder/index.dart';

// tab页面需要导航的页面
import './assets_manage.dart'; // 资产管理
import './assets_inspection.dart'; // 资产巡检
import './assets_monitor.dart'; // 资产监控
import './assets_service.dart'; // 业务服务
import './assets_Life.dart'; // 生命周期
import './assets_rank.dart'; // 资产排行

class CMDBAssetsPage extends StatefulWidget {
  CMDBAssetsPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _CMDBAssetsPageState createState() => new _CMDBAssetsPageState();
}

class _CMDBAssetsPageState extends State<CMDBAssetsPage> {
  BuildContext context;
  List<Map<String, dynamic>> flexHeaderList;
  List<Map<String, dynamic>> assetLifeList;
  List<Map<String, dynamic>> assetRankList;

  @override
  void initState() {
    super.initState();
    flexHeaderList = [
      {
        'flex': 1,
        'imgPath': 'assets/icons/cmdb_assets_manage.png',
        'title': '资产管理',
        'onPressed': () {
          Navigator.push(context, RouteBuilder.iosPage(CMDBAssetsManagePage()));
        }
      },
      {
        'flex': 1,
        'imgPath': 'assets/icons/cmdb_assets_inspection.png',
        'title': '资产巡检',
        'onPressed': () {
          Navigator.push(
              context, RouteBuilder.iosPage(CMDBAssetsInspectionPage()));
        }
      },
      {
        'flex': 1,
        'imgPath': 'assets/icons/cmdb_assets_monitor.png',
        'title': '资产监控',
        'onPressed': () {
          Navigator.push(
              context, RouteBuilder.iosPage(CMDBAssetsMonitorPage()));
        }
      },
      {
        'flex': 1,
        'imgPath': 'assets/icons/cmdb_assets_service.png',
        'title': '业务服务管理',
        'onPressed': () {
          Navigator.push(
              context, RouteBuilder.iosPage(CMDBAssetsServicePage()));
        }
      },
    ];
    assetLifeList = _getLifeList();
    assetRankList = _getRankList();
  }

  List<Map<String, dynamic>> _getLifeList() {
    List<Map<String, dynamic>> data = new List.generate(5, (i) {
      i++;
      Map<String, dynamic> row = new Map();
      row['name'] = 'foo,bar';
      row['date'] = Mock.getDateTime();
      row['user'] = 'jonylolo';
      row['status'] = '入库';
      return row;
    });
    return data;
  }

  List<Map<String, dynamic>> _getRankList() {
    List<Map<String, dynamic>> data = new List.generate(5, (i) {
      i++;
      Map<String, dynamic> row = new Map();
      row['name'] = 'foo,bar';
      row['ip'] = Mock.getIP();
      row['type'] = Mock.getCiType();
      row['score'] = Mock.getScore();
      return row;
    });
    return data;
  }

  void _onRefresh(dynamic refreshController, bool up) {
    new Future.delayed(const Duration(milliseconds: 500)).then((val) {
      setState(() {
        assetLifeList = _getLifeList();
        assetRankList = _getRankList();
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
            _headerCard(),
            ShadowCardTitle(
              title: '资产生命周期',
              onPressed: () {
                Navigator.push(
                    context, RouteBuilder.iosPage(CMDBAssetsLifePage()));
              },
            ),
            _assetLife(),
            ShadowCardTitle(
              title: '资产监控排行TOP',
              onPressed: () {
                Navigator.push(
                    context, RouteBuilder.iosPage(CMDBAssetsRankPage()));
              },
            ),
            _assetRank(),
          ],
        ),
      ),
    );
  }

  Widget _headerCard() {
    List<Widget> children =
        (flexHeaderList == null || flexHeaderList.length == 0)
            ? <Widget>[]
            : flexHeaderList.take(4).map((item) {
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

  Widget _assetLife() {
    List<Widget> children = (assetLifeList == null || assetLifeList.length == 0)
        ? <Widget>[]
        : assetLifeList.take(2).map((row) {
            return _assetLifeRow(row, assetLifeList.indexOf(row));
          }).toList(); // 列表使用take限制在5个数量
    return ShadowCard(
      margin: EdgeInsets.only(left: 15, right: 15),
      child: Column(
        children: children,
      ),
    );
  }

  Widget _assetLifeRow(Map<String, dynamic> row, int index) {
    double leftPointSize = 5.0;
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
      decoration: BoxDecoration(
        border: index == 0
            ? null
            : Border(
                top: BorderSide(
                  color: BaseStyle.lineColor[0],
                  width: BaseStyle.pixelWidth(context, 1.0),
                ),
              ),
      ),
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
                      fontSize: BaseStyle.fontSize[4],
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  '资产 ${row['name']} 由 ${row['user']} 于 ${row['date']} ${row['status']}',
                  style: TextStyle(
                    fontSize: BaseStyle.fontSize[4],
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<int> colFlex = [4, 4, 3];

  Widget _assetRank() {
    List<Widget> children = (assetRankList == null || assetRankList.length == 0)
        ? <Widget>[]
        : assetRankList.take(5).map((row) {
            return _assetRankRow(row, assetRankList.indexOf(row), colFlex);
          }).toList(); // 列表使用take限制在5个数量

    TextStyle tableHeadStyle =
        TextStyle(color: Color(0xffffffff), fontSize: BaseStyle.fontSize[2]);
    return ShadowCard(
      margin: EdgeInsets.only(left: 15, right: 15),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 15, bottom: 15),
            height: 50.0,
            decoration: BoxDecoration(
              color: Color(0xffABB0BA),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
              ),
            ),
            child: Row(
              children: <Widget>[
                Container(
                  width: 40.0,
                  child: Center(
                    child: Text('', style: tableHeadStyle),
                  ),
                ),
                Expanded(
                  flex: colFlex[0],
                  child: Center(
                    child: Text('资产名称', style: tableHeadStyle),
                  ),
                ),
                Expanded(
                  flex: colFlex[1],
                  child: Center(
                    child: Text('IP地址', style: tableHeadStyle),
                  ),
                ),
                Expanded(
                  flex: colFlex[2],
                  child: Center(
                    child: Text('资产类型', style: tableHeadStyle),
                  ),
                ),
                Container(
                  width: 50.0,
                  child: Center(
                    child: Text('得分', style: tableHeadStyle),
                  ),
                )
              ],
            ),
          ),
          Container(
            child: Column(
              children: children,
            ),
          )
        ],
      ),
    );
  }

  Widget _assetRankRow(Map<String, dynamic> row, int index, List<int> colFlex) {
    TextStyle tableBodyStyle = TextStyle(
      color: BaseStyle.textColor[0],
      fontSize: BaseStyle.fontSize[4],
    );

    Widget indexView = (index < 3)
        ? Image.asset('assets/icons/rank_num_${(index + 1).toString()}.png',
            width: 19, height: 24)
        : Text((index + 1).toString(),
            style: TextStyle(
                color: BaseStyle.textColor[0],
                fontWeight: FontWeight.w600,
                fontSize: BaseStyle.fontSize[2]));

    return Container(
      height: 50.0,
      decoration: BoxDecoration(
        border: index == 0
            ? null
            : Border(
                top: BorderSide(
                  color: BaseStyle.lineColor[0],
                  width: BaseStyle.pixelWidth(context, 1.0),
                ),
              ),
      ),
      child: Row(
        children: <Widget>[
          Container(
              width: 40.0,
              child: Center(
                child: indexView,
              )),
          Expanded(
            flex: colFlex[0],
            child: Center(
              child: Text(
                row['name'],
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: tableBodyStyle,
              ),
            ),
          ),
          Expanded(
            flex: colFlex[1],
            child: Center(
              child: Text(row['ip'], style: tableBodyStyle),
            ),
          ),
          Expanded(
            flex: colFlex[2],
            child: Center(
              child: Text(row['type'], style: tableBodyStyle),
            ),
          ),
          Container(
            width: 50.0,
            child: Center(
              child: Text(row['score'], style: tableBodyStyle),
            ),
          ),
        ],
      ),
    );
  }
}
