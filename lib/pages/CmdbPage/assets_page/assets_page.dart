// cmdb资产/监控
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../../common/baseStyle.dart';

import '../../../widgets/pull_list/index.dart';
import '../../../widgets/shadow_card/index.dart';
import '../../../widgets/shadow_card/card_title.dart';

class CMDBAssetsPage extends StatefulWidget {
  CMDBAssetsPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _CMDBAssetsPageState createState() => new _CMDBAssetsPageState();
}

class _CMDBAssetsPageState extends State<CMDBAssetsPage> {
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
          print('资产管理');
        }
      },
      {
        'flex': 1,
        'imgPath': 'assets/icons/cmdb_assets_inspection.png',
        'title': '资产巡检',
        'onPressed': () {
          print('资产巡检');
        }
      },
      {
        'flex': 1,
        'imgPath': 'assets/icons/cmdb_assets_monitor.png',
        'title': '资产监控',
        'onPressed': () {
          print('资产监控');
        }
      },
      {
        'flex': 1,
        'imgPath': 'assets/icons/cmdb_assets_service.png',
        'title': '业务服务管理',
        'onPressed': () {
          print('业务服务管理');
        }
      },
    ];
    assetLifeList = [
      {
        'name': 'foo',
        'date': '2018-04-12 12:00:00',
        'user': 'jonylolo',
        'status': '入库'
      },
      {
        'name': 'bar',
        'date': '2018-04-12 12:00:00',
        'user': 'jonylolo',
        'status': '出库'
      },
      {
        'name': 'too',
        'date': '2018-04-12 12:00:00',
        'user': 'jonylolo',
        'status': '不要了'
      },
    ];

    assetRankList = [
      {
        'name': 'foo',
        'ip': '123.123.123.11',
        'type': 'windows',
        'score': '90.0'
      },
      {
        'name': 'foo',
        'ip': '123.123.123.11',
        'type': 'windows',
        'score': '90.0'
      },
      {
        'name': 'foo',
        'ip': '123.123.123.11',
        'type': 'windows',
        'score': '90.0'
      },
      {
        'name': 'foo',
        'ip': '123.123.123.11',
        'type': 'windows',
        'score': '90.0'
      },
      {
        'name': 'foo',
        'ip': '123.123.123.11',
        'type': 'windows',
        'score': '90.0'
      },
    ];
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
            _headerCard(context),
            ShadowCardTitle(
              title: '资产生命周期',
              onPressed: () {
                print('资产生命周期');
              },
            ),
            _assetLife(context),
            ShadowCardTitle(
              title: '资产监控排行TOP',
              onPressed: () {
                print('资产监控排行TOP');
              },
            ),
            _assetRank(context),
          ],
        ),
      ),
    );
  }

  Widget _headerCard(BuildContext context) {
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
        child: Padding(
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

  Widget _assetLife(BuildContext context) {
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
        border: Border(
          top: BorderSide(
            color: BaseStyle.lineColor[0],
            width: index == 0 ? 0.0 : BaseStyle.pixelWidth(context, 1.0),
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<int> colFlex = [4, 4, 3];

  Widget _assetRank(BuildContext context) {
    List<Widget> children = (assetRankList == null || assetRankList.length == 0)
        ? <Widget>[]
        : assetRankList.take(4).map((row) {
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
                  width: 30.0,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('', style: tableHeadStyle),
                  ),
                ),
                Expanded(
                  flex: colFlex[0],
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('资产名称', style: tableHeadStyle),
                  ),
                ),
                Expanded(
                  flex: colFlex[1],
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('IP地址', style: tableHeadStyle),
                  ),
                ),
                Expanded(
                  flex: colFlex[2],
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('资产类型', style: tableHeadStyle),
                  ),
                ),
                Container(
                  width: 50.0,
                  child: Align(
                    alignment: Alignment.centerLeft,
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
    TextStyle tableBodyStyle =
        TextStyle(color: Color(0xffffffff), fontSize: BaseStyle.fontSize[4]);


    Widget indexView = (index < 3) ? Image.asset('assets/icons/rank_num_${(index + 1).toString()}.png') : Text(index.toString(), style: TextStyle(color: Color(0xffffffff), fontSize: BaseStyle.fontSize[2]));

    return Container(
      padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: BaseStyle.lineColor[0],
            width: BaseStyle.pixelWidth(context, 1.0),
          ),
        ),
      ),
      child: Row(
        children: <Widget>[
           Container(
                  width: 30.0,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: indexView,
                  ),
                ),
          Expanded(
            flex: colFlex[0],
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text('资产名称', style: tableBodyStyle),
            ),
          ),
          Expanded(
            flex: colFlex[1],
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text('IP地址', style: tableBodyStyle),
            ),
          ),
          Expanded(
            flex: colFlex[2],
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text('资产类型', style: tableBodyStyle),
            ),
          ),
          Container(
            width: 50.0,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text('得分', style: tableBodyStyle),
            ),
          ),

          // Text(
          //   '公告：',
          //   style: TextStyle(
          //       fontSize: BaseStyle.fontSize[4],
          //       fontWeight: FontWeight.w600),
          // ),
          // Text(
          //   '资产 ${row['name']} 由 ${row['user']} 于 ${row['date']} ${row['status']}',
          //   style: TextStyle(
          //     fontSize: BaseStyle.fontSize[4],
          //   ),
          // ),
        ],
      ),
    );
  }
}
